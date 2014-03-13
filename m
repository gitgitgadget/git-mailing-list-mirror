From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wt-status: i18n of section labels
Date: Thu, 13 Mar 2014 11:01:52 -0700
Message-ID: <xmqqvbviht9r.fsf@gitster.dls.corp.google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
	<20131219104613.GA18379@x230-buxy.home.ouaza.com>
	<20131219194319.GB20443@google.com>
	<xmqqa9cvmeod.fsf@gitster.dls.corp.google.com>
	<xmqqtxb3kyr2.fsf_-_@gitster.dls.corp.google.com>
	<5320BE1C.9020307@savoirfairelinux.com>
	<xmqq1ty7kwfp.fsf@gitster.dls.corp.google.com>
	<5320C0DD.1090803@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Raphael Hertzog <hertzog@debian.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:02:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO9xD-0004Vu-HI
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 19:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbaCMSB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 14:01:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166AbaCMSBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 14:01:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1772073B06;
	Thu, 13 Mar 2014 14:01:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NFgWU7H78rs2hClmSb1HuyaoTkI=; b=jwlSyT
	2aMivldtmJaQ+Sakau3UIukP5MmQCjU2aZwj8UbCe+/ybZEJiH/B+N4I8pnS4yDR
	zfoUdGUzz/i4PSrEUb8h1MGjKEz9zRgyk6eOLEHa74gJezonrEog5TxYSc6PGV/Y
	aE8jp8CoxNpOTMLhzS1ZE4UeIeaQ4dPWcCFPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D7dk/AOmEgdlVwBfL8tci5LR5/Nw7T3Y
	tQ533yrzEHGDN3hqDTAP6f3WAKHuN3VUfIIfMBgIB+aTvMupsRl091E1rhm3BAS4
	sAeIm/iyrjGseIaLU5c4kz27y6FCjBHiC8anR2FGMoP7nVUJdj2qKoy5EDqt8EWS
	GaKEA1GdZ7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 010B673B05;
	Thu, 13 Mar 2014 14:01:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E4BC73B03;
	Thu, 13 Mar 2014 14:01:54 -0400 (EDT)
In-Reply-To: <5320C0DD.1090803@savoirfairelinux.com> (Sandy Carter's message
	of "Wed, 12 Mar 2014 16:17:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F7E6FC8-AAD9-11E3-80B8-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244042>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> I refered to the wrong lines, the ones I was refering to were:
>
>> +static int maxwidth(const char *(*label)(int), int minval, int maxval)
>> +{
>> +	int result = 0, i;
>> +
>> +	for (i = minval; i <= maxval; i++) {
>> +		const char *s = label(i);
>> +		int len = s ? utf8_strwidth(s) : 0;
>
> Sorry about that

Oh, yes, you are right.  wt_status_diff_status_string() is meant to
be asked with a bogus status character and expected to return NULL,
so diagnosing anything it does not understand as a "bug" is indeed a
bug I added.

I think I fixed in my latest reroll ($gmane/243996).

Thanks for catching that.
