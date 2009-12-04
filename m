From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri, 4 Dec 2009 07:50:09 -0800
Message-ID: <20091204155009.GA1483@spearce.org>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:52:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaQF-00060B-9P
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbZLDPuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbZLDPuH
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:50:07 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:61448 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbZLDPuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:50:06 -0500
Received: by qyk30 with SMTP id 30so1104412qyk.33
        for <git@vger.kernel.org>; Fri, 04 Dec 2009 07:50:12 -0800 (PST)
Received: by 10.224.52.200 with SMTP id j8mr1752678qag.326.1259941812543;
        Fri, 04 Dec 2009 07:50:12 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 15sm1580283yxh.4.2009.12.04.07.50.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 07:50:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1259934977.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134517>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This patch series adds "fix" to the commands that can be used within
> the "rebase --interactive" patch editor.  "fix" is like "squash"
> except that it discards the log message of the corresponding commit.
...
> But sometimes I don't have my head-slapping moments until a few
> commits later.  In this case, my usual practice is to commit the
> trivial typo change on top of the current branch, then "rebase
> --interactive" to move the typo fix on top of the erroneous commit and
> squash it:
...
> pick 05d3b81 Commit with typo
> squash 5eb3299 Fix for typo
> pick c29114a Good commit 1
> pick 250b013 Good commit 2

+1 for fix.  Totally.

When developing I *often* have not just 1 to squash, but 10 or so
in a single rebase -i session, all with useless commit messages like
"a", "s", or "foo".  Given that I also have a commit-msg hook which
injects additional lines into each of those messages, squash can be
annoying to use...

fix would be really cool.  To be honest, its my most common use
of squash... to use the first commit's message, but combine in the
misc. idiot fixes I've collected since I wrote that commit.

-- 
Shawn.
