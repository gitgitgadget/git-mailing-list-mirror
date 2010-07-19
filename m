From: Shilpa Kulkarni <syk@payasonline.com>
Subject: Git Config Question
Date: Sun, 18 Jul 2010 22:04:27 -0700
Message-ID: <AANLkTin8tW_qiRO57F-yjYHzhUkrZbO1g3L_hmesenGL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 07:04:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaiWz-0000Gu-3H
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 07:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711Ab0GSFEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 01:04:30 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45869 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0GSFE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 01:04:29 -0400
Received: by yxn35 with SMTP id 35so841324yxn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 22:04:28 -0700 (PDT)
Received: by 10.101.134.6 with SMTP id l6mr4150459ann.91.1279515868006; Sun, 
	18 Jul 2010 22:04:28 -0700 (PDT)
Received: by 10.101.126.5 with HTTP; Sun, 18 Jul 2010 22:04:27 -0700 (PDT)
X-Originating-IP: [206.132.194.9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151243>

Hi

We are using git with a centralized repo. Some of the developers are
on windows, some are on linux. The build system (ant & ruby scripts
are used for build) runs on linux. The server on which the software
product is deployed runs on linux. We see a frequent problem:
1. Person X clones a repo.
So far all is good.
2. Person Y checks in code (commit & push). Checks in file a, b.
3. Person X does a 'git pull origin master'. Pull succeeds - however
'git status' shows file a, b as modified even though person X has done
nothing with these files. 'git checkout' does not work. Files keep
getting showed as modified. If person X wants to commit any changes -
he is forced to commit file a & b.

This happens only sometimes - but it is frequent. It is not specific
to whether Person Y was on linux or windows. Would having the right
configs solve this problem? Any guidelines on what config we should
use?

Someone has recommended we all use
core.safecrlf=false
core.autocrlf=false
But this would require running dos2unix cmd while running scripts on
linux which seems like an overhead.

Are these the only two configs that are important?

Any help is appreciated....

-Shilpa
