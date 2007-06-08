From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: git-p4 fails when cloning a p4 depo.
Date: Fri, 8 Jun 2007 09:41:35 -0700
Message-ID: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_47418_3723188.1181320895663"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 18:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwhWt-0004GC-44
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 18:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967849AbXFHQlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 12:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764796AbXFHQlh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 12:41:37 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:43750 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967849AbXFHQlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 12:41:36 -0400
Received: by nz-out-0506.google.com with SMTP id n1so790656nzf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 09:41:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=UNs9dtG+zbDyxgPN59SQHT+IhGHdfTZw43dtF2L4WEGXkkrm2bDwvbVe8JuvgYyZB8xoraljr0EhD18zeGjjy90KAwDCh3Gu7HaJURY7DXFzLweYUyWEkzGDUo4bUZ72yhWQQ6XOA4THIVK+kCFflyOu2Bw2iHtuvXJ5K79aPIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=bZiUYIO+sHgLZiMz/Z+RlmwUWgPGgP6QjBvXk/3TuciKUWQskfcQzW1hGFHKkjif4PNI7kpBV3LqFCerbquOEne/gjaeAQvbaEG+NHFNgChNiwHDeotY7ENS0euf3fM1IqZVZ0icc5c+MuRLU57xZQBqMp6a5M0vYmI7W8dv3ME=
Received: by 10.143.37.20 with SMTP id p20mr155371wfj.1181320895684;
        Fri, 08 Jun 2007 09:41:35 -0700 (PDT)
Received: by 10.143.43.1 with HTTP; Fri, 8 Jun 2007 09:41:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49484>

------=_Part_47418_3723188.1181320895663
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I attached a lame patch to die without showing the Python Traceback,
but I'd rather succeed :)
Maybe there is a different mailing list for git-p4. If there is tell
me and I'll post there.

Benjamin.

[bsergean@flanders sandbox]$ rm -rf dev ; git-p4 clone
//Work/Users/Capture3D/A3D810/pdfl/Common/a3d/dev
Importing from //Work/Users/Capture3D/A3D810/pdfl/Common/a3d/dev into dev
Initialized empty Git repository in .git/
Doing initial import of
//Work/Users/Capture3D/A3D810/pdfl/Common/a3d/dev/ from revision #head
[{'p4ExitCode': 32512}]
Traceback (most recent call last):
  File "/home/bsergean/src/fast-export/git-p4", line 1489, in <module>
    main()
  File "/home/bsergean/src/fast-export/git-p4", line 1484, in main
    if not cmd.run(args):
  File "/home/bsergean/src/fast-export/git-p4", line 1395, in run
    if not P4Sync.run(self, depotPaths):
  File "/home/bsergean/src/fast-export/git-p4", line 1203, in run
    self.commit(details, self.extractFilesFromCommit(details),
self.branch, self.depotPaths)
  File "/home/bsergean/src/fast-export/git-p4", line 744, in commit
    self.readP4Files(files)
  File "/home/bsergean/src/fast-export/git-p4", line 722, in readP4Files
    contents[stat['depotFile']] = text
KeyError: 'depotFile'

------=_Part_47418_3723188.1181320895663
Content-Type: text/x-patch; name=git-p4.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2ogv6r3
Content-Disposition: attachment; filename="git-p4.diff"

ZGlmZiAtLWdpdCBhL2dpdC1wNCBiL2dpdC1wNAppbmRleCAzNmZlNjlhLi4zZTFhODc4IDEwMDc1
NQotLS0gYS9naXQtcDQKKysrIGIvZ2l0LXA0CkBAIC03MDcsNiArNzA3LDkgQEAgY2xhc3MgUDRT
eW5jKENvbW1hbmQpOgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmWydyZXYnXSkKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmb3IgZiBpbiBmaWxlc10pKQogCisJaWYgInA0
RXhpdENvZGUiIGluIGZpbGVkYXRhWzBdOgorICAgICAgICAgICAgZGllKCJQcm9ibGVtcyBleGVj
dXRpbmcgcDQiKTsKKwogICAgICAgICBqID0gMDsKICAgICAgICAgY29udGVudHMgPSB7fQogICAg
ICAgICB3aGlsZSBqIDwgbGVuKGZpbGVkYXRhKToK
------=_Part_47418_3723188.1181320895663--
