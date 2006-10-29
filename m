X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sat, 28 Oct 2006 19:04:40 -0700 (PDT)
Message-ID: <672246.46875.qm@web31808.mail.mud.yahoo.com>
References: <200610290258.31771.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 02:04:51 +0000 (UTC)
Cc: Luben Tuikov <ltuikov@yahoo.com>, Junio Hamano <junkio@cox.net>,
	Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GsbU8yd9d5AHn481ApiVOEPmUdCaq1Op2QegYZXeC63QmRP1vXQUrQfwhlPwyQybwoBa+X8pDXQH1815eDiz1vd4R8nkbyv4w/H36PyiyIHuBo5CiEFp8cO33FnFPOraJbIvbR1JIITZ2JI5CfwXWHhVCpK4SeotReE570VSXjM=  ;
X-YMail-OSG: 6qXiRjUVM1k7ksBmLmWn8j2OGlyLu_9pOwSlw3ompqskNXRIXkr64qJvwytYc73TIqsXdtonuWr8zAW74ODhn5hB8fHl9_8wt7tRJ7brIHR47Prj4SMDjPzt_.6coGID5QhT6mNYP1E-
In-Reply-To: <200610290258.31771.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30406>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge02Y-0000g7-KC for gcvg-git@gmane.org; Sun, 29 Oct
 2006 03:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751467AbWJ2CEm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 22:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWJ2CEm
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 22:04:42 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:57691 "HELO
 web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1751467AbWJ2CEl (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006
 22:04:41 -0400
Received: (qmail 47883 invoked by uid 60001); 29 Oct 2006 02:04:40 -0000
Received: from [71.80.233.118] by web31808.mail.mud.yahoo.com via HTTP; Sat,
 28 Oct 2006 19:04:40 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> > --- Jakub Narebski <jnareb@gmail.com> wrote:
> >> Jakub Narebski wrote:
> >>> Add a kind of "next" view in the bottom part of navigation bar for
> >>> "commitdiff" view.
> >>> 
> >>> For commitdiff between two commits:
> >>>   (from: _commit_)
> >>> For commitdiff for one single parent commit:
> >>>   (parent: _commit_)
> >>> For commitdiff for one merge commit
> >>>   (merge: _commit_ _commit_ ...)
> >>> For commitdiff for root (parentless) commit
> >>>   (initial)
> >>> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
> >>> display, everything is perhaps unnecessary esc_html on display.
> [...]
> >> 
> >> Any reasons not to accept this patch? I find it very useful.
> >> 
> >> The idea to use fixed string instead of shortened SHA-1 of commit
> >> was abandoned after some discussion in this thread.
> > 
> > I prefer using the commit-8 without any "..." postfixed.  Anyone who
> > knows squat about git knows very well what a commit-8 is when they
> > see one -- the first 8 hexadecimal digits of the full SHA-1.
> > 
> > I like using "next" only when there is a "prev" right next to it,
> > i.e. based on _context_, something like this:
> >    << prev next>>
> > where "<< prev" is hyperlinked, and "next>>" is also.
> 
> Unfortunately this is simply not possible in this case, as links in git
> are only from commit to paren(a), in one direction only.

I was not suggesting that.  I simply saw a "next" suggestion in this
thread and wanted to mention about "next", "prev" and context.

> It is commit-7, but that can be easily changed.

Please do change it to "commit-8" -- it'd be consistent with the rest
of GIT.

> > Acked-by: Luben Tuikov <ltuikov@yahoo.com>
> > (not that it matters in any way ;-) )
> 
> IIRC Junio asked for ACKs.

In this email, it seems that he's asking for, quoting,
 "Acked-by:":
http://marc.theaimsgroup.com/?l=git&m=116206206008374&w=2

      Luben
