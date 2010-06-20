From: Sam Vilain <sam@vilain.net>
Subject: Suggested command in git-filter-branch(1)
Date: Sun, 20 Jun 2010 20:31:04 +1200
Message-ID: <1277022664.3728.1.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 20 10:31:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQFvw-0001Jh-Sp
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 10:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab0FTIbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 04:31:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42246 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755072Ab0FTIbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 04:31:09 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 8B92713E4A5; Sun, 20 Jun 2010 20:31:08 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [10.22.33.150] (cat11g.catalyst.net.nz [202.78.240.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 72D9A21C34F
	for <git@vger.kernel.org>; Sun, 20 Jun 2010 20:31:04 +1200 (NZST)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149391>

+* Remove the original refs backed up by git-filter-branch: say `git
+  for-each-ref \--format="%(refname)" refs/original/ | xargs -n 1 git
+  update-ref -d`.

This is sick.  I would normally just tell people to use 'rm
-rf .git/refs/original', if for some bizarre reason gc has packed
the .refs/original refs then I might do something like the above or
edit .git/packed-refs

How about 'git update-ref -dr refs/original' (and making that work) ?

Sam
