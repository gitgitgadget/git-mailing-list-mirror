From: "Songmao Tian" <kingkongmao@gmail.com>
Subject: Hello all, I am using git-svn and have some question
Date: Sat, 6 Jan 2007 17:24:22 +0800
Message-ID: <7d73e7d80701060124t16850e8ob8fbd202d230dd90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 06 10:24:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H37n0-0005a7-PD
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 10:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbXAFJYZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 04:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbXAFJYZ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 04:24:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:65080 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbXAFJYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 04:24:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so8716109nfa
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 01:24:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dYAMKjO5ImoCwUqDIOdXMhk5r4yOGeMHiLumxL6/PJ3kmMxs8h2HF9vQpKhxyK+I7CG8DmKsrHopqN0oSBwXYDF9lPIrticPZVMl8TSEd06IoJmFywN2JJeBX+B6tyE67NvstALYLt74y+e03vQ0KZ6zJuirw7PMR9FBVoejUVg=
Received: by 10.48.162.15 with SMTP id k15mr27065100nfe.1168075463007;
        Sat, 06 Jan 2007 01:24:23 -0800 (PST)
Received: by 10.48.212.10 with HTTP; Sat, 6 Jan 2007 01:24:22 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36076>

(git v1.4.4.3)
I used the fantastic git-svn multi-init.
git-svn multi-init http://...

checkout a branch
git-checkout -b kkmao remotes/kkmao
git-checkout -b huahua remotes/huahua

git-pull . kkmao
(fix a conflict)

git-checkout kkmao

kkmao@Loongson:~/pmon/pmon-lm2e/git$ git-pull . huahua
Updating dee0161..3fa715b
Fast forward
 Targets/Bonito/conf/Bonito |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


finnally, "git-svn dcommit -i kkmao"failed, and got the following message

kkmao@Loongson:~/pmon/pmon-lm2e/git$ git-svn dcommit -i kkmao
diff-tree f179060aa2dd0a4ca4f95f2560ea708765a87a09~1
f179060aa2dd0a4ca4f95f2560ea708765a87a09
Merge conflict during commit: Your file or directory 'branches' is
probably out-of-date: The version resource does not correspond to the
resource within the transaction.  Either the requested version
resource is out of date (needs to be updated), or the requested
version resource is newer than the transaction root (restart the
commit). at /home/kkmao/bin/git-svn line 1577
