From: Andrew Morton <akpm@linux-foundation.org>
Subject: git://oss.sgi.com broke
Date: Fri, 3 Oct 2008 12:19:03 -0700
Message-ID: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: xfs-masters@oss.sgi.com
X-From: git-owner@vger.kernel.org Fri Oct 03 21:20:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlqCm-00042O-SG
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 21:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYJCTTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 15:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbYJCTTi
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 15:19:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51900 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427AbYJCTTh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Oct 2008 15:19:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m93JJ3nv001665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Oct 2008 12:19:04 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m93JJ3oX011554;
	Fri, 3 Oct 2008 12:19:03 -0700
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.325 required=5 tests=AWL,BAYES_00,WEIRD_PORT
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97443>

y:/usr/src/git26> git --version
git version 1.5.6.rc0

y:/usr/src/git26> cat .git/branches/git-xfs
git://oss.sgi.com:8090/xfs/xfs-2.6.git#master

y:/usr/src/git26> git-fetch git-xfs        
remote: usage: git-pack-objects [{ -q | --progress | --all-progress }] 
remote:         [--max-pack-size=N] [--local] [--incremental] 
remote:         [--window=N] [-remote: -window-memory=N] [--depth=N] 
remote:         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] 
remote:         [--threads=N] [--non-empty] [--reremote: vs [--unpacked | --all]*] [--reflog] 
remote:         [--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header

It was OK yesterday.

(cc'ing the git list in case this is an faq?)

The last two error messages there look wrong/misleading?
