X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 00:42:03 +0100
Message-ID: <20061123234203.GN7201@pasky.or.cz>
References: <20061123225835.30071.99265.stgit@machine.or.cz> <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 23:42:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32178>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnOCq-0004sl-J1 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757498AbWKWXmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757499AbWKWXmJ
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:42:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:28067 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1757498AbWKWXmG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:42:06 -0500
Received: (qmail 1878 invoked by uid 2001); 24 Nov 2006 00:42:03 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, Nov 24, 2006 at 12:12:10AM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > and --use-immingled-remote can be used to get the original behaviour;
> > it is also implied by --bare.
> 
> What's immingled?

One dictionary says

   Immingle \Im*min"gle\, v. t.
      To mingle; to mix; to unite; to blend. [R.] --Thomson.

but perhaps it's too much an obscure word... better suggestions
welcomed.

> > We get confused, frustrated and data-losing users *daily* on #git now
> > because git-clone still produces the crippled repositories having the
> > remote and local heads freely mixed together.
> >
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> Being strongly opinionated, not giving enough credit for the
> evolutionary process behind the history and venting frustration
> in the proposed commit log message is never a good strategy to
> get the patch applied.

Yes, sorry, the last days were a bit tiring to me.

I'm not sure what evolutionary process should I describe, though...

> Even though I fully agree that use-separate-remotes should be
> the default, to the point that I do not think we do not even
> need a backward compatibility option.  People who want to use
> traditional layout for simple one-remote-branch-only project
> would not suffer anyway because 'origin' still means origin in
> the new layout (refs/remotes/origin/HEAD).

I don't know, we still at least need to keep the functionality for
--bare.

> We would need to update the tutorials to match this,though.  I
> think it talks about the traditional layout and say 'See, now
> you can run "ls .git/refs/heads/{master,origin}"' or something
> like that.

Oops, yes. I can try to go through the tutorials during tomorrow or the
next week...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
