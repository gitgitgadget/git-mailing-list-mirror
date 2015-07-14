From: =?utf-8?Q?Peter_H=C3=BCfner?= <p.huefner@e-confirm.de>
Subject: git on vagrant shared folder
Date: Tue, 14 Jul 2015 17:49:43 +0200
Message-ID: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 17:56:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF2Yz-0004cc-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 17:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbbGNP4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 11:56:05 -0400
Received: from mailrelay4.qsc.de ([195.158.160.129]:43933 "EHLO
	mailrelay4.qsc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbbGNP4E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2015 11:56:04 -0400
X-Greylist: delayed 376 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2015 11:56:03 EDT
Received: from s029.bre.qsc.de ([195.90.7.69]) by mailgate4.qsc.de;
 Tue, 14 Jul 2015 17:49:44 +0200
Received: from [192.168.53.205] (unknown [212.84.220.117])
	by s029.bre.qsc.de (Postfix) with ESMTPSA id 5484736C0067
	for <git@vger.kernel.org>; Tue, 14 Jul 2015 17:49:43 +0200 (CEST)
X-Mailer: Apple Mail (2.2102)
X-cloud-security-sender: p.huefner@e-confirm.de
X-cloud-security-recipient: git@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mailgate4 with B9EBE1490001
X-cloud-security-connect: s029.bre.qsc.de[195.90.7.69], TLS=, IP=195.90.7.69
X-cloud-security: scantime:.1268
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273964>

Dear git-Team,
we recognized a behavior that comes up with a newer git version. Unfort=
unately we do not know which version exactly.

The problem:
=46or development we are using virtual box controlled via vagrant with =
a shared folder on windows and mac hosts. The virtual OS ist ubuntu 14.=
04.2 LTS. In march this year we started with git in version around 2.3.=
 With cloning a repo directly in the shared folder we haven=E2=80=99t h=
ad any problems.
A few weeks ago we weren=E2=80=99t able to clone and get an error: coul=
d not commit /vagrant/.git/config file. Manually we were able to change=
 that file and also the clone command works outside the shared folder.

We retried it again with git version 1.9.1 (I think the standard of ubu=
ntu 14.04 LTS) and it worked. So the break seems to be around 2.4.

I hope you are able to understand the problem and can do something. Ple=
ase tell me if this is not a real bug.

Thanks a lot for the greatest VCS in the world.

Greetings from Berlin.

Mit freundlichen Gr=C3=BC=C3=9Fen
=20
Peter H=C3=BCfner
=2E........................................................
e=C2=B7confirm GmbH ..
Travel.Software.Training.Consulting
=20
Gesch=C3=A4ftsf=C3=BChrer: Roman Borch und Michael Posthoff
HRB 35653B   Steuernummer 37/211/10880
10119 Berlin Linienstr. 214
=20
Tel.  +49 (0) 30 28 00 28 24=20
=46ax. +49 (0) 30 28 00 28 28
=20
www.e-confirm.de
=2E....................................................................=
=2E...........................
