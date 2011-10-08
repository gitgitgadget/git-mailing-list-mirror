From: Daly Gutierrez <daly.gutierrez@gmail.com>
Subject: Recovering Committed Changes in a Detached Head?
Date: Sat, 08 Oct 2011 16:58:07 -0400
Message-ID: <1318107488.5865.46.camel@R0b0ty>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 22:58:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCdyK-0000f1-1b
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 22:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1JHU6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 16:58:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34053 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab1JHU6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 16:58:09 -0400
Received: by yxl31 with SMTP id 31so4501694yxl.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:date:content-type:x-mailer
         :content-transfer-encoding:message-id:mime-version;
        bh=wgBsBPzAMwi3Diw0pWzE3/Ighg9t6/gAt2RLWfxWL6Q=;
        b=t+lAQXtKYvoIoIpCukTBYfrkY8aW4dFPPuHsU20amQ9nn1lOCNvTyhr21lyBrAaYHk
         5GbNqVSh9+vZXgAhrx717qU/AqZFoVU23BkTRxM9Prz42q4nQqA1aom/kIyzZl0Vqnma
         2n5s9np/vcywENfQ8oxY9X5Et5a2hq+b10bvM=
Received: by 10.151.144.12 with SMTP id w12mr2091667ybn.81.1318107489333;
        Sat, 08 Oct 2011 13:58:09 -0700 (PDT)
Received: from [10.0.1.11] (99-194-40-68.dyn.centurytel.net. [99.194.40.68])
        by mx.google.com with ESMTPS id m10sm37015408ang.12.2011.10.08.13.58.08
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 13:58:08 -0700 (PDT)
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183174>

Is this possible after changing from the Detached Head branch to an
existing branch?  How about if I don't remember the commit SHA1 ID?

What I did, to the best of my knowledge:
1) Checked out a previous version:
> git checkout 3a5bb38a83c00f7acab573f0ec836577143200aa

2) Modified file and committed the changes in the detached branch.
> git log
 commit 92aa5381b9f7229523dba42aa94735c30f173451
 Author: Daly Gutierrez <Daly.Gutierrez@gmail.com>
 Date:   Sat Oct 8 16:20:11 2011 -0400

    Committing this in the Detached Head

3) For curiosity,
> git branch
* (no branch)
  New_Branch
  Second_New_Branch
  master

4) Changed to 'New_Branch' branch...  I no longer see the detached
branch...
 > git branch
* New_Branch
  Second_New_Branch
  master

5) Want to access the file with the changes I made in the Detached
branch, but don't know how...  PLEASE HELP?
