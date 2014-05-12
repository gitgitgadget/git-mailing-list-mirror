From: Thomas-Louis Laforest <tllaforest@arbault.ca>
Subject: Bug - Git reset --quiet not quiet
Date: Mon, 12 May 2014 19:16:33 +0000
Message-ID: <764966de191443d68e7ceca790b641ff@CO1PR02MB029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 12 21:16:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjviK-0004lE-QD
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 21:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbaELTQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 15:16:37 -0400
Received: from mail-bn1blp0190.outbound.protection.outlook.com ([207.46.163.190]:42073
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751471AbaELTQg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 15:16:36 -0400
Received: from CO1PR02MB029.namprd02.prod.outlook.com (10.242.162.148) by
 CO1PR02MB032.namprd02.prod.outlook.com (10.242.162.154) with Microsoft SMTP
 Server (TLS) id 15.0.939.12; Mon, 12 May 2014 19:16:34 +0000
Received: from CO1PR02MB029.namprd02.prod.outlook.com ([169.254.16.184]) by
 CO1PR02MB029.namprd02.prod.outlook.com ([169.254.16.184]) with mapi id
 15.00.0939.000; Mon, 12 May 2014 19:16:33 +0000
Thread-Topic: Bug - Git reset --quiet not quiet
Thread-Index: Ac9uFePtqZaqBax1T/6v1jkksH1biw==
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
received-spf: None (: arbault.ca does not designate permitted sender hosts)
x-originating-ip: [69.70.127.250]
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009001)(6009001)(428001)(199002)(189002)(83072002)(80022001)(87936001)(4396001)(85852003)(81542001)(74662001)(2656002)(74316001)(81342001)(20776003)(19580405001)(99396002)(66066001)(92566001)(31966008)(86362001)(64706001)(79102001)(76576001)(50986999)(74502001)(77982001)(33646001)(54356999)(83322001)(99286001)(19580395003)(76482001)(74482001)(21056001)(101416001)(46102001)(24736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB032;H:CO1PR02MB029.namprd02.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tllaforest@arbault.ca; 
Content-ID: <8E4522540CEC814E9507594F6DF98217@namprd02.prod.outlook.com>
X-OriginatorOrg: arbault.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248724>

Good afternoon,

When running this command on Git for Windows (version 1.9.2-preview2014=
0411)
git reset --quiet --hard with one file having read/write lock git ask t=
his question :=20
Unlink of file 'XXXX' failed. Should I try again? (y/n)

I will have expected the command --quiet to remove the question and aut=
o-answer no.
This broke an automated script we use.

Good day

Thomas-Louis Laforest, ing. jr, Jr. Eng.
Charg=E9 de projet,=A0Project Leader
solutions int=E9gr=E9es=A0=A0|=A0=A0integrated solutions
T=A0819 542-5600=A0 x3106
=46=A0819 845-5600
tllaforest@arbault.ca
The information contained herein is of private and confidential nature.=
 It can be used only by the above-mentioned recipients. Any other perso=
n who would take note of it is advised that it is strictly forbidden fo=
r him to reveal the information, to distribute it or to copy it. If thi=
s communication were transmitted to you by mistake, warn us immediately=
 by telephone or email, and erase the original, without taking a copy, =
revealing the content nor taking some measures based on it.
Les renseignements contenus dans les pr=E9sentes sont de nature priv=E9=
e et confidentielle. Ils ne peuvent =EAtre utilis=E9s que par le ou les=
 destinataires susmentionn=E9s. Toute autre personne qui en prendrait c=
onnaissance est pri=E9e de noter qu'il lui est strictement interdit de =
les divulguer, de les distribuer ou de les copier. Si cette communicati=
on vous a =E9t=E9 transmise par m=E9garde, veuillez nous en aviser imm=E9=
diatement par t=E9l=E9phone ou par courriel, et effacer l'original, san=
s en tirer de copie, en d=E9voiler le contenu ni prendre quelque mesure=
 fond=E9e sur celui-ci.
