X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 26 Nov 2006 02:32:20 +0100
Message-ID: <20061126013220.GD24909@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com> <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org> <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061126011420.GI20094MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 01:33:26 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061126011420.GI20094MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32315>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go8tT-0003Z1-G5 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 02:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935228AbWKZBdO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 20:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935229AbWKZBdO
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 20:33:14 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:28548 "EHLO
 smtp1-g19.free.fr") by vger.kernel.org with ESMTP id S935228AbWKZBdO (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 20:33:14 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp1-g19.free.fr (Postfix) with ESMTP id E51889B3FC;
 Sun, 26 Nov 2006 02:33:10 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id 71AFF201C;
 Sun, 26 Nov 2006 02:32:20 +0100 (CET)
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org

On Sun, Nov 26, 2006 at 02:14:20AM +0100, Sven Verdoolaege wrote:
> Likewise, when you commit in the superproject, it should simply record
> the changes to the "content" of the subproject and not change it.
> And the content of the subproject is a commit, so a commit in the
> superproject should not change the content of the subproject by creating
> another commit in the subproject.

I've realized after suggesting that how much that idea was inadequate -
sorry for the noise.

However, I'm not yet buying the idea that "the content of the subproject
is a commit" :)

Best regards,
-- 
