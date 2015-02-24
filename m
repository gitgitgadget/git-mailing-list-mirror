From: "J. R. Westmoreland" <jr@jrw.org>
Subject: Build error with current source release
Date: Tue, 24 Feb 2015 07:23:47 -0700
Message-ID: <03B16590-C319-478F-B19C-7EF3B51952BC@jrw.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2087\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 15:44:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQGip-00063y-IL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 15:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbbBXOoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2015 09:44:13 -0500
Received: from www.jrw.org ([207.108.170.162]:46896 "EHLO orthanc.jrw.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbbBXOoM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 09:44:12 -0500
X-Greylist: delayed 1220 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2015 09:44:12 EST
Received: from [192.168.1.3] (96.sub-70-208-9.myvzw.com [70.208.9.96])
	by orthanc.jrw.org (8.14.5/8.14.5) with ESMTP id t1OEMuYW004908
	for <git@vger.kernel.org>; Tue, 24 Feb 2015 07:22:56 -0700
X-Mailer: Apple Mail (2.2087)
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.3.2
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on orthanc.jrw.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264329>

Hi

I hope it is okay to ask such a question here.

I cloned the current source tree and tried to build it and I get the fo=
llowing error.
Could someone tell me why and if there is an easy way to fix it?=20
I=E2=80=99m running on a Mac and everything ran fine up to this error. =
Is is an excerpt from my typescript file.

Script started on Mon Feb 23 13:43:01 2015
    XMLTO git-add.1
xmlto: /Users/jr/Documents/projects/git/Documentation/git-add.xml does =
not validate (status 3)
xmlto: Fix document syntax or use --skip-validation option
I/O error : Attempt to load network entity http://www.oasis-open.org/do=
cbook/xml/4.5/docbookx.dtd
/Users/jr/Documents/projects/git/Documentation/git-add.xml:2: warning: =
failed to load external entity "http://www.oasis-open.org/docbook/xml/4=
=2E5/docbookx.dtd"
D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docb=
ookx.dtd"
                                                                       =
        ^
I/O error : Attempt to load network entity http://www.oasis-open.org/do=
cbook/xml/4.5/docbookx.dtd
warning: failed to load external entity "http://www.oasis-open.org/docb=
ook/xml/4.5/docbookx.dtd"
validity error : Could not load the external subset "http://www.oasis-o=
pen.org/docbook/xml/4.5/docbookx.dtd"
Document /Users/jr/Documents/projects/git/Documentation/git-add.xml doe=
s not validate
make[1]: *** [git-add.1] Error 13
Script done on Mon Feb 23 13:43:33 2015

Thanks in advance for suggestions or solutions.

Best,
J. R. Westmoreland
