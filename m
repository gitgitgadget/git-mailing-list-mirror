From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: t3900-i18n-commit.sh problem on Solaris
Date: Tue, 4 Mar 2008 10:51:33 -0500
Message-ID: <8ec76080803040751y4bf808f9ma83a9faa4f857039@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 16:52:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZRS-0001GT-GP
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbYCDPvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2008 10:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755747AbYCDPvm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:51:42 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:39187 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556AbYCDPvk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 10:51:40 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1281361wra.13
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 07:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7ly/4mTQiMidoqHiCIMDxV99+BM0sTu7ntV7s5Ta7lY=;
        b=F6nbxqPw8WSTJ4vggQZYd4nYuxjRMCgdduGAxdQrNPcnEa6FeQG5QowdBY5jf5trwox5G0NnDUGQIf/kp3vVOhk9eSCJ/1r+0Vy+3+g+C118lvdH+KTipJjFoukyDSLqomqSu5NyWgVV4zVVrdqlgoa45O6NIS+ZbRtfCRLpA4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eJSCGI8hj+R+yflKojMatp76CQvwavB+sxHLubk8PBMqhntlQ7hDObZ8+l7RBhT2gO97zMpksP8o/io1SnyJynnuclK+tP8bmPkf3HhcV+XNoAdRdYHdxdSKVHbKUDqu/gFEoLGsfIbI4cGA3NRiP0SKDTS4ImAo2tUJK8p3A2g=
Received: by 10.141.142.15 with SMTP id u15mr522398rvn.66.1204645893963;
        Tue, 04 Mar 2008 07:51:33 -0800 (PST)
Received: by 10.141.201.19 with HTTP; Tue, 4 Mar 2008 07:51:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76103>

this is with git latest: c95b3ad9ea310ec89e31a21edecaaf2c374e2c46
(GIT_VERSION =3D 1.5.4.3.447.gc95b3)


xs5-trd-p1.grn:warmstro> sh t3900-i18n-commit.sh -i -v
=2E..
=2E..
=2E..

* expecting success:
                compare_with ISO-2022-JP ../t3900/2-UTF-8.txt

diff --git a/current b/../t3900/2-UTF-8.txt
*   ok 20: ISO-2022-JP should be shown in UTF-8 now

* expecting success:
                        compare_with EUCJP ../t3900/EUCJP.txt

diff --git a/current b/../t3900/EUCJP.txt
*   ok 21: EUCJP should be shown in EUCJP now

* expecting success:
                        compare_with ISO-2022-JP ../t3900/EUCJP.txt

diff --git a/current b/../t3900/EUCJP.txt
index 74b5330..546f2aa 100644
--- a/current
+++ b/../t3900/EUCJP.txt
@@ -1,4 +1,4 @@
-$O$l$R$[$U
+=A4=CF=A4=EC=A4=D2=A4=DB=A4=D5

-$7$F$$$k$N$,!"$$$k$N$G!#
-_@IM$[$l$W$j$]$l$^$S$0$j$m$X!#
+=A4=B7=A4=C6=A4=A4=A4=EB=A4=CE=A4=AC=A1=A2=A4=A4=A4=EB=A4=CE=A4=C7=A1=A3
+=DF=C0=C9=CD=A4=DB=A4=EC=A4=D7=A4=EA=A4=DD=A4=EC=A4=DE=A4=D3=A4=B0=A4=EA=
=A4=ED=A4=D8=A1=A3
* FAIL 22: ISO-2022-JP should be shown in EUCJP now

                                compare_with ISO-2022-JP ../t3900/EUCJP=
=2Etxt

xs5-trd-p1.grn:warmstro>


Is this a Solaris problem?

here is the machine info:
xs5-trd-p1.grn:warmstro> uname -a
SunOS xs5-trd-p1.grn.tudor.com 5.9 Generic_118558-38 sun4u sparc
SUNW,Sun-Fire-V240 Solaris
xs5-trd-p1.grn:warmstro>

Thanks,
Whit
