From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too early
Date: Mon, 28 Jun 2010 22:42:26 -0700
Message-ID: <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
References: <20100626192203.GA19973@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 07:42:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTTas-0007m1-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 07:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456Ab0F2Fmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 01:42:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab0F2Fmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 01:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F275BFAC6;
	Tue, 29 Jun 2010 01:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FOdVS1igVcFgh74WARQUHiS4s1s=; b=ehA1E3
	fpm2PPY7dRVEpTcPDpVQEJ+T5tTnyrL/ab5rR5wa6iWzfcCeSJxmEK+zEBgWWhIH
	radgFbLMbyvo7x7wrHNerJPI0ZWShLhT9nwXVQ80jv8r/TBpzglL34vLTFfEkxm+
	UYpVWhU8Z7U09r/TbEqidjSDQsJg/6Hsr3feQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=StnWLznwjwUjyhDfp0zgYrvaDRt4emQW
	cT+p9UXN0xrngWZwv3OPsdr+n68oMRxd4AtbD98YH4bt94wU3mE6DBrWK+XNKGUP
	PnkBBscCf27KlyLnkVGJo4M/0dgk/49ojVL+CQAnM4MQje5UQwXz8J44QLpxs35D
	QQAsyOeSbAg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F4165BFAC5;
	Tue, 29 Jun 2010 01:42:32 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3114CBFAC4; Tue, 29 Jun
 2010 01:42:28 -0400 (EDT)
In-Reply-To: <20100626192203.GA19973@burratino> (Jonathan Nieder's message of
 "Sat\, 26 Jun 2010 14\:22\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D28B898-8341-11DF-A914-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149883>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Patch is against master.  There is a small semantic conflict with
> jn/grep-open: SIMPLEPAGER should be changed to SIMPLEPAGERTTY in the
> prerequisites for the test_default_pager function.  Please let me
> know if I should push a merge commit to help resolve that.

Thanks for advance warning; please double check the merge result in 'pu'
when I push it out...
