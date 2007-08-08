From: "Steve Hoelzer" <shoelzer@gmail.com>
Subject: [PATCH] cmd-list.perl: Alphabetize command list
Date: Wed, 8 Aug 2007 14:30:44 -0500
Message-ID: <588192970708081230y76520dak857261e96eae317a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git mailing list" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrF5-0008Lq-I9
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbXHHTar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757669AbXHHTaq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:30:46 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:44714 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050AbXHHTap (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:30:45 -0400
Received: by an-out-0708.google.com with SMTP id d31so47906and
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 12:30:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tqQr1ZDvAogak8iNG+Mo/fnRTcw9CFAsYGvXa+4ymUKAdYDf0R5LScZnTOZngso5Ve1WgMWo3pVSOhANZRMTQbn9qFXDS32xeb42WPuInRCNdGxndoApn1r75emBNH+P9YUdGkeaFMMnghX3Weh3NO9zTZqxVK4VYsCJC+2ZdVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NFOyHm1Tb8dTKR0/hmCUpd7vntknLHlP89imNIsHDht1nJunjelR/5gr+h0n42mZF6z39dz5N9ten7wI4KL+o1MMOnxfGYYBaAAERd0SzBMrYCnZ4yp/X7ZODoUWwye3yA8a699ha2Nx7DK66JtprvxhaWUtfy3YnIeOyDPgYxs=
Received: by 10.100.173.19 with SMTP id v19mr513511ane.1186601444594;
        Wed, 08 Aug 2007 12:30:44 -0700 (PDT)
Received: by 10.100.105.9 with HTTP; Wed, 8 Aug 2007 12:30:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55340>

Signed-off-by: Steve Hoelzer <shoelzer@gmail.com>
---
 Documentation/cmd-list.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 2143995..cef9ab7 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -80,10 +80,10 @@ git-blame
ancillaryinterrogators
 git-branch                              mainporcelain
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
-git-checkout-index                      plumbingmanipulators
-git-checkout                            mainporcelain
 git-check-attr                          purehelpers
 git-check-ref-format                    purehelpers
+git-checkout                            mainporcelain
+git-checkout-index                      plumbingmanipulators
 git-cherry                              ancillaryinterrogators
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
@@ -91,6 +91,7 @@ git-clean                               mainporcelain
 git-clone                               mainporcelain
 git-commit                              mainporcelain
 git-commit-tree                         plumbingmanipulators
+git-config                              ancillarymanipulators
 git-convert-objects                     ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
 git-cvsexportcommit                     foreignscminterface
@@ -98,9 +99,9 @@ git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
+git-diff                                mainporcelain
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
-git-diff                                mainporcelain
 git-diff-tree                           plumbinginterrogators
 git-fast-import				ancillarymanipulators
 git-fetch                               mainporcelain
@@ -121,7 +122,6 @@ git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain
 git-instaweb                            ancillaryinterrogators
-gitk                                    mainporcelain
 git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
 git-lost-found                          ancillarymanipulators
@@ -130,10 +130,10 @@ git-ls-remote
plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
+git-merge                               mainporcelain
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
-git-merge                               mainporcelain
 git-merge-one-file                      purehelpers
 git-merge-tree                          ancillaryinterrogators
 git-mergetool                           ancillarymanipulators
@@ -157,26 +157,25 @@ git-rebase                              mainporcelain
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
-git-repack                              ancillarymanipulators
-git-config                              ancillarymanipulators
 git-remote                              ancillarymanipulators
+git-repack                              ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain
-git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
+git-revert                              mainporcelain
 git-rm                                  mainporcelain
 git-runstatus                           ancillaryinterrogators
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
+git-sh-setup                            purehelpers
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
 git-show                                mainporcelain
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
-git-sh-setup                            purehelpers
 git-ssh-fetch                           synchingrepositories
 git-ssh-upload                          synchingrepositories
 git-stash                               mainporcelain
@@ -200,3 +199,4 @@ git-verify-pack
plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
 git-write-tree                          plumbingmanipulators
+gitk                                    mainporcelain
-- 
1.5.3.rc3.141.g53d646
