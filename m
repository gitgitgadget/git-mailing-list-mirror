From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Sun, 9 Jul 2006 14:41:15 +0200
Organization: NextSoft
Message-ID: <200607091441.16161.michal.rokos@nextsoft.cz>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <20060709095114.GQ22573@lug-owl.de> <7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 14:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzYbL-0004f1-RS
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 14:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWGIMl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 9 Jul 2006 08:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWGIMl1
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 08:41:27 -0400
Received: from s3.icr.cz ([82.142.72.7]:23527 "EHLO s3.icr.cz")
	by vger.kernel.org with ESMTP id S1030473AbWGIMl0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 08:41:26 -0400
Received: (from root@localhost)
	by s3.icr.cz (8.11.4/8.11.4) id k69CfHV10109;
	Sun, 9 Jul 2006 14:41:17 +0200
Received: from michal.rokos.cz (mx1.evangnet.cz [88.83.237.35] (may be forged))
	by s3.icr.cz (8.11.4/8.11.4) with ESMTP id k69CfGS10069;
	Sun, 9 Jul 2006 14:41:16 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net>
X-scanner: scanned by Inflex 1.0.10 - (http://pldaniels.com/inflex/)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23547>

Hello,

On Sunday 09 July 2006 12:14, Junio C Hamano wrote:
> Michal, is there a reason you do not want to have the version of
> perl you teach git tools via #! lines with PERL_PATH on your $PATH?

I have no problem with that. I can set $PATH.
But then I'd suggest to change magic #!
from #!/usr/bin/perl
to #!/usr/bin/env perl
for *.perl

It that what you meant?

M.

PS: Please note that
#!/usr/bin/env perl -w
will not work on some platforms (at least on HP-UX)...
--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
