From: dave morgan <morgad@eclipse.co.uk>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 19:03:51 +0100
Organization: the great unwashed
Message-ID: <aomfl115b28jajpuspik2es90qhlr9dtdg@4ax.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com> <118833cc0510200715x2a17dcbfs53c824435b7381e3@mail.gmail.com>
Reply-To: david morgan <morgad@eclipse.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Thu Oct 20 20:07:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESeln-00020J-Oc
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 20:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVJTSEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 14:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVJTSEA
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 14:04:00 -0400
Received: from mra03.ch.as12513.net ([82.153.252.25]:47045 "EHLO
	mra03.ch.as12513.net") by vger.kernel.org with ESMTP
	id S932513AbVJTSD7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 14:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by mra03.ch.as12513.net (Postfix) with ESMTP id 0F952D44A6
	for <git@vger.kernel.org>; Thu, 20 Oct 2005 19:03:53 +0100 (BST)
Received: from mra03.ch.as12513.net ([127.0.0.1])
 by localhost (mra03.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28006-01-15 for <git@vger.kernel.org>;
 Thu, 20 Oct 2005 19:03:52 +0100 (BST)
Received: from unknown (unknown [82.152.150.47])
	by mra03.ch.as12513.net (Postfix) with SMTP id 556A5D4351
	for <git@vger.kernel.org>; Thu, 20 Oct 2005 19:03:51 +0100 (BST)
To: git@vger.kernel.org
In-Reply-To: <118833cc0510200715x2a17dcbfs53c824435b7381e3@mail.gmail.com>
X-Mailer: Forte Agent 3.1/32.783
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10374>

On Thu, 20 Oct 2005 10:15:58 -0400, Morten Welinder
<mwelinder@gmail.com> wrote:

>I see the very same with an http pull.
>
>Morten
>-
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

I got the same with a git:// update

origin  git://git.kernel.org/pub/scm/git/git.git	

david@tower2:~/git$ cg-update
Up to date.

Applying changes...
Merging f8765797a41a39f4dfc7030098c38283e6461a83 ->
6e1c6c103c522d01829f3a63992a023ff031e851
        to ea5a65a59916503d2a14369c46b1023384d51645...
... Auto-merging fetch-pack.c
merge: warning: conflicts during merge

        Conflicts during merge. Do cg-commit after resolving them.

here is status after pull
david@tower2:~/git$ cg-status
Heads:
   >master      ea5a65a59916503d2a14369c46b1023384d51645
  R origin      6e1c6c103c522d01829f3a63992a023ff031e851

? git-build-rev-cache
? git-checkout-cache
? git-convert-cache
? git-diff-cache
? git-diff-helper
? git-export
? git-fsck-cache
? git-http-pull
? git-local-pull
? git-merge-cache
? git-rev-tree
? git-show-rev-cache
? git-update-cache

Dave
