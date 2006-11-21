X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 19:06:43 +0100
Message-ID: <20061121180643.GC7201@pasky.or.cz>
References: <200611211341.48862.andyparkins@gmail.com> <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com> <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 18:07:11 +0000 (UTC)
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32010>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gma1C-0004UA-VD for gcvg-git@gmane.org; Tue, 21 Nov
 2006 19:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031251AbWKUSGr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 13:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031246AbWKUSGq
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 13:06:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47841 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031256AbWKUSGq (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 13:06:46 -0500
Received: (qmail 932 invoked by uid 2001); 21 Nov 2006 19:06:43 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 05:31:30PM CET, Linus Torvalds wrote:
> git didn't end up doing that (and I'm personally pretty happy about it), 
> but it was one of the things I was kind of thinking about: a "git import" 
> kind of thing would have created an initial commit which was pre-populated 
> with the thing to import, and a "git init-db" would have created an 
> initial root commit that was empty.
> 
> That would have made the current "don't show the root diff" behaviour very 
> natural (and you'd still have gotten the initial diff for a new project), 
> but on the other hand, it would have had that annoying unnecessary "init" 
> commit, and you'd _still_ have wanted to have something like "--root" in 
> order to show the import commit as a patch (which you _sometimes_ want to 
> do).

It's being asked by users time by time (first in April last year ;) and
I'm not sure about any good answer I should tell them, so is the reason
for not doing the implicit empty commit that it would be "annoying" I
suppose in the log output?

Is that a reason good enough?

It would solve some of these annoying corner cases nicely, and you can
still hide this empty commit from log output etc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
