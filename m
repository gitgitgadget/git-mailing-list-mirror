From: "J. R. Westmoreland" <jr@jrw.org>
Subject: A branch question
Date: Tue, 10 Mar 2015 14:56:40 -0600
Message-ID: <6AC11CE0-764C-4CC5-89CD-05FFB6D29EA3@jrw.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2087\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 21:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVRCr-0007rx-TN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 21:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbbCJU4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 16:56:46 -0400
Received: from www.jrw.org ([207.108.170.162]:57558 "EHLO orthanc.jrw.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbbCJU4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 16:56:44 -0400
Received: from ldsslcf002.infra.wh.ldsglobal.net (213.sub-70-208-10.myvzw.com [70.208.10.213])
	by orthanc.jrw.org (8.14.5/8.14.5) with ESMTP id t2AKtmhD025682
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 14:55:49 -0600
X-Mailer: Apple Mail (2.2087)
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_00,RCVD_IN_BRBL_LASTEXT,
	RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=no version=3.3.2
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on orthanc.jrw.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265263>

hi everyone

I have found a solution which may not be the best so I=E2=80=99m asking=
 it here to see if I get a different solution from the wizards group. :=
)

I have a number of repos that were converted from svn to git. After the=
 conversion the branches that contained each release were named somethi=
ng like =E2=80=9Cbranches/version_<version-number>=E2=80=9D. We want to=
 modify the repo so the branches are named something like =E2=80=9Crele=
ase/<version-number>=E2=80=9D.=20

I currently do a command sequence like this:
git checkout <existing-branch>
git branch -m <existing-branch> <new-branch>
git push origin :<old-branch>
git push origin <new-branch>
Then I do a:
git checkout master
git branch -D <new-branch>
to cleanup my local area.

Note: These branches are only kept for historical purposes and not modi=
fied except occasionally the latest release may have an update so fix a=
 bug.

=46inally, as we move forward, what is the accepted best practice for d=
oing a release?

Thanks in advance for your collective wisdom.

Best,
J. R.
