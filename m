X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 10:06:55 -0500
Message-ID: <20061026150655.GG17019@over-yonder.net>
References: <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz> <20061025002713.GN17019@over-yonder.net> <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz> <20061025235306.GD17019@over-yonder.net> <45408A53.10400@op5.se> <20061026121253.GE17019@over-yonder.net> <ehq924$llq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 15:07:15 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ehq924$llq$1@sea.gmane.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30224>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd6ov-0001na-5Q for gcvg-git@gmane.org; Thu, 26 Oct
 2006 17:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752153AbWJZPG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbWJZPG6
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 11:06:58 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:35796 "EHLO
 optimus.centralmiss.com") by vger.kernel.org with ESMTP id S1752153AbWJZPG5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 11:06:57 -0400
Received: from draco.over-yonder.net
 (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213]) (using TLSv1
 with cipher ADH-AES256-SHA (256/256 bits)) (No client certificate requested)
 by optimus.centralmiss.com (Postfix) with ESMTP id 709B52842A; Thu, 26 Oct
 2006 10:06:56 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100) id DCC7861C5A;
 Thu, 26 Oct 2006 10:06:55 -0500 (CDT)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Oct 26, 2006 at 02:18:53PM +0200 I heard the voice of
Jakub Narebski, and lo! it spake thus:
> 
> You can get similar workflow in git using 'origin'/'master' pair, I
> think.

Not the same, because as soon as your 'git pull' _can_ fast-foward, it
will.  You can't merge a set of changes from another branch that's a
strict superset of yours in, without it fast-forwarding them.

I suppose you could take great care to ensure that the other branch is
never in a position to be fast-forwarded onto yours, most simply just
by making forced commits before you do a pull, but that's revolting.


-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
