From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: [StGit] Emacs mode merge request
Date: Wed, 9 Jun 2010 14:11:25 +0200
Message-ID: <AANLkTiklRA-d8p3NhpvjZLua0zE7uK8RFrJTegCr-Jjd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 14:11:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMK85-0005qn-Cc
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 14:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128Ab0FIML2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 08:11:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58874 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383Ab0FIML1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 08:11:27 -0400
Received: by bwz11 with SMTP id 11so1533871bwz.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=EJzPqj98NnM9neQtjBPoXOxRDuom3PDmTPH267tuHAI=;
        b=kBcF0vlKGjZYizO/Qr7rzyC/i/aoJtD5SflHMPBBThIUXBZKRR6G0GCkMOCkR5PeP5
         sfnLlAvOUzpM7AXlPsQ1G8ai829AWEafzTzfpYauWYWMnBpGFyfIz9kBN3z4Pcr0/111
         8WN61lNuMhWXQWaYSXuNzaeAW/CtMk2/UOw90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=SSNvyCl7b56GuMgN4EUlC3EK5Xvga+E8hr9RcHZsdP7wLIIRvLnoBSf2qkkmQKcpMO
         OSFA6vGm5qa2il//HzrEgylM2J1dAPQCDeafKBvvsCJn2HzKMnfQpie6M/zLCFI/Kjtn
         6NGF4KJgSlTx1Gh/22CY9y5amxRgVGFKRQR+M=
Received: by 10.204.83.225 with SMTP id g33mr2017145bkl.37.1276085485317; Wed, 
	09 Jun 2010 05:11:25 -0700 (PDT)
Received: by 10.204.53.206 with HTTP; Wed, 9 Jun 2010 05:11:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148763>

Catalin, can you please merge the following series from
git://github.com/gustavh/stgit.git "proposed" branch.
All the patches are small, incremental improvements and bug fixes to
the Emacs mode.

199cec3 tutorial: Very minor typo fixes in the Emacs section
939ff13 stgit.el: Add stgit-{git,stg}-program variables
e23eb46 stgit.el: Rearrange customizations a bit
5be0bca stgit.el: Add "Customize StGit" menu entry
cde79c7 stgit.el: Improve how "t h" mode finds old commits
160b5bf stgit.el: Make C-{up,down} move between groups of patches
b8738ed stgit.el: Add a few links to some customization variables
d528462 stgit.el: Repair ! for historical commits
16e96c0 stgit.el: Honor stgit-find-copies-harder in stgit-diff-range
65f3ffa stgit.el: Honor stgit-find-copies-harder when showing entire patches
108e5c8 stgit.el: Fix showing diff in file that has been both copied
and modified

The branch is based on your "proposed" branch (53055a56).

Somewhat unrelated, whom should I talk to about getting the Emacs mode
into the Debian package?
I think the Emacs mode ought to go into the 'stgit' package rather
than 'stgit-contrib', but some may disagree...

Thanks,
 Gustav
