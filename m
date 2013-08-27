From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] Improve font rendering on retina macbooks
Date: Tue, 27 Aug 2013 20:10:31 +0100
Message-ID: <87vc2rdk60.fsf@fox.patthoyts.tk>
References: <CAMtfEwTGTCKhuFK116-z2ePE70T1iXdPx7BB1xLxRdfsAfws=Q@mail.gmail.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mads =?iso-8859-1?Q?D=F8rup?= <mads@dorup.dk>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOf1-0002WD-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab3H0TKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 15:10:36 -0400
Received: from know-smtprelay-omc-1.server.virginmedia.net ([80.0.253.65]:55173
	"EHLO know-smtprelay-omc-1.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab3H0TKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 15:10:35 -0400
Received: from fox.patthoyts.tk ([94.171.229.22])
	by know-smtprelay-1-imp with bizsmtp
	id HvAZ1m00Y0VeUS601vAZTR; Tue, 27 Aug 2013 20:10:33 +0100
X-Originating-IP: [94.171.229.22]
X-Spam: 0
X-Authority: v=2.0 cv=A800pNqG c=1 sm=1 a=qXJDgLqI18Q8M6O+O33hhA==:17
 a=F0HhOJWMmYsA:10 a=vIoWlpIS1WMA:10 a=CtgcEeagiGAA:10 a=8nJEP1OIZ-IA:10
 a=FP58Ms26AAAA:8 a=oJkSE-2d8ysA:10 a=NEAV23lmAAAA:8 a=Rf460ibiAAAA:8
 a=MSedERPdp2gypr6vRCkA:9 a=wPNLvfGTeEIA:10 a=qXJDgLqI18Q8M6O+O33hhA==:117
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E8A6220181; Tue, 27 Aug 2013 20:10:32 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <CAMtfEwTGTCKhuFK116-z2ePE70T1iXdPx7BB1xLxRdfsAfws=Q@mail.gmail.com>
	("Mads =?iso-8859-1?Q?D=F8rup=22's?= message of "Sun, 21 Jul 2013 14:23:48
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233139>

Mads D=F8rup <mads@dorup.dk> writes:

>Hi there
>
>I've created a very small change to git gui that considerably improves=
 the
>experience on my machine at least:
>
>diff --git a/git-gui/macosx/Info.plist b/git-gui/macosx/Info.plist
>index b3bf15f..1ade121 100644
>--- a/git-gui/macosx/Info.plist
>+++ b/git-gui/macosx/Info.plist
>@@ -24,5 +24,7 @@
>=A0 =A0 =A0 =A0 <string>GITg</string>
>=A0 =A0 =A0 =A0 <key>CFBundleVersion</key>
>=A0 =A0 =A0 =A0 <string>@@GITGUI_VERSION@@</string>
>+ =A0 =A0 =A0 <key>NSHighResolutionCapable</key>
>+ =A0 =A0 =A0 <true/>
>=A0</dict>
>=A0</plist>
>
>
>I've read the documentation for submitting patches to git where it say=
s that I
>have to e-mail the patch to the mail list, with relevant developers as=
 CC. Pat
>are you the relevant developer for this?
>
>Here is a screenshot comparison of before and after the change:
>
>https://github.com/git/git/pull/48
>
>Please let me know how to proceed to get this patch in, if you like it=
=2E I've
>never contributed here before, so please me know about any procedures =
I have
>missed.
>
>Regards, Mads D=F8rup

Looks like it makes a big difference from those pictures. Patch
applied. Thank you.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
