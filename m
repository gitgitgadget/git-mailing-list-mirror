From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] parse-opt: migrate fmt-merge-msg.
Date: Tue, 30 Sep 2008 12:10:14 -0700
Message-ID: <20080930191014.GH21310@spearce.org>
References: <1222595139-32087-1-git-send-email-madcoder@debian.org> <1222595139-32087-2-git-send-email-madcoder@debian.org> <20080929163523.GC18340@spearce.org> <20080930084019.GB11453@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:11:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkkd4-0008AZ-6o
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbYI3TKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753066AbYI3TKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:10:16 -0400
Received: from george.spearce.org ([209.20.77.23]:57462 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYI3TKP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:10:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 73BB53835F; Tue, 30 Sep 2008 19:10:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930084019.GB11453@artemis.corp>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97145>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Mon, Sep 29, 2008 at 04:35:23PM +0000, Shawn O. Pearce wrote:
> > Pierre Habouzit <madcoder@debian.org> wrote:
> > > Also fix an inefficient printf("%s", ...) where we can use write_in_full.
> > 
> > Near as I can tell, this is based upon a merge commit in next.
> 
> Hmm I've always sent my patches this way, and I believe you can git am
> -3 them on top of master easily. I can send you the updated series if
> you want.

I'd appreciate an updated series if you can send it.  am -3 isn't
"easily" applying it.  Here I define "easy" as "the patch applies
without me needing to resolve conflicts":

 $ git co -b ph/parseopt master
 $ git am -3 -s X
 Applying: parse-opt: migrate fmt-merge-msg.
 error: patch failed: builtin-fmt-merge-msg.c:5
 error: builtin-fmt-merge-msg.c: patch does not apply
 Using index info to reconstruct a base tree...
 Falling back to patching base and 3-way merge...
 CONFLICT (content): Merge conflict in builtin-fmt-merge-msg.c
 Recorded preimage for 'builtin-fmt-merge-msg.c'
 Failed to merge in the changes.
 Patch failed at 0001.
 When you have resolved this problem run "git am -3 --resolved".
 If you would prefer to skip this patch, instead run "git am -3 --skip".
 To restore the original branch and stop patching run "git am -3 --abort".

:-\

-- 
Shawn.
