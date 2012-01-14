From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Commit changes to remote repository
Date: Sat, 14 Jan 2012 15:27:29 +0100
Message-ID: <vpqboq6fjfy.fsf@bauges.imag.fr>
References: <1326486589088-7185551.post@n2.nabble.com>
	<20120114113141.GG2850@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ruperty <rupert@moonsit.co.uk>, git@vger.kernel.org
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 15:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm4ar-0004rm-UD
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 15:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350Ab2ANO2C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 09:28:02 -0500
Received: from mx2.imag.fr ([129.88.30.17]:40092 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab2ANO2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 09:28:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0EEPrSb027432
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 14 Jan 2012 15:25:53 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rm4Zt-0002Nb-AU; Sat, 14 Jan 2012 15:27:29 +0100
In-Reply-To: <20120114113141.GG2850@centaur.lab.cmartin.tk> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Sat, 14 Jan 2012 12:31:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 14 Jan 2012 15:25:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0EEPrSb027432
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1327155955.56278@sp6WAGOW0BWKFiInytCpGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188569>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> You're trying to push to a non-bare repository and change the
> currently active branch, which can cause problems, so git isn't
> letting you. There's an explanation of bare and non-bare at
> http://bare-vs-nonbare.gitrecipes.de/ but the short and sweet is that
> you should init the repo you want to use as the central point with
> --bare and do modifications locally and then push there.

An alternative is to push to a temporary, non-checked-out branch.

I sometimes do

  laptop$ git push desktop HEAD:incomming

and then

  desktop$ git merge incomming

The push does not disturb the worktree on the desktop, and the merge is
done manually on the receiving machine.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
