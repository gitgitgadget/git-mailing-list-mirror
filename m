From: "Dickson, Alex" <alex_dickson@mentor.com>
Subject: Cannot run cmd command lines from GIT bash
Date: Mon, 18 Aug 2014 11:07:46 +0000
Message-ID: <E41D1E6BD9F1DF48877C833FE120496FDDE1D2FD@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 13:07:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJKn3-0001V7-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 13:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbaHRLHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2014 07:07:49 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:37046 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbaHRLHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2014 07:07:48 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp 
	id 1XJKmx-0000Tf-Sv from alex_dickson@mentor.com 
	for git@vger.kernel.org; Mon, 18 Aug 2014 04:07:47 -0700
Received: from SVR-IES-FEM-03.mgc.mentorg.com ([137.202.0.108]) by SVR-ORW-EXC-10.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 18 Aug 2014 04:07:47 -0700
Received: from EU-MBX-04.mgc.mentorg.com ([169.254.4.161]) by
 SVR-IES-FEM-03.mgc.mentorg.com ([137.202.0.108]) with mapi id 14.02.0247.003;
 Mon, 18 Aug 2014 12:07:47 +0100
Thread-Topic: Cannot run cmd command lines from GIT bash
Thread-Index: Ac+61DagxPOXr1ytShaxC21qQgOaGgAAFjSg
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-puzzleid: {FD357CDF-5156-41A5-AB17-FAA42FE9A549}
x-cr-hashedpuzzle: XYU= AoJP At7r A2eA Bchs Bqi5 Bq/6 FLN/ Fnjc GJEp GhsW
 HLWI HT7E IaN7 J0y/
 KdRp;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{FD357CDF-5156-41A5-AB17-FAA42FE9A549};YQBsAGUAeABfAGQAaQBjAGsAcwBvAG4AQABtAGUAbgB0AG8AcgAuAGMAbwBtAA==;Mon,
 18 Aug 2014 11:07:43
 GMT;QwBhAG4AbgBvAHQAIAByAHUAbgAgAGMAbQBkACAAYwBvAG0AbQBhAG4AZAAgAGwAaQBuAGUAcwAgAGYAcgBvAG0AIABHAEkAVAAgAGIAYQBzAGgA
x-originating-ip: [137.202.0.76]
X-OriginalArrivalTime: 18 Aug 2014 11:07:47.0731 (UTC) FILETIME=[A4C60E30:01CFBAD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255384>

HI,
I have just installed GIT from Git-1.9.4-preview20140815.exe having pre=
viously been using Git-1.9.2-preview20140411.exe I now
find that some scripts I have been using for some time are no longer wo=
rking correctly.

It seems that now I cannot pass parameters through to a DOS =A0command =
e.g.=20
=A0=A0=A0=A0net user <username> /DOMAIN

used to return full information about the user, now it just returns use=
rname not found, which is the behaviour
if it is invoked without the /DOMAIN switch. I have seen similar with o=
ther commands, an even simpler example would be
=A0=A0 cmd /c dir

This should run the DOS dir command, but all it does is invoke cmd.exe =
=A0interactively

Alex Dickson, IESD, Mentor Graphics, Newbury, UK.
phone:+44 1635 811429,=A0=A0=A0=A0=A0=A0=A0 fax:+44 1635 810102
mailto:alex_dickson@mentor.com, http://www.mentor.com
