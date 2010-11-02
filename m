From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git stash and manually edited chunks
Date: Tue, 02 Nov 2010 10:02:37 +0100
Message-ID: <vpqd3qoxfma.fsf@bauges.imag.fr>
References: <AANLkTik6esqP2EkA6SFmfS0zdokG1iTKXqivA2wnpq=9@mail.gmail.com>
	<vpqfwvlkmkv.fsf@bauges.imag.fr>
	<AANLkTiknhRGuBMFEKbVdyN83SiF9j2nNz=v-nMaD-iTb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olivier Verdier <zelbier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 10:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDClV-0003VG-7O
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 10:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab0KBJCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 05:02:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37689 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab0KBJCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 05:02:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA28ldT3030770
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 09:47:39 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PDClJ-0002dC-LM; Tue, 02 Nov 2010 10:02:37 +0100
In-Reply-To: <AANLkTiknhRGuBMFEKbVdyN83SiF9j2nNz=v-nMaD-iTb@mail.gmail.com> (Olivier Verdier's message of "Tue\, 2 Nov 2010 09\:37\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Nov 2010 09:47:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA28ldT3030770
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289292463.03627@btCIounVMbxsuz9IgTIdJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160512>

Olivier Verdier <zelbier@gmail.com> writes:

> Thank you,
>
> but that does not explain why there is a conflict *only* when I edit
> the chunk manually, does it?

It does.

If you did not edit the hunk manually, each hunk will be either in
state HEAD or in state A, and applying the diff between HEAD and A to
such file will be either a no-op (hunk already applied), or a
successfull application.

> Besides, some people tried to reproduce my problem on Linux and they
> got no conflict after edited chunks.

I did, on Linux. I get the same behavior as you.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
