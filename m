From: RaviKiranGoud_Palpanoori@vfc.com
Subject: Git Help needed
Date: Fri, 1 Aug 2014 19:30:11 +0000
Message-ID: <898fcfcd0c4f41da805abdd41622058f@DM2PR08MB477.namprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 21:45:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDIla-0007Dh-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbaHATpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 15:45:22 -0400
Received: from itxf2aln14.vfc.com ([167.64.248.24]:4756 "EHLO
	ITXF2ALN14.VFC.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaHATpV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 15:45:21 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2014 15:45:21 EDT
Received: from na01-by2-obe.outbound.protection.outlook.com ([167.64.245.242])
          by itgc2abb1.vfc.com (Lotus Domino Release 8.5.3FP2 HF23)
          with ESMTP id 2014080115301542-140720 ;
          Fri, 1 Aug 2014 15:30:15 -0400 
Received: from DM2PR08MB477.namprd08.prod.outlook.com (10.141.86.146) by
 DM2PR08MB479.namprd08.prod.outlook.com (10.141.86.151) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Fri, 1 Aug 2014 19:30:12 +0000
Received: from DM2PR08MB477.namprd08.prod.outlook.com ([10.141.86.146]) by
 DM2PR08MB477.namprd08.prod.outlook.com ([10.141.86.146]) with mapi id
 15.00.0995.014; Fri, 1 Aug 2014 19:30:12 +0000
Thread-Topic: Git Help needed
Thread-Index: Ac+tvs0jfY/57SfCRUmWblNnsOxG7A==
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [167.64.57.10]
x-microsoft-antispam: BCL:0;PCL:0;RULEID:
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(6009001)(199002)(189002)(51874003)(2351001)(92566001)(83322001)(229853001)(107886001)(79102001)(54356999)(21056001)(105586002)(64706001)(81342001)(99396002)(80022001)(107046002)(87936001)(83072002)(85852003)(74662001)(66066001)(76576001)(20776003)(74502001)(106356001)(74316001)(31966008)(4396001)(95666004)(99286002)(33646002)(110136001)(76482001)(77982001)(81542001)(86362001)(2656002)(101416001)(50986999)(46102001)(85306004)(24736002)(108616003);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR08MB479;H:DM2PR08MB477.namprd08.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;LANG:en;
X-OriginatorOrg: vfc.com
X-MIMETrack: Itemize by SMTP Server on ITGC2ABB1/VFITS/VF Corporation(Release 8.5.3FP2
 HF23|July 24, 2012) at 08/01/2014 03:30:15 PM,
	Serialize by Router on ITXF2ALN14/InternetMail(Release 8.5.3|September 15, 2011) at
 08/01/2014 03:45:21 PM,
	Serialize complete at 08/01/2014 03:45:21 PM
X-TNEFEvaluated: 1
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254655>

Hi,
I am writing below couple of questions. If it is not the right place to=
 ask please ignore and suggest me what to do to get the help on these q=
uestions.

1) What version of SSL is supported by GIT 1.8.3 or GIT 1.9.0

2) I have installed git 1.8.3 in AIX server 6.1 TL8 SP2. It worked fine=
 and able to extract code from git repository directly as well as from =
ant. Everything went well.
Recently Aix OS upgraded to 6100-09-01-1341. After OS upgrade my git co=
mmands are not working. Basic help and version works fine as expected. =
When I try to pull the code from git repository it give SSL library com=
patibility issue.

The error is=A0
OpenSSL version mismatch. Built agains 1000105f, you have 100000bf
fatal: Could not read from remote repository

In order to get rid of this, I upgraded git to 1.9.0 GIT. But still it =
didn't work. The issue is still coming.=A0

git help, version works.=A0
When I tried directly pulling code using git pull command - didn't work=
=2E
When I try to pull the code through the ant - didn't work

The ant version is 1.8.0RC1

AIX admin worked on this and provided below comments

Comments form AIX system admin =A0(Pasted as it is)
Even after installing 1.9.0 version of GIT the library files are not co=
mpatible with the latest version of SSL (1.0.5.1).
SSL works fine as a root user and other users. This compatibility issue=
 only a raises when the LIBPATH for GIT is set and the SSL picks up its=
 LIBPATH from the same location as GIT and this causes the incompatibil=
ity.
Can you find out from the GIT/ANT support team on what version of SSL G=
IT supports exactly. - The is specifically with the GIT/SSL as the user=
 "xyzabc" . The SSL otherwise works perfectly fine.
You will have to re-compile the ANT libraries to use the latest library=
 files.

Thanks in advance.

Regards,
Ravi.
