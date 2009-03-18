From: Frank Li <lznuaa@gmail.com>
Subject: reflog hash show wrong when delete a entry
Date: Wed, 18 Mar 2009 12:36:29 +0800
Message-ID: <1976ea660903172136r2b16144ep6cdf9aef049d34f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 05:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjnXV-0007IG-F3
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 05:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbZCREgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 00:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZCREgc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 00:36:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:51264 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbZCREgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 00:36:31 -0400
Received: by wf-out-1314.google.com with SMTP id 29so406841wff.4
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 21:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Ox/gLrrfGxvIYjXzE1zjNuegSYjEgHWkQP91/chsY+s=;
        b=wBHttmvjLN5Qm4jm+Yk1DMHqARbL6rxYihzNUt+ZkyxcIKkWDo2lETc91tfmAlMgqP
         BcQRIh6w5gruigCyiGNFPbae52s9pBWAPDanWwDPcRIasqk6mhcaEXsebm8N/SEByjT0
         UNcfa3QgyjujvJslpLH8Yr72MF0KGt/AMJKUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=EIKBtmdW85Fg1T5mK0XcUNsnw0CmZUoxScxIhiJcL2SxumQumEC6Qk+2aiDsTc6ipF
         cXa3Q/7gu8hFSQrgJULintP5cT2jk28dKkEX8VJR2BsnZmhQ5DPYVkZFJhqL3T4PCRvf
         n2Hg3lXR6jQW0YLU3YXcGJ+FC6XQBr6wIIJNQ=
Received: by 10.141.210.13 with SMTP id m13mr149623rvq.181.1237350989769; Tue, 
	17 Mar 2009 21:36:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113573>

git reflog show master

ac3f132 master@{0}: commit: Stash list using reflog dialog.
a24e038 master@{1}: commit: Reflog dialog basic work
cf4e18d master@{2}: commit: Parser Reflog output
d58c869 master@{3}: commit: RefLogDlg: Show ref list at dropdownlist
d3dcc9b master@{4}: commit: Add Submodule Add and reflog Dialog
7a60d02 master@{5}: commit: Add Submodule Command
a6a192b master@{6}: a6a192baa48ce58105ca254aff66bda135b376f6: updating HEAD

git reflog delete master@{2}


ac3f132 master@{0}: commit: Stash list using reflog dialog.
a24e038 master@{1}: commit: Reflog dialog basic work
*cf4e18d* master@{2}: commit: RefLogDlg: Show ref list at dropdownlist
d3dcc9b master@{3}: commit: Add Submodule Add and reflog Dialog
7a60d02 master@{4}: commit: Add Submodule Command
a6a192b master@{5}: a6a192baa48ce58105ca254aff66bda135b376f6: updating HEAD
d699182 master@{6}: am: Boost as submodule
1ca1d68 master@{7}: am: Removed boost to add it as submodule

I think now master@{2} should be d58c869, master@{3} before delete.
