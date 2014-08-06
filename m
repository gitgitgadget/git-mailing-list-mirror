From: Jared Brank <jared.brank@skaletech.com>
Subject: Git detects changes after new branch created and switched even though
 files have not been changed
Date: Wed, 6 Aug 2014 15:04:15 +0000
Message-ID: <a2546f9109674431820b7a98f9570433@BL2PR05MB180.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:04:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF2lN-00043q-1M
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbaHFPEV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 11:04:21 -0400
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:44342
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752615AbaHFPEU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 11:04:20 -0400
Received: from BL2PR05MB180.namprd05.prod.outlook.com (10.242.198.20) by
 BL2PR05MB180.namprd05.prod.outlook.com (10.242.198.20) with Microsoft SMTP
 Server (TLS) id 15.0.995.14; Wed, 6 Aug 2014 15:04:16 +0000
Received: from BL2PR05MB180.namprd05.prod.outlook.com ([169.254.10.152]) by
 BL2PR05MB180.namprd05.prod.outlook.com ([169.254.10.152]) with mapi id
 15.00.0995.014; Wed, 6 Aug 2014 15:04:16 +0000
Thread-Topic: Git detects changes after new branch created and switched even
 though files have not been changed
Thread-Index: Ac+xhwx/Vn7uPytbSP2f0lIw3EyUEQAAFz8A
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.228.71.74]
x-microsoft-antispam: BCL:0;PCL:0;RULEID:
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(6009001)(189002)(199002)(107886001)(74662001)(76482001)(110136001)(85306004)(2351001)(107046002)(74502001)(229853001)(74316001)(76576001)(50986999)(77982001)(46102001)(87936001)(2656002)(86362001)(83072002)(101416001)(31966008)(85852003)(92566001)(79102001)(77096002)(99396002)(83322001)(33646002)(106356001)(64706001)(81342001)(99286002)(95666004)(81542001)(21056001)(4396001)(105586002)(66066001)(80022001)(54356999)(20776003)(24736002)(108616003);DIR:OUT;SFP:;SCL:1;SRVR:BL2PR05MB180;H:BL2PR05MB180.namprd05.prod.outlook.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;LANG:en;
X-OriginatorOrg: skaletech.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254863>

Running on Windows with latest version of Git. 1.9.4. Also had this tro=
uble with 1.8.2 but upgraded hoping it would fix the problem.

When I do a reset on several files, it says they were successfully reve=
rted they still show up as modified when I do a git status. In this cas=
e it's just a newline character at the end of the file. I also tried a =
reset -- hard and they files still show up! What the heck! Help please.
In trying to reproduce this, I re-cloned the git repo from the server, =
which was in the exact clean state before I started last time. No files=
 have been modified after cloning, all are identical. Then, I created a=
 new branch (totally new, not tracking a remote branch). Viola - I now =
have these files show up in my git status as modified. Please note that=
 these are files that have been tracked for several previous commits.
Just to clarify - the only command I ran to make this happen is:=A0git =
checkout -b newbranch

And GitGui shows the files as identical even when compare whitespace is=
 turned on.
