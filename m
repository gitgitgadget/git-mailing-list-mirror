X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 17:55:00 -0500
Message-ID: <20061030225500.GG3617@delft.aura.cs.cmu.edu>
References: <20061029093754.GD3847@spearce.org> <Pine.LNX.4.64.0610301332440.11384@xanadu.home> <20061030202611.GA5775@spearce.org> <20061030205200.GA20236@delft.aura.cs.cmu.edu> <7v3b95wjmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:55:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3b95wjmg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30545>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geg27-0007gf-NB for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422732AbWJ3WzE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWJ3WzD
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:55:03 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:30172 "EHLO
 delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP id S1422732AbWJ3WzC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:55:02 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
 (envelope-from <jaharkes@cs.cmu.edu>) id 1Geg20-0000e3-Qv; Mon, 30 Oct 2006
 17:55:00 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Oct 30, 2006 at 01:59:03PM -0800, Junio C Hamano wrote:
> Jan Harkes <jaharkes@cs.cmu.edu> writes:
> 
> > The following patch does fix the problem Nicolas reported, but for some
> > reason I'm still getting only 102 objects (only tags and the commits
> > they refer to?) with your test.
> 
> One potential downside of this is that this makes an obscure but
> useful "gitk --unpacked" useless (robs performance).
> 
> http://thread.gmane.org/gmane.comp.version-control.git/19197/focus=19207

If I use 'git fetch' followed later on by a 'git fetch -k', the result
from --unpacked would not include the unpacked objects created by the
first fetch. Although it may have been fast, it seems to be somewhat
counter-intuitive.

> But other than that, I think it is an Ok change.  The original
> semantics of --unpacked (with or without "pretend as if objects
> in this pack are loose") were, eh, "strange".

Do you need a resend with a proper 'Signed-Off-By' line?

Jan
