X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: gitk broken or user error?
Date: Mon, 13 Nov 2006 00:20:07 -0500
Message-ID: <20061113052007.GA31551@spearce.org>
References: <m2irhkr467.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 05:20:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2irhkr467.fsf@ziti.local>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31290>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjUFB-0002l0-94 for gcvg-git@gmane.org; Mon, 13 Nov
 2006 06:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753923AbWKMFUM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 00:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbWKMFUM
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 00:20:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:22922 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753923AbWKMFUK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 00:20:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GjUEr-0002bK-R5; Mon, 13 Nov 2006 00:20:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 505A820E42F; Mon, 13 Nov 2006 00:20:07 -0500 (EST)
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> I get the following error when invoking gitk with any command line
> argument, for example, 'gitk --all':
> 
>     ziti:~/proj/R-devel seth$ gitk --all
>     Error in startup script: unknown option "-state"
>         while executing
>     ".bar.view entryconf 3 -state normal"
>         invoked from within
>     "if {$cmdline_files ne {} || $revtreeargs ne {}} {
>         # create a view for the files/dirs specified on the command line
>         set curview 1
>         set selec..."
>         (file "/Users/seth/scm/bin/gitk" line 6298)

You are not alone on this.  I see the same thing on my Mac and it
makes it quite difficult to use gitk.  However the same version of
gitk does not have this problem on Windows.  Its clearly related
to platform differences.

Of course Windows is unable to open a gitk window without it
being collapsed down to only the titlebar, and is also unable to
sucessfully reread the user's ~/.gitk file, but that's another bug...

I really should try to figure out what these problems are, but gitk
is 6323 lines of Tcl/Tk code which I'm not all too familiar with,
and I've got my own growing mass of ~2473 lines of Tcl/Tk code in
git-gui to worry about right now...

-- 
