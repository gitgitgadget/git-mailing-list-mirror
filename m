From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] example patch corrupted by thunderbird
Date: Mon,  9 Feb 2009 13:00:10 -0600
Message-ID: <DeLj68ft_x4lptmQlhZ5lQ5LBbgPdNcz06DmtnLJcFKD5nu8axMNuOaPuPCY01o2T5l4qnB7a3o@cipher.nrlssc.navy.mil>
References: <499058B4.4070009@beonex.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git@drmicha.warpmail.net,
	jwhite@codeweavers.com, Johannes.Schindelin@gmx.de,
	bss@iguanasuicide.net, Brandon Casey <casey@nrlssc.navy.mil>
To: ben.bucksch.news@beonex.com
X-From: git-owner@vger.kernel.org Mon Feb 09 20:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbay-0007DB-9F
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbZBITNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:13:38 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZBITNg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:13:36 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40284 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZBITNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:13:36 -0500
X-Greylist: delayed 758 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2009 14:13:35 EST
Received: by mail.nrlssc.navy.mil id n19J0GN0010697; Mon, 9 Feb 2009 13:00:16 -0600
In-Reply-To: <499058B4.4070009@beonex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109106>

This is an example patch which is corrupted when saved using Thunderbir=
d
v2.0.0.19.

---
diff --git a/autoconf.m4f b/autoconf.m4f
new file mode 100644
index 0000000..73283b5
--- /dev/null
+++ b/autoconf.m4f
@@ -0,0 +1,6 @@
+T31,23
+m4_location(_AC_LIST_MEMBER_IF)autoconf/fortran.m4:115
+T17,203
+m4_cr_not_Letters=01=02=03=04=05=06=07=08=09
+=0B=0C=0D=0E=0F=10=11=12=13=14=15=16=17=18=19=1A=1B=1C=1D=1E=1F !"#$%&=
'()*+,./0123456789:;<=3D>?@[\]^_`{|}~=7F=80=81=82=83=84=85=86=87=88=89=8A=
=8B=8C=8D=8E=8F=90=91=92=93=94=95=96=97=98=99=9A=9B=9C=9D=9E=9F=A0=A1=A2=
=A3=A4=A5=A6=A7=A8=A9=AA=AB=AC=AD=AE=AF=B0=B1=B2=B3=B4=B5=B6=B7=B8=B9=BA=
=BB=BC=BD=BE=BF=C0=C1=C2=C3=C4=C5=C6=C7=C8=C9=CA=CB=CC=CD=CE=CF=D0=D1=D2=
=D3=D4=D5=D6=D7=D8=D9=DA=DB=DC=DD=DE=DF=E0=E1=E2=E3=E4=E5=E6=E7=E8=E9=EA=
=EB=EC=ED=EE=EF=F0=F1=F2=F3=F4=F5=F6=F7=F8=F9=FA=FB=FC=FD=FE=FF-
+T15,855
--=20
1.6.1.239.gcf3bf
