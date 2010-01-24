From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git notes: notes
Date: Sun, 24 Jan 2010 15:20:09 +0100
Message-ID: <vpq7hr7zism.fsf@bauges.imag.fr>
References: <20100120050343.GA12860@gnu.kitenet.net>
	<201001201148.11701.johan@herland.net>
	<20100120182438.GB31507@gnu.kitenet.net>
	<7vhbqg376b.fsf@alter.siamese.dyndns.org>
	<20100120195626.GA6641@gnu.kitenet.net>
	<7vska01qrt.fsf@alter.siamese.dyndns.org>
	<4B576F5C.2050102@drmicha.warpmail.net>
	<7veilk1o3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 15:21:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ3LX-0008TQ-3T
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 15:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0AXOU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 09:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590Ab0AXOU3
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 09:20:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49555 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab0AXOU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 09:20:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0OEJGJc008811
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Jan 2010 15:19:16 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NZ3Jx-00071H-Rl; Sun, 24 Jan 2010 15:20:09 +0100
In-Reply-To: <7veilk1o3s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 20 Jan 2010 13\:08\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 24 Jan 2010 15:19:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0OEJGJc008811
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264947557.27084@VLvmaaD3rwcGfKIlMuC2Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137899>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> No, but outputting the note as part of the log is the standard. So for
>> example, when you do a format-patch | apply cycle, format-patch will
>> insert the note as part of the commit message, and apply will *store*
>> the note text (including Note:\n) as part of the commit message of the
>> new commit.
>
> Thanks; that was the kind of breakage report I was looking for (and wished
> to have heard a lot earlier).  Personally I find it is unexcusable that
> format-patch defaults to giving notes.

OTOH, format-patch could give the notes, below the ---, where it will
be ignored by apply. That would make notes handy to prepare a patch
serie with additional messages: prepare everything within Git, and use
git send-email to send it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
