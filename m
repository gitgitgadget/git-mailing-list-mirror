From: Unknown <borg@uu3.net>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Mon, 29 Jun 2009 21:39:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906292131330.27727@cube>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628224447.GB1951@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 21:39:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLMhN-0004E3-TP
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 21:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZF2TjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbZF2TjS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 15:39:18 -0400
Received: from borg.uu3.net ([87.99.63.19]:49366 "EHLO borg.uu3.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbZF2TjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 15:39:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.uu3.net (Postfix) with ESMTP
	id 8DAD9633D1; Mon, 29 Jun 2009 21:39:18 +0200 (CEST)
X-X-Sender: borg@cube
In-Reply-To: <20090628224447.GB1951@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122455>

On Sun, 28 Jun 2009, David Aguilar wrote:

> Hello
Hi and thanks for reply.

> Please take a look at Documentation/SubmittingPatches
> (all of the documentation lives in Documentation/).
>
> It doesn't seem like this patch was generated with
> git format-patch.  You'll also want to submit your patch using
> git send-email, as we require inline patches instead of
> attachments.
Right. I though such a small patch can be provided as is.
Anyway, I will take necessary steps to peform better next time.

The question is, would that patch will be applied anyway?
I already received some criticism about not applying it.
I can only answer that where svn status and git status differ in many 
cases, there are also similar in some.

For now, I would rather want to see a discus about it (Pro vs Cons).

Other solution I see is add extra config variable like:
status.showUntrackedDefault = (no|normal|all)
So when you peform 'git status -u' it will be used.

Looks better to me if we really want to have difference between
git status vs svn status.

Regards,
Borg
