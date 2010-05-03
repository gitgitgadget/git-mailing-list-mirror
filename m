From: John Dlugosz <JDlugosz@TradeStation.com>
Subject: Strange git crashing problem
Date: Mon, 3 May 2010 13:24:21 -0400
Message-ID: <89030B4A18ECCD45978A3A6B639D1F2403374EF348@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 03 19:24:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8zNu-0004Bg-82
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 19:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab0ECRYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 13:24:34 -0400
Received: from mail2.tradestation.com ([63.99.207.80]:48140 "EHLO
	mail2.tradestation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab0ECRYd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 13:24:33 -0400
X-ASG-Debug-ID: 1272907465-7721750c0001-QuoKaX
Received: from FL01EXCAHT02.trad.tradestation.com (fl01excaht02.trad.tradestation.com [10.4.0.167]) by mail2.tradestation.com with ESMTP id nlzfDuZrkHfV19yO (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <git@vger.kernel.org>; Mon, 03 May 2010 1
X-Barracuda-Envelope-From: JDlugosz@TradeStation.com
X-ASG-Whitelist: Client
Received: from FL01EXMB01.trad.tradestation.com ([::1]) by
 FL01EXCAHT02.trad.tradestation.com ([::1]) with mapi; Mon, 3 May 2010
 13:24:24 -0400
X-Barracuda-BBL-IP: ::1
X-Barracuda-RBL-IP: ::1
X-ASG-Orig-Subj: Strange git crashing problem
Thread-Topic: Strange git crashing problem
Thread-Index: Acrq4jj45zK5ZReUQgCa2H/SlnIHOg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: A9HR B3EX CTIB EHUd EX5Q ElXx FTpq FqXv GkjH HBrS IZbh
 JFBZ JUVK JVvI JmZ1
 Jo3o;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{9563841A-8D17-4D04-A9CC-65094E580C22};agBkAGwAdQBnAG8AcwB6AEAAdAByAGEAZABlAHMAdABhAHQAaQBvAG4ALgBjAG8AbQA=;Mon,
 03 May 2010 17:24:21
 GMT;UwB0AHIAYQBuAGcAZQAgAGcAaQB0ACAAYwByAGEAcwBoAGkAbgBnACAAcAByAG8AYgBsAGUAbQA=
x-cr-puzzleid: {9563841A-8D17-4D04-A9CC-65094E580C22}
acceptlanguage: en-US
X-Barracuda-Connect: fl01excaht02.trad.tradestation.com[10.4.0.167]
X-Barracuda-Start-Time: 1272907465
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://192.168.51.31:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at tradestation.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146243>

I'm trying to do an interactive rebase, and after editing the todo file=
, the git process just hangs.=A0 I was doing that a lot Friday and it w=
orked fine.=0D
=0D
So I did the work manually using reset and cherry picking.=A0 The reset=
 gave a strange error:=0D
=A0=A0 Deletion of directory 'compile.vc9' failed.=A0 Should I try agai=
n?=0D
This is a dialog box in gitk.=A0 I suppose the interactive prompt of wh=
atever sort is what messed up the rebase, and that would be a bug.=A0 I=
 don't know if it applies to the main line or msysgit only.=0D
=0D
But, why would it be trying to delete a directory anyway?=A0 That direc=
tory had changed files in it, but it was not created as part of any com=
mit anywhere near here.=0D

TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ G=
S: TRAD) of three operating subsidiaries, TradeStation Securities, Inc.=
 (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a=
 trading software and subscription company, and TradeStation Europe Lim=
ited, a United Kingdom, FSA-authorized introducing brokerage firm. None=
 of these companies provides trading or investment advice, recommendati=
ons or endorsements of any kind. The information transmitted is intende=
d only for the person or entity to which it is addressed and may contai=
n confidential and/or privileged material. Any review, retransmission, =
dissemination or other use of, or taking of any action in reliance upon=
, this information by persons or entities other than the intended recip=
ient is prohibited. If you received this in error, please contact the s=
ender and delete the material from any computer.
