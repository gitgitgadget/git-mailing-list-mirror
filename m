From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] remove "nohup" from git-help--browse
Date: Sat, 9 Feb 2008 06:53:43 +0100
Message-ID: <200802090653.43280.chriscool@tuxfamily.org>
References: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org> <1202502982-6822-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiZj-0005pV-B2
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbYBIFro convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 00:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYBIFro
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:47:44 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:37023 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbYBIFrn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 00:47:43 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4BCAD1AB2BF;
	Sat,  9 Feb 2008 06:47:42 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 11DB71AB2BC;
	Sat,  9 Feb 2008 06:47:42 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <1202502982-6822-1-git-send-email-dpotapov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73195>

Le vendredi 8 f=E9vrier 2008, Dmitry Potapov a =E9crit :
> There is no good reason to run GUI browsers using "nohup". It does no=
t
> solve any real problem but creates annoying "nohup.out" files in ever=
y
> directory where git help -w is run.

That's right, but if you just remove "nohup", then there may be some=20
annoying browser output on the terminal. Perhaps we should also redirec=
t=20
stderr and stdout to /dev/null.

> This patch removes "nohup" from git-help--browse.sh

"git-help--browse.sh" has been renamed "git-web--browse.sh" in next so =
we=20
need a similar patch for next.

Thanks,
Christian.=20
