X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 19:21:35 +0100
Message-ID: <20061121182135.GD7201@pasky.or.cz>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org> <20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:21:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejvfng$cj6$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32013>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmaFY-0007qa-ND for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031249AbWKUSVh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031266AbWKUSVh
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:21:37 -0500
Received: from w241.dkm.cz ([62.24.88.241]:34225 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031249AbWKUSVh (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:21:37 -0500
Received: (qmail 2119 invoked by uid 2001); 21 Nov 2006 19:21:35 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 07:16:44PM CET, Jakub Narebski wrote:
> Petr Baudis wrote:
> 
> > On Tue, Nov 21, 2006 at 05:31:30PM CET, Linus Torvalds wrote:
> >> git didn't end up doing that (and I'm personally pretty happy about it), 
> >> but it was one of the things I was kind of thinking about: a "git import" 
> >> kind of thing would have created an initial commit which was pre-populated 
> >> with the thing to import, and a "git init-db" would have created an 
> >> initial root commit that was empty.
> >> 
> >> That would have made the current "don't show the root diff" behaviour very 
> >> natural (and you'd still have gotten the initial diff for a new project), 
> >> but on the other hand, it would have had that annoying unnecessary "init" 
> >> commit, and you'd _still_ have wanted to have something like "--root" in 
> >> order to show the import commit as a patch (which you _sometimes_ want to 
> >> do).
> > 
> > It's being asked by users time by time (first in April last year ;) and
> > I'm not sure about any good answer I should tell them, so is the reason
> > for not doing the implicit empty commit that it would be "annoying" I
> > suppose in the log output?
> 
> git repo-config show.difftree --root
> git repo-config whatchanged.difftree --root

That means extra pointless setup and is besides the point anyway, I was
asking about empty commits, not default command settings.

BTW, the other frequent reason why empty commits come up so frequently
is a FAQ "how do I create an unrelated branch in my repository" - their
idea is that they will create a new branch starting with an empty commit
(of course noone would think of anything like that in inferior VCSes
because replacing the checked out trees would took forever; how cool Git
is!).

(The answer is usually "create the branch in a separate repo and then
fetch it to the original one". But it feels a bit kludgy given the
otherwise seamless support for unrelated branches. (Not that I ever was
a big fan of unrelated long-lived branches in general.))

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
