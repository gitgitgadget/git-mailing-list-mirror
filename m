From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn clone cannot go beyond a specific rev on codeplex
Date: Fri, 13 May 2016 17:21:38 +0000 (UTC)
Message-ID: <850545563.3152522.1463160098080.JavaMail.yahoo@mail.yahoo.com>
References: <850545563.3152522.1463160098080.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: Hin-Tak Leung <htl10@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Fri May 13 19:28:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Gt2-0007o4-RX
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 19:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802AbcEMR2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 13:28:24 -0400
Received: from nm30-vm6.bullet.mail.ir2.yahoo.com ([212.82.97.84]:36296 "EHLO
	nm30-vm6.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753540AbcEMR2Y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 13:28:24 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 May 2016 13:28:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1463160098; bh=42Far9106s4GyiTlVOORQEPZuASOpiwxyluCU/pKL34=; h=Date:From:Reply-To:To:Cc:Subject:References:From:Subject; b=Gp/VWrLExhHRWuzEy4jgBICHiXScTT1BPuV296RyKMb08F0Kjt15D/rWYMHJF4Go4WnJ521yD5t5f0Av+Gp+P5HbVuFPSrHRldB7HHsXcPz+giPYlXoxn2dWdy4ygCRH8B21jCPB/152vztHIZusa64vl+OExBavRohQiz3tNdPQEuQGDIWFoUInnDdGdNdG/JX2gzWliyRWS9+oqDv7vJ+iHyiq1fi+uEMJl0+Rts1XYnFLru72+Fsfq7ahWJqcdLsax9cxPyYmjC2IseZdcLmjp9Fjpe5w2YXwBg5uAuWsuTWIN/zMRThrCfktjFpaHbD4VtLUI2pgoJCnhFYI+A==
Received: from [212.82.98.62] by nm30.bullet.mail.ir2.yahoo.com with NNFMP; 13 May 2016 17:21:38 -0000
Received: from [212.82.98.99] by tm15.bullet.mail.ir2.yahoo.com with NNFMP; 13 May 2016 17:21:38 -0000
Received: from [127.0.0.1] by omp1036.mail.ir2.yahoo.com with NNFMP; 13 May 2016 17:21:38 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 953009.66172.bm@omp1036.mail.ir2.yahoo.com
X-YMail-OSG: 2BemLskVM1ku9Q0LvUyaKOvw1HTZVpg..3_q0BJkKfnAnDNYnYBrjR1aMH9gew5
 jwd_YOae5oKc7ImVahVMA8rShYN69F_Pu0X5gvPsop2rQs7ZxpSY2_YPBeOiqHLq_b6stEtcG9Uq
 aOM58t37C8W.NRrp1gJ9no9aijUiHj_j2g4fEX.Hz8AqXLFOxUKzyVCcq.G8EKRJ6sF3HLl.WHTE
 YJQVRy4yggqGeP63iIJZniGRbNH_kTuQD2DL39h9xpAyG5mi_lpfOJpBW8dLKU.4TQ.ayBnttosg
 UmQcyCz7FaAnCzOY2fngeve1cTt..4CUaxfeHKXQ_SF3LSwhDu2.oVdumKXeX6dWjBwkQlM8Yvwv
 r.LhXSZFXMIGQ_ar8d8xcH27tBgc1JeJTpV8_TGb4bffYZ2eZsolMqp_s86Rc0r2JW08KB545a8v
 .iUW5Edi1QRJu33h0yrhpPP9ce6FlB6OFT4BlSTjFkHYXsCy5CNLVxuHz217e3lywqptktbnA7v_
 GITcsME70eg36U6U-
Received: from jws11128.mail.ir2.yahoo.com by sendmailws165.mail.ir2.yahoo.com; Fri, 13 May 2016 17:21:38 +0000; 1463160098.455
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294547>

--------------------------------------------
On
 Fri, 13/5/16, Eric Wong <e@80x24.org> wrote:

 Hin-Tak Leung <htl10@users.sourceforge.net>
 wrote:
 > I tried bin-wrappers/ from
 current git HEAD.
 >=20
 >
 $ git describe
 > v2.8.2-396-g5fe494c
=20
> Which SVN version?=C2=A0=C2=A0=C2=A0 `git
 svn --version`



$ git svn --version
git-svn version 2.5.5 (svn 1.9.3)

Argh, bin-wrappers/ does not set PERL5LIB to the not-yet-installed perl=
=20
modules, or does it depend on the host version of svn? Oh, of course it=
 is using the host's - the error says so... sorry about that.


=20
 >
 bin-wrappers/git svn clone https://ironpython.svn.codeplex.com/svn
 ironpython-old-codeplex
 >=20
 > always fails at this rev:
 >=20
 > =C2=A0=C2=A0=C2=A0 M=C2=A0=C2=A0=C2=A0
 Src/Tests/test_re.py
 > r7605 =3D
 e581bc66eda2b86bf46681191034844c4ba7d7a5
 (refs/remotes/git-svn)
 > Connection reset
 by peer: Error running context: Connection reset by peer at
 /home/Nobak-Hin-Tak/tmp-git/git/perl/blib/lib/Git/SVN/Ra.pm
 line 312.
=20
 Can you resume
 with "git svn fetch" ?


No - or maybe I was not patient enough? I did try resuming - I tried=20
clone'ing twice, then a separate init/fetch, and another clone; and=20
resume on at least two of those. It seems to hang, so I did ctrl-C afte=
r
 a minute or two. I'll give it another try now, and let it run for a=20
reasonably long time.

$ time git svn fetch --all
Connection reset by peer: Error running context: Connection reset by pe=
er at /usr/share/perl5/vendor_perl/Git/SVN/Ra.pm line 308.


real	9m15.951s
user	0m1.018s
sys	0m0.453s

trying to resume fetch get the same error after 9 minutes.
