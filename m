From: "Harald Heigl" <Harald@heigl-online.at>
Subject: What to do if the path of my git submodules change upstream
Date: Wed, 16 Nov 2011 15:37:55 +0100
Message-ID: <000301cca46d$5428c3d0$fc7a4b70$@heigl-online.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 15:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQgcm-0000Gg-NP
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 15:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412Ab1KPOh7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 09:37:59 -0500
Received: from xserv02.internex.at ([85.124.51.102]:57889 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932118Ab1KPOh7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 09:37:59 -0500
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 24334 invoked from network); 16 Nov 2011 14:37:56 -0000
Received: by simscan 1.4.0 ppid: 24321, pid: 24331, t: 0.0675s
         scanners: clamav: 0.97/m:54/d:13952
Received: from unknown (HELO setnbheh) (Harald@heigl-online.at@84.115.25.240)
  by xserv02.internex.at with SMTP; 16 Nov 2011 14:37:56 -0000
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AcykbVOUYs4xONHxR4alkgelAa20AA==
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185551>

Hi everyone!

=46irst setup of my git was a server (with ssh) and some clients.

Today I changed to gitolite because I wanted a more sophisticated way o=
f
managing my repos. So far so good=85
So the old path =93ssh://[ip]/[fullpath].git=94 would change to a new p=
ath
=93git@[servername]:[gitreponame]=94.=20
This is no problem for =93normal=94 repos, I change the remote origin a=
nd
continue using push and pull.

I have some submodules:
I changed the .gitmodules to reflect my changes, did a git submodule sy=
nc.
This works flawlessly too!

But what if someone wants to checkout an older version of the project? =
(for
comparison, or because he/she wanted to try something out)
He would get an old .gitmodules with old paths.
After a git submodule sync he would get errors, because old paths won=92=
t work
anymore, because I changed some paths on the server=20

It is only one project I have this problem and therein I changed the
=2Egitmodules only 3 times. Is it possible to rewrite .gitmodules on th=
ese
specific =A0commits on the server (perhaps with git-filter-branch)?
Or is there another easy solution? Has someone ever had this problem?

Hope you can help,
Kind regards,
Harald Heigl
