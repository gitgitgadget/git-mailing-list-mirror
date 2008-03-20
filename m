From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: [PATCH] Documentation: reworded git-bisect.txt to be less kernel specific.
Date: Thu, 20 Mar 2008 19:25:30 -0400
Message-ID: <22FFC8CF-A7A3-4AAF-9707-ACA1AC101BDF@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/mixed; boundary=Apple-Mail-12-115063490
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 00:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcU9P-0006te-HF
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 00:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757744AbYCTXZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 19:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757337AbYCTXZn
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 19:25:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:21830 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbYCTXZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 19:25:42 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1334709wxd.4
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:from:to:content-type:mime-version:subject:date:x-mailer;
        bh=17SN9cjMwwg2kjSVAxPal7xBA2KVJn3lj3ROARj3Xmk=;
        b=MXvZvHnkFnjNH+AxN+bCDe3i77gonR/PbHYGtKvPG/GCHhDDSpBjNsTL1VxX98nPecYwBYDPj6beE6IVVbUV0m2HqWD5SEhq4ziivFUXUcAt99s77fa4vkFsxz06dJKil0udjxycXr6yTZu09QUzAc/zIG9up9wTM/pN9xyaP4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:from:to:content-type:mime-version:subject:date:x-mailer;
        b=o3Dr0A9zAfXNSt5JdbLl37RHBR8U/pjYix1s6g4tfiHHNQcYSZ2OjA6XA1tkmdumBi0CH+jSn4WE4wSMR67+Krw51I1rEzc+Zy61mz94A3z/k4aca846eb1+mhWFCHWGaXBXXMY6wXEOY4ILfPx20Oc8MHukL+HZ26Wilds57Rw=
Received: by 10.100.140.15 with SMTP id n15mr6426617and.87.1206055541356;
        Thu, 20 Mar 2008 16:25:41 -0700 (PDT)
Received: from ?192.168.1.100? ( [65.96.170.12])
        by mx.google.com with ESMTPS id 1sm3086155agb.8.2008.03.20.16.25.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Mar 2008 16:25:40 -0700 (PDT)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77688>


--Apple-Mail-12-115063490
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit

* Minor modifications to make examples more generically applicable,
mention the skip option earlier, and be slightly more explicit,
to aid foreign speakers.
---
  Documentation/git-bisect.txt |   14 +++++++-------
  1 files changed, 7 insertions(+), 7 deletions(-)


Patch is attached so that Mail.app won't mangle it.

-masukomi


--Apple-Mail-12-115063490
Content-Disposition: attachment;
	filename=0001-Documentation-reworded-git-bisect.txt-to-be-less-ke.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="0001-Documentation-reworded-git-bisect.txt-to-be-less-ke.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=200be29c0f4284995cad6b47ce55d279be00d8ea37=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Kate=20Rhodes=20<masukomi@gmail.com>=0ADate:=20=
Thu,=2020=20Mar=202008=2019:16:29=20-0400=0ASubject:=20[PATCH]=20=
Documentation:=20reworded=20git-bisect.txt=20to=20be=20less=20kernel=20=
specific.=0A=0A*=20Minor=20modifications=20to=20make=20examples=20more=20=
generically=20applicable,=0Amention=20the=20skip=20option=20earlier,=20=
and=20be=20slightly=20more=20explicit,=0Ato=20aid=20foreign=20speakers.=0A=
---=0A=20Documentation/git-bisect.txt=20|=20=20=2014=20+++++++-------=0A=20=
1=20files=20changed,=207=20insertions(+),=207=20deletions(-)=0A=0Adiff=20=
--git=20a/Documentation/git-bisect.txt=20b/Documentation/git-bisect.txt=0A=
index=2096585ae..940914c=20100644=0A---=20a/Documentation/git-bisect.txt=0A=
+++=20b/Documentation/git-bisect.txt=0A@@=20-48,9=20+48,9=20@@=20the=20=
revision=20tree=20and=20say=20something=20like:=0A=20Bisecting:=20675=20=
revisions=20left=20to=20test=20after=20this=0A=20=
------------------------------------------------=0A=20=0A-and=20check=20=
out=20the=20state=20in=20the=20middle.=20Now,=20compile=20that=20kernel,=20=
and=0A-boot=20it.=20Now,=20let's=20say=20that=20this=20booted=20kernel=20=
works=20fine,=20then=20just=0A-do=0A+and=20check=20out=20the=20state=20=
in=20the=20middle.=20Then,=20test=20for=20the=20presence=0A+of=20your=20=
bug.=20If=20you've=20found=20a=20version=20where=20the=20bug=20isn't=20=0A=
+present=20you=20can=20just=20do=20=0A=20=0A=20=
------------------------------------------------=0A=20$=20git=20bisect=20=
good=09=09=09#=20this=20one=20is=20good=0A@@=20-62,12=20+62,12=20@@=20=
which=20will=20now=20say=0A=20Bisecting:=20337=20revisions=20left=20to=20=
test=20after=20this=0A=20=
------------------------------------------------=0A=20=0A-and=20you=20=
continue=20along,=20compiling=20that=20one,=20testing=20it,=20and=20=
depending=0A-on=20whether=20it=20is=20good=20or=20bad,=20you=20say=20=
"git=20bisect=20good"=20or=20"git=20bisect=0A-bad",=20and=20ask=20for=20=
the=20next=20bisection.=0A+and=20you=20continue=20along,=20testing=20=
each=20checkout=20it=20makes,=20and=20depending=0A+on=20whether=20it=20=
is=20good=20or=20bad,=20you=20say=20"git=20bisect=20good",=20"git=20=
bisect=0A+bad",=20or=20"git=20bisect=20skip"=20(=20see=20below=20)=20and=20=
ask=20for=20the=20next=20bisection.=0A=20=0A=20Until=20you=20have=20no=20=
more=20left,=20and=20you'll=20have=20been=20left=20with=20the=20first=0A=
-bad=20kernel=20rev=20in=20"refs/bisect/bad".=0A+bad=20rev=20in=20=
"refs/bisect/bad".=0A=20=0A=20Bisect=20reset=0A=20~~~~~~~~~~~~=0A--=20=0A=
1.5.4.1.1278.gc75be=0A=0A=

--Apple-Mail-12-115063490
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-12-115063490--
