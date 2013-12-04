From: "SCHILZ MANFRED" <manfred.schilz@bgl.lu>
Subject: problems with git --git-dir on windows 7
Date: Wed, 4 Dec 2013 17:11:01 +0100
Message-ID: <EF40980AA2C4C4449E2D87B419007B7F18E0FACB@SPMWB01L.luinternal.fortis.bank>
References: <EF40980AA2C4C4449E2D87B419007B7F18E0FACA@SPMWB01L.luinternal.fortis.bank>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 04 17:11:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoF2c-0003gw-Le
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 17:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782Ab3LDQLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 11:11:05 -0500
Received: from mail3.fortis.lu ([212.190.206.132]:1382 "EHLO mail3.fortis.lu"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755766Ab3LDQLE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 11:11:04 -0500
X-TM-IMSS-Message-ID: <53fff03e001c23d6@bgl.lu>
Received: from spmwf01l.luinternal.fortis.bank (unverified) by 
    swina164.lumgt.fortis.bank (mail.fortis.lu) with ESMTP id 
    <Tafcb001bdf0ab105471554@swina164.lumgt.fortis.bank> for 
    <git@vger.kernel.org>; Wed, 4 Dec 2013 17:10:58 +0100
Received: from SPMWB01L.luinternal.fortis.bank ([10.173.124.243]) by 
    spmwf01l.luinternal.fortis.bank with Microsoft SMTPSVC(6.0.3790.4675);
     Wed, 4 Dec 2013 17:11:01 +0100
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <EF40980AA2C4C4449E2D87B419007B7F18E0FACA@SPMWB01L.luinternal.fortis.bank>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: problems with git --git-dir on windows 7
Thread-Index: Ac7xBc1el3rmsEosT/S3765ejaj9uAABWBxQ
X-OriginalArrivalTime: 04 Dec 2013 16:11:01.0521 (UTC) 
    FILETIME=[6CF45810:01CEF10B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238788>

Hello,
We are using git on windows7(git-version 1.8.1; see below) and we get t=
he following problem in using the command 'git --git-dir=3D'


C:\UserTemp\git\appli3>git=A0 --git-dir=3DC:\UserTemp\git\appli3 tag
fatal: Not a git repository: 'C:\UserTemp\git\appli3'


but the repository is well defined,as we can run the following command:

C:\UserTemp\git\appli3>git log -1 --oneline
37cdbe0 Merge branch 'master' of L:/_ApplicationData/FBLU_IT-FLIT/se-De=
velopSupp

When running the equivalent command on Linux, we don't have any problem=
s:
On Linux:
>git --git-dir=3D"/tmp/GITPOC/appli3" tag
V1.0
V1.1
V2.0
V3.0

Could you help me please ?

Best regards

Manfred Schilz

-----------------------------------------------------------------------=
----------------
C:\UserTemp\git\appli3>git --version
git version 1.8.1.msysgit.1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Internet communications are not secure and therefore BGL BNP Paribas do=
es not accept legal responsibility for the contents of this message. Th=
e information contained in this e-mail is confidential and may be legal=
ly privileged. It is intended solely for the addressee. If you are not =
the intended recipient, any disclosure, copying, distribution or any ac=
tion taken or omitted to be taken in reliance on it, is prohibited and =
may be unlawful. Nothing in the message is capable or intended to creat=
e any legally binding obligations on either party and it is not intende=
d to provide legal advice.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
