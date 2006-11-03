X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthew Hannigan <mlh@zip.com.au>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 3 Nov 2006 14:43:48 +1100
Message-ID: <20061103034348.GB27189@evofed.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca> <20061020172125.GF18019@spearce.org> <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org> <9e4733910610201115g1790b5am55105bf0c662a0da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 03:41:45 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <9e4733910610201115g1790b5am55105bf0c662a0da@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30782>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfpw0-0000GR-5n for gcvg-git@gmane.org; Fri, 03 Nov
 2006 04:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753026AbWKCDla (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 22:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753027AbWKCDla
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 22:41:30 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:30854 "EHLO
 mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP id
 S1753024AbWKCDl3 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 22:41:29 -0500
Received: from evofed.localdomain (c211-30-60-241.belrs1.nsw.optusnet.com.au
 [211.30.60.241]) by mail16.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP
 id kA33f2SZ011108; Fri, 3 Nov 2006 14:41:03 +1100
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, Oct 20, 2006 at 02:15:15PM -0400, Jon Smirl wrote:
> [ ... ] 
> You could have a file of macro substitutions that is applied/expanded
> when files go in/out of git. The macros would replace the copyright
> notices improving the move/rename tracking and the reducing repository
> size. The macros could be recorded out of band to eliminate the need
> for escaping the file contents. Even simpler, the only valid place for
> the macro could be the beginning of the file.

That probably belongs in the class of transformations
best done outside the VCS such as the permissions 
and system config file idea Linus outlined earlier.


Matt
