From: "Philippe Martens" <philippe.martens@metrum.lu>
Subject: bug: git fast-import should ignore configuration variable core.ignorecase
Date: Sun, 22 Apr 2012 14:23:51 +0200
Message-ID: <001401cd2082$c6af7fc0$540e7f40$@metrum.lu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0015_01CD2093.8A393A20"
To: <git@vger.kernel.org>, <msysgit@googlegroups.com>
X-From: msysgit+bncCAAQsOrQ_AQaBFkiSG8@googlegroups.com Sun Apr 22 18:43:29 2012
Return-path: <msysgit+bncCAAQsOrQ_AQaBFkiSG8@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lpp01m010-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCAAQsOrQ_AQaBFkiSG8@googlegroups.com>)
	id 1SLzsn-0004m8-0a
	for gcvm-msysgit@m.gmane.org; Sun, 22 Apr 2012 18:43:29 +0200
Received: by lamb11 with SMTP id b11sf7029259lam.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 22 Apr 2012 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:message-id
         :mime-version:x-mailer:thread-index:x-junkmail-status
         :x-junkmail-signature-raw:x-junkmail-iwf:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-language;
        bh=dFJXcirndp1Lbso3Sgffb97Yxnf1eKNfIs4iN7d5A5Q=;
        b=Xs/zrPjXB4xS2dNMINy1WdHs2wuYxD/20NluzrY6ksjyOwh92OTuC8hI7QQkZJ3jDj
         lva4oz1+zQaI/+dKLTSLhhu6KVZUsWCaVEdP5I0x/lTRGGdwn/6v27femVoJZDb1vYPz
         9DceLN65iyss6ID2CJHi1UZvC73r0GUwot6mI=
Received: by 10.180.100.200 with SMTP id fa8mr860683wib.4.1335113008541;
        Sun, 22 Apr 2012 09:43:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.5 with SMTP id gi5ls1046620wib.3.gmail; Sun, 22 Apr
 2012 09:43:27 -0700 (PDT)
Received: by 10.180.8.137 with SMTP id r9mr1144629wia.2.1335113007135;
        Sun, 22 Apr 2012 09:43:27 -0700 (PDT)
Received: by 10.216.216.204 with SMTP id g54mswep;
        Sun, 22 Apr 2012 05:23:54 -0700 (PDT)
Received: by 10.14.96.134 with SMTP id r6mr3135599eef.1.1335097433815;
        Sun, 22 Apr 2012 05:23:53 -0700 (PDT)
Received: by 10.14.96.134 with SMTP id r6mr3135598eef.1.1335097433788;
        Sun, 22 Apr 2012 05:23:53 -0700 (PDT)
Received: from mirapoint21.brutele.be (mirapoint21.brutele.be. [212.68.199.158])
        by gmr-mx.google.com with ESMTP id a14si11433477een.0.2012.04.22.05.23.53;
        Sun, 22 Apr 2012 05:23:53 -0700 (PDT)
Received-SPF: neutral (google.com: 212.68.199.158 is neither permitted nor denied by best guess record for domain of philippe.martens@metrum.lu) client-ip=212.68.199.158;
Received: from METRUMPHM (62-197-93-206.teledisnet.be [62.197.93.206])
	by mirapoint21.brutele.be (MOS 4.2.3-GA)
	with ESMTP id BEW55276;
	Sun, 22 Apr 2012 14:23:50 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac0ggsaWTmA6/BjVQ4mhzgbRe15iMQ==
X-Junkmail-Status: score=10/50, host=mirapoint21.brutele.be
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A0B0204.4F93F857.004E,ss=1,fgs=0,
	ip=0.0.0.0,
	so=2010-12-23 16:51:53,
	dmn=2009-09-10 00:05:08,
	mode=single engine
X-Junkmail-IWF: false
X-Original-Sender: philippe.martens@metrum.lu
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 212.68.199.158 is neither permitted nor denied by best guess record for
 domain of philippe.martens@metrum.lu) smtp.mail=philippe.martens@metrum.lu
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Language: fr-be
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196084>

This is a multipart message in MIME format.

------=_NextPart_000_0015_01CD2093.8A393A20
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0016_01CD2093.8A393A20"

------=_NextPart_001_0016_01CD2093.8A393A20
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I=92m not quite sure if this is to be considered a Windows specific bug. I=
=92m
using Git-1.7.10-preview20120409 on Windows, but the problem exists in
previous versions.

=20

When fast-exporting | fast-importing on Windows a repository with case only
renames, the resulting repository isn=92t a copy of the initial repository.
This is because Windows repositories are created with core.ignorecase =3D t=
rue
by default.

=20

The included script shows the problem: it creates a repository with
SomeFile.txt renamed to SOMEFILE.txt, then fast-export it and fast-import i=
t
in two different repositories, with core.ignorecase=3Dfalse and
core.ignorecase=3Dtrue. The sha-1 of the second commit in the repository wi=
th
core.ignorecase=3Dtrue is different from the initial repository because the
rename is ignored.

The situation is worse without rename detection on fast-export : the rename
becomes a delete.

=20

I think the configuration variable core.ignorecase should be ignored by
fast-import, and case always taken into account in that case.

=20

Kind regards,

=20

Philippe Martens

Lead Architect

=20

METRUM

Rue du Kiem, 163

L-8030 Strassen

T=E9l : +352 26 00 87 01

Fax : +352 26 00 87 02

GSM : +352 661 26 00 37

Email :  <mailto:philippe.martens@metrum.lu> philippe.martens@metrum.lu

Web : www.metrum.lu

=20

P Please consider the environment before printing this e-mail.

=20

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***

*** Please avoid top-posting. ***

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

------=_NextPart_001_0016_01CD2093.8A393A20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Diso-8859-1"><meta name=3DGenerator content=3D"Micr=
osoft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Webdings;
	panose-1:5 3 1 2 1 5 9 6 7 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DFR-BE link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-=
US>Hello,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p=
>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>I&#8217;m n=
ot quite sure if this is to be considered a Windows specific bug. I&#8217;m=
 using Git-1.7.10-preview20120409 on Windows, but the problem exists in pre=
vious versions.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-U=
S><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>When =
fast-exporting | fast-importing on Windows a repository with case only rena=
mes, the resulting repository isn&#8217;t a copy of the initial repository.=
 This is because Windows repositories are created with core.ignorecase =3D =
true by default.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-=
US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>The =
included script shows the problem: it creates a repository with SomeFile.tx=
t renamed to SOMEFILE.txt, then fast-export it and fast-import it in two di=
fferent repositories, with core.ignorecase=3Dfalse and core.ignorecase=3Dtr=
ue. The sha-1 of the second commit in the repository with core.ignorecase=
=3Dtrue is different from the initial repository because the rename is igno=
red.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>The situa=
tion is worse without rename detection on fast-export : the rename becomes =
a delete.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p=
>&nbsp;</o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>I think the=
 configuration variable core.ignorecase should be ignored by fast-import, a=
nd case always taken into account in that case.<o:p></o:p></span></p><p cla=
ss=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US>Kind regards,<o:p></o:p></span></p><p class=3DMs=
oNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal=
><b><span lang=3DEN-US style=3D'mso-fareast-language:FR-BE'>Philippe Marten=
s<o:p></o:p></span></b></p><p class=3DMsoNormal><span lang=3DEN-US style=3D=
'font-size:9.0pt;mso-fareast-language:FR-BE'>Lead Architect<o:p></o:p></spa=
n></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:9.0pt;mso-=
fareast-language:FR-BE'><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><b=
><span style=3D'font-size:16.0pt;color:#00782C;mso-fareast-language:FR-BE'>=
METRUM<o:p></o:p></span></b></p><p class=3DMsoNormal><span style=3D'font-si=
ze:9.0pt;mso-fareast-language:FR-BE'>Rue du Kiem, 163<o:p></o:p></span></p>=
<p class=3DMsoNormal><span style=3D'font-size:9.0pt;mso-fareast-language:FR=
-BE'>L-8030 Strassen<o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:9.0pt;mso-fareast-language:FR-BE'>T=E9l : +352 26 00 87 01<o:=
p></o:p></span></p><p class=3DMsoNormal><span style=3D'font-size:9.0pt;mso-=
fareast-language:FR-BE'>Fax : +352 26 00 87 02<o:p></o:p></span></p><p clas=
s=3DMsoNormal><span style=3D'font-size:9.0pt;mso-fareast-language:FR-BE'>GS=
M : +352 661 26 00 37<o:p></o:p></span></p><p class=3DMsoNormal><span style=
=3D'font-size:9.0pt;mso-fareast-language:FR-BE'>Email : <u><span style=3D'c=
olor:#00782C'><a href=3D"mailto:philippe.martens@metrum.lu"><span style=3D'=
color:#00782C'>philippe.martens@metrum.lu</span></a></span></u><o:p></o:p><=
/span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:9.0pt;=
mso-fareast-language:FR-BE'>Web : </span><u><span style=3D'font-size:9.0pt;=
color:#00782C;mso-fareast-language:FR-BE'><a href=3D"www.metrum.lu"><span l=
ang=3DEN-US style=3D'color:#00782C'>www.metrum.lu</span></a></span></u><spa=
n lang=3DEN-US style=3D'font-size:9.0pt;mso-fareast-language:FR-BE'><o:p></=
o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:5=
.0pt;mso-fareast-language:FR-BE'><o:p>&nbsp;</o:p></span></p><p class=3DMso=
Normal><span lang=3DFR-LU style=3D'font-size:13.5pt;font-family:Webdings;co=
lor:green;mso-fareast-language:FR-BE'>P</span><span lang=3DFR-LU style=3D'f=
ont-size:12.0pt;font-family:"Times New Roman","serif";color:navy;mso-fareas=
t-language:FR-BE'> </span><span lang=3DEN-US style=3D'font-size:7.5pt;color=
:green;mso-fareast-language:FR-BE'>Please consider the environment before p=
rinting this e-mail.</span><span lang=3DEN-US style=3D'mso-fareast-language=
:FR-BE'><o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US><o:p>=
&nbsp;</o:p></span></p></div></body></html>

<p></p>

-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
&nbsp;<br />
*** Please avoid top-posting. ***<br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />

------=_NextPart_001_0016_01CD2093.8A393A20--
------=_NextPart_000_0015_01CD2093.8A393A20
Content-Type: application/octet-stream;
	name="test-fast-import.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test-fast-import.sh"

git init export=0A=
cd export=0A=
git config core.ignorecase true=0A=
echo "With some content in it..." > SomeFile.txt=0A=
git add .=0A=
git commit -m "Add some file"=0A=
git mv -f SomeFile.txt SOMEFILE.txt=0A=
git commit -m "Rename it (case only)"=0A=
git fast-export --all -M -C > ../git.fast-export=0A=
git log --oneline=0A=
=0A=
git init ../ignorecase.false=0A=
cd ../ignorecase.false=0A=
git config core.ignorecase false=0A=
git fast-import --quiet < ../git.fast-export=0A=
git log --oneline=0A=
=0A=
git init ../ignorecase.true=0A=
cd ../ignorecase.true=0A=
git config core.ignorecase true=0A=
git fast-import --quiet < ../git.fast-export=0A=
git log --oneline=0A=
cd ..=0A=

------=_NextPart_000_0015_01CD2093.8A393A20--
