From: "Eric Raible" <raible@gmail.com>
Subject: [PATCH] Completion: add missing '=' for 'diff --diff-filter'
Date: Fri, 22 Aug 2008 10:25:06 -0700
Message-ID: <279b37b20808221025l5e3b1e53gc9aa2d84e5aa6ea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: spearce@spearce.org, "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 19:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWaOr-0006PI-Ka
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 19:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982AbYHVRZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 13:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755592AbYHVRZI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 13:25:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:61142 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbYHVRZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 13:25:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so758446wfd.4
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Jlhy9Kvs5Z9uqAAImQiCLka/mDLsWMYYf7RnFol6oiQ=;
        b=AxpdKq6AiEHpM8uN83OLvmi4P4XCeefwdNIZYfDTwzExQX4m8ZvJ+mG2pzIpYnH0mU
         Ytc7WuQd/a/uOVBdBLEd1F7htyk5UHa+EHJo/DrKQfzPZNjZ6BTj/k5jOlRtkWMG8SZg
         gt/09pPP3ueQhagvrBk6etemSX4H9BtQSGTdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=iwiDKOBjRXgcjqVTrgPNIgTMnwXPhtNc98eMeo7kZehysbQPBdidWp+UWEpUcduL9i
         Rc1rRgVJ0jE3nTipLqrP9nqW0UjNzE2eCZZCecNZWVoMecnsY/oF/pzFl3Dn1hPF8pNj
         ViSLNZVEvBTxALiFp0K/9T4BBN6slFuxWMsZM=
Received: by 10.142.216.9 with SMTP id o9mr498941wfg.0.1219425906265;
        Fri, 22 Aug 2008 10:25:06 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Fri, 22 Aug 2008 10:25:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93331>

Signed-off-by: Eric Raible <raible@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 158b912..f76545e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -769,7 +769,7 @@ _git_diff ()
                __gitcomp "--cached --stat --numstat --shortstat --summary
                        --patch-with-stat --name-only --name-status --color
                        --no-color --color-words --no-renames --check
-                       --full-index --binary --abbrev --diff-filter
+                       --full-index --binary --abbrev --diff-filter=
                        --find-copies-harder --pickaxe-all --pickaxe-regex
                        --text --ignore-space-at-eol --ignore-space-change
                        --ignore-all-space --exit-code --quiet --ext-diff
--
1.6.0.rc3.1149.g59903
