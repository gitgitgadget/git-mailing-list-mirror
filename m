From: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
Subject: Git merge driver / attributes bug in 2.3.1?
Date: Thu, 5 Mar 2015 13:30:40 +0000
Message-ID: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 14:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTVrT-0005QZ-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 14:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbbCENan convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 08:30:43 -0500
Received: from mail2.dwpbank.de ([145.253.155.115]:19440 "EHLO
	mail2.dwpbank.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbbCENan convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 08:30:43 -0500
X-IronPort-AV: E=Sophos;i="5.11,347,1422918000"; 
   d="scan'208";a="16345675"
Received: from DWPWHMS531.dwpbank.local ([169.254.2.62]) by
 DWPFRMS530.dwpbank.local ([169.254.3.36]) with mapi id 14.03.0195.001; Thu, 5
 Mar 2015 14:30:41 +0100
Thread-Topic: Git merge driver / attributes bug in 2.3.1?
Thread-Index: AdBXSJKXxxr16gR1Rkq4toiUl+/Nog==
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.101.236.155]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264833>

Hello,

after upgrading the Git installation on one of our development servers =
from 1.9.0-rc3 to 2.3.1 we are experiencing strange behavior of merge d=
rivers.

A merge driver registered as "* merge=3D<name_of_merge_driver>" in the =
=2Egitattributes is now executed even if there isn't any merge conflict=
=2E This only happens for files that are part of the merge.

This is reproducible in test repositories.

Greetings

Andreas Gondek
Applications
________________________________

Deutsche WertpapierService Bank AG
ITTAS
Derendorfer Allee 2
40476 D=FCsseldorf
Tel.: +49 69 5099 9503
=46ax: +49 69 5099 85 9503
E-Mail: Andreas.Gondek@dwpbank.de
http://www.dwpbank.de

Deutsche WertpapierService Bank AG | Wildunger Stra=DFe 14 | 60487 Fran=
kfurt am Main
Sitz der AG: Frankfurt am Main, HRB 56913 | USt.-ID: DE 813759005
Vorstand: Thomas Klanten, Dr. Christian Tonnesen
Aufsichtsrat: Wilfried Groos (Vors.)=20
