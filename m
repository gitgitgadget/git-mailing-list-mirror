X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Sat, 2 Dec 2006 17:49:42 -0800
Message-ID: <20061203014942.GF1369@localdomain>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net> <456D36CE.1060300@midwinter.com> <20061129085419.GB4486@hand.yhbt.net> <m2wt5es0r3.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 01:49:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2wt5es0r3.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33080>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqgUI-0006H0-Ba for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424797AbWLCBto (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759470AbWLCBto
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:49:44 -0500
Received: from hand.yhbt.net ([66.150.188.102]:17050 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1758633AbWLCBto (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:49:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id CA9042DC034; Sat,  2 Dec 2006 17:49:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 02 Dec 2006
 17:49:42 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > I've been considering something along those lines.  I'm interested in
> > renaming the current 'commit' command to something else (it still has
> > its uses), but I haven't figured out what to call it...
> 
> I think this would be a sensible change and will help new users get
> started with git-svn.  
> 
> > Also, something that can wrap (git commit && git svn dcommit) into one
> > step would be nice.
> 
> For my workflow, that wouldn't be all that useful.  I find that I
> accumulate a few commits locally and then send them all to svn.  For
> this workflow, what would be useful is if dcommit could understand a
> command like:
> 
>     git svn dcommit remotes/git-svn..HEAD~2
> 
> Sometimes I realize I should have sent a stack of commits to svn, but
> now have some newer commits that aren't quite ready on the head of my
> branch.  
> 
> While the workaround is easy (create a new branch and dcommit from
> it), I think there is a usability argument in that when one
> sees an example like dcommit foo..bar, one expects all
> the other magic to work.  I feel for this and accidentally committed a
> few commits I didn't want to send.  If nothing else, perhaps git-svn
> could error out and say, "hey, I don't do that".

Aded to my ever-growing git-svn todo list.   Patches welcome :)

-- 
