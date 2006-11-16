X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Fri, 17 Nov 2006 00:36:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611170013590.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 23:37:14 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31637>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkqn1-0001Db-D0 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424267AbWKPXgh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162322AbWKPXgh
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:36:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:49867 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1162320AbWKPXgg (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:36:36 -0500
Received: (qmail invoked by alias); 16 Nov 2006 23:36:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 17 Nov 2006 00:36:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 16 Nov 2006, Linus Torvalds wrote:

> On Thu, 16 Nov 2006, Johannes Schindelin wrote:
> >
> > - a terrible UI.
> 
> Why? We _do_ have the temporary branch. It's called FETCH_HEAD.

It is a terrible UI, because it was not that obvious to me. And I consider 
myself not a git newbie.

Besides, it is not really a temporary branch. If it was, the pull would 
_not_ download all these objects again, would it?

> > _Also_, git-pull not storing the fetched branches at least temporarily 
> > often annoyed me: the pull did not work, and the SHA1 was so far away I 
> > could not even scroll to it.
> 
> Again, why didn't you use FETCH_HEAD?

Because I am a Jar-HEAD?

> If the user doesn't give us a head to write to, we clearly MUST NOT write 
> to any long-term branch. That would be a _horrible_ mistake. 

I was _not_ suggesting a long-term branch. Just a way to do-what-i-want 
and not waste bandwidth.

> And your "solution" is obviously totally unusable. git ABSOLUTELY MUST NOT 
> overwrite any existing branches unless explicitly told to do so by the 
> user.

Guess three times why I did not post the patches.

But the real problem is not necessarily the behaviour; it is the obscure 
fashion of the behaviour. You may not understand that problem, because you 
were there from the beginning. You saw the big-bang and how all the 
quarks formed all of a sudden, and how matter and eventually planets 
and suns came into being.

But others (me included) were not there. Or they did not really watch. And 
now they see all these creatures, and plants, and bacteria, and they do 
not understand how these are all connected, because of that. And now they 
think "wow that must have been some intelligent design, and really a 
miracle, and I cannot understand how it works." But that is not true 
(the latter part of course).

There is something to be said about the simplicity of Mercurial. It's 
inner workings may suck, but people get easily attracted by it.

I do not claim we should imitate Mercurial, or even hide the index (even 
if I sometimes wonder if the index is not just a clever way to accelerate 
commits, and nothing more).

> So I really don't see your point. 
> 
> A lot of the complaints seem to not be about the interfaces, but about 
> people not _understanding_ and knowing what the interfaces do.

But the interfaces should be usable interfaces! They should _explain_ what 
they do. Other software does so, it can't be _that_ hard.

> 	git merge "$(git fmt-merge-msg < .git/FETCH_HEAD)" HEAD FETCH_HEAD

I find that quite easy to understand. Why? Because I happen to _know_ the 
syntax of -merge and -fmt-merge-msg. For similar reasons I _understand_ 
why -pull behaves like it does. But others don't; they will shudder and 
then run.

Maybe it is not important that -pull fetches all objects all over again. 
But it _is_ important to make things like merging branches (local or 
remote) trivial. It _is_ important to make the user experience be fun.

Ciao,
Dscho
