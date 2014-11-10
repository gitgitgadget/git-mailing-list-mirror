From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git_connect: set ssh shell command in GIT_SSH_COMMAND
Date: Mon, 10 Nov 2014 08:54:58 -0800
Message-ID: <xmqqr3xb9esd.fsf@gitster.dls.corp.google.com>
References: <20141108110958.GB20750@peff.net>
	<20141108123554.GA90057@melamine.cuivre.fr.eu.org>
	<20141108142753.GA28652@melamine.cuivre.fr.eu.org>
	<20141109095155.GB17369@peff.net>
	<20141109123934.GA50956@melamine.cuivre.fr.eu.org>
	<xmqq389se0up.fsf@gitster.dls.corp.google.com>
	<20141109174738.GA58680@melamine.cuivre.fr.eu.org>
	<xmqqppcwb6ip.fsf@gitster.dls.corp.google.com>
	<20141109224231.GA59064@melamine.cuivre.fr.eu.org>
	<20141110071154.GD7677@peff.net>
	<20141110082858.GA71642@melamine.cuivre.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Quinot <thomas@quinot.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 17:55:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnsFF-00052U-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 17:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbaKJQzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 11:55:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751918AbaKJQzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 11:55:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E76451B663;
	Mon, 10 Nov 2014 11:54:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=whKHGj4kK3vTVqt6glsL8G9sSOA=; b=k4443T
	1zxjHmKCrymzQjA5VfObDicVIIazopIDRkuk9fsrhXWvTFtSpersMySzZZ+npSnL
	90WaD1kq7YKHI3InaJgDMmTWI/EufPsezuP55CYuKjkNyy4QAdAVzl2VfpW68Vv7
	yigBdqoVMts3dakUKbqUM66g1iUxKr1A8+t20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFsETfWlUI2sMu3Bit8MpdqkBmJkc7iS
	pZzcLaiIVN0mFLwpAdcAJKEvq7ooWAm1nXkYaHO9rEYDexj//aWbQ61gLskeBLM8
	/jN/n8bLkk6rQoAJtdnIGWyWQqgLmDyvvJQ7UqhlAe74lphzSEg2pVI0DIpyzL7C
	CkdH3CD5OeQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF6631B662;
	Mon, 10 Nov 2014 11:54:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55F5A1B660;
	Mon, 10 Nov 2014 11:54:59 -0500 (EST)
In-Reply-To: <20141110082858.GA71642@melamine.cuivre.fr.eu.org> (Thomas
	Quinot's message of "Mon, 10 Nov 2014 09:28:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E5A7B60-68FA-11E4-BC0F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Quinot <thomas@quinot.org> writes:

> * Jeff King, 2014-11-10 :
>
>> I think this version looks good. Thanks for working on it.
>
> Thanks!
>
>> Two style micro-nits (that I do not think even merit a re-roll by
>> themselves, but Junio may want to mark up as he applies):
>
> OK, committed locally, I can resend a PATCH v5 if that's more
> convenient -- do let me know.

Locally tweaked while queuing.

Thanks both.
