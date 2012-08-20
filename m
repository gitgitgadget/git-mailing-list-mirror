From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Sun, 19 Aug 2012 23:51:26 -0700
Message-ID: <7vboi6m4y9.fsf@alter.siamese.dyndns.org>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
 <7v1uj3qthh.fsf@alter.siamese.dyndns.org> <1613947.h8N3CdhuYo@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Lpm-0005rs-Le
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 08:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156Ab2HTGva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 02:51:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2HTGv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 02:51:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA15A4B62;
	Mon, 20 Aug 2012 02:51:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=okEg+BfekrDxIHPkA0mgr4vq2Sw=; b=W0EZ6s
	B5A8DivJZD3P61oztYeoPFExy+VNEfznAMYEeRA+QAR8yefDKaF5ZTImk9tM/0ZU
	oVX6ddarJdu2Iwtb78eGSU0gbL4HsA5297/7OCcaOWlFEkFW3SXSucHS5Alyy1I0
	0+y/elLqHMvtOteUcyMjE8DZei1vntJSPxytk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TAC8Mt2WJdk8tGH2Kk9amvbVQx1w5LY4
	87HhKaenMi0w+6LyotLPWlSxOomJCIcov7NLIMy90lCCCmhdIjRdo9xEM99T5loa
	uHumvgiU5E4wlBptwXN3NZDY34KX6cks4L2XTJlIvvFL05vDlvO3aw4pB5Shj4lb
	rDpupHLR448=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79194B61;
	Mon, 20 Aug 2012 02:51:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35A9D4B60; Mon, 20 Aug 2012
 02:51:28 -0400 (EDT)
In-Reply-To: <1613947.h8N3CdhuYo@flomedio> (Florian Achleitner's message of
 "Mon, 20 Aug 2012 08:21:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7768DD54-EA93-11E1-8E5F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203761>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> On Saturday 18 August 2012 23:35:38 Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> [..]
>> Just to show how, here is what I did just now.
>> [..] 
>> Thanks.
>
> Thanks for you guidance!
> I'll base a new version on your fixups.

Just to make sure...

Please do _not_ use fixups as-is, but squash them into the
appropriate places where the problems they fix are first introduced.

Thanks.
