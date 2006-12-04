X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: egit/jgit wishlist
Date: Mon, 4 Dec 2006 19:16:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
References: <20061204172836.GB6011@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Mon, 4 Dec 2006 18:16:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061204172836.GB6011@spearce.org>
X-Virus-Scanned: amavisd-new at alpha
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33212>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIMp-0002ie-EU for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937145AbWLDSQV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937160AbWLDSQV
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:16:21 -0500
Received: from alpha.polcom.net ([83.143.162.52]:55429 "EHLO
 alpha.polcom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937145AbWLDSQU (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 13:16:20 -0500
Received: from localhost (localhost [127.0.0.1]) by alpha.polcom.net
 (Postfix) with ESMTP id DE8E64ADB; Mon,  4 Dec 2006 19:16:17 +0100 (CET)
Received: from alpha.polcom.net ([127.0.0.1]) by localhost (alpha
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 01974-16; Mon,  4 Dec
 2006 19:16:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by alpha.polcom.net
 (Postfix) with ESMTP id 02CFD4333; Mon,  4 Dec 2006 19:16:13 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, 4 Dec 2006, Shawn Pearce wrote:
> I've started a wishlist:
>
>  http://git.or.cz/gitwiki/EclipsePluginWishlist
>
> My idea is to work through these in the order shown on the page.
> I'm looking for comments from those who may be interested in this
> plugin, to see what they want/need to make it useful.
>
> There's many months worth of work listed there, especially with
> the amount of time that I have available for jgit/egit.  So I'm of
> course also hoping that others might see something there and try
> to implement it themselves.  :-)

Hi,

I am interested in seeing GIT support in Eclipse.

I think that doing it in 100% pure Java is ok in long run but I wonder if 
you couldn't make "wrapper" plugin for a start (that would call the real C 
git for every operation) and make it usable (with full pure Java SWT UI 
support) and then try to implement feature by feature in pure Java (with 
config options telling what should be called by wrapper and what by pure 
implementation)?

This way we could probably rather fast (basic versions of other GIT UIs 
were created rather fast IIRC) have basic support for GIT (preferably 
with GIT Java wrapper library for other projects) that would be usable for 
most users and this way you could gain more interest in the project. Also 
testing new pure implementation would be a lot easier (changing one line 
in config file to enable some pure Java feature and of course having an 
option to come back to wrapped version of this feature if new pure 
implementation was wrong).

What do you think about it?


Thanks,

Grzegorz Kulewski
