From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Mon, 22 Nov 2010 14:29:32 +0100
Message-ID: <vpq8w0lqyf7.fsf@bauges.imag.fr>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<vpqoc9hsemy.fsf@bauges.imag.fr>
	<201011221414.15982.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Nov 22 14:30:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWT3-0002Bd-DQ
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 14:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab0KVN34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 08:29:56 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47541 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab0KVN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 08:29:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oAMDDXbO014443
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Nov 2010 14:13:34 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PKWSa-0003Nz-Ci; Mon, 22 Nov 2010 14:29:32 +0100
In-Reply-To: <201011221414.15982.trast@student.ethz.ch> (Thomas Rast's message of "Mon\, 22 Nov 2010 14\:14\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Nov 2010 14:13:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oAMDDXbO014443
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1291036415.34387@mjNA/x0IylMzQldU6nbZQw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161891>

Thomas Rast <trast@student.ethz.ch> writes:

> Matthieu Moy wrote:
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>> 
>> > Remove the undocumented and unused '--verify' flag from interactive
>> > rebase.
>> 
>> I don't think this change is good. If a command has a --no-whatever
>> flag, one expects the --whatever flag to exist too, even if it's a
>> no-op.
> [...]
>> I think a better change would be to add a comment like
>> 
>> --verify)
>> 	# no-op, exists because --no-verify exists too.
>
> Shouldn't that be
>
>   OK_TO_SKIP_PRE_REBASE=
>
> instead, so that it undoes the effect of an earlier --no-verify?

Yes, right. Useful when an alias contains --no-whatever in particular.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
