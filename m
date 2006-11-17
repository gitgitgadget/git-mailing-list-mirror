X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Fri, 17 Nov 2006 18:50:46 +0100
Message-ID: <455DF676.3090001@gmx.net>
References: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org> <20061117162605.GA32597@spearce.org> <87bqn6qav2.wl%cworth@cworth.org> <20061117171532.GE32597@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 17:54:54 +0000 (UTC)
Cc: junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bsn-77-114-200.dial-up.dsl.siol.net
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
In-Reply-To: <20061117171532.GE32597@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31719>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl7vF-0003ES-6H for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933750AbWKQRyh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933751AbWKQRyh
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:54:37 -0500
Received: from main.gmane.org ([80.91.229.2]:37255 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933750AbWKQRyh (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:54:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl7ur-00039c-01 for git@vger.kernel.org; Fri, 17 Nov 2006 18:54:17 +0100
Received: from bsn-77-114-200.dial-up.dsl.siol.net ([193.77.114.200]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 18:54:16 +0100
Received: from marko.macek by bsn-77-114-200.dial-up.dsl.siol.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17
 Nov 2006 18:54:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Carl Worth <cworth@cworth.org> wrote:
>> Yes, this was my exact thought when reading what Linus
>> wrote. ORIG_HEAD might be fine and all, but it pales in functionality
>> compared to what reflog provides.
>>
>> I would very much like to see reflog getting first-class citizen
>> support in git:
>>
>> 1. Be on by default

I agree.

> I have:
> 
> 	git repo-config --global core.logAllRefUpdates true
> 
> especially since Junio fixed it to only create logs for heads and
> not tags.  That way its on by default for me.  But I think it should
> be on by default in the next version of Git.

Why is it not useful for tags for having logs? 

I also have a question:

Does git-fsck-objects/prune check the ref logs?

Mark
