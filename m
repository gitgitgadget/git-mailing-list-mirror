From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Remove excessively redundant entries from git_difftree_body
Date: Thu, 28 Sep 2006 11:28:42 -0700 (PDT)
Message-ID: <20060928182843.83600.qmail@web31802.mail.mud.yahoo.com>
References: <7vmz8k7nhc.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 20:29:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT0cq-0007fe-Px
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 20:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWI1S2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWI1S2q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 14:28:46 -0400
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:51047 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030351AbWI1S2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 14:28:45 -0400
Received: (qmail 83602 invoked by uid 60001); 28 Sep 2006 18:28:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5pt9s3O8/+vws4D85fxSbGePLr2mgfYi71Y6OLHonfByFnou/Jpn3qTVE4Yy9BvbguN5ereiHX848X7AolY+XqEQX3L5u+2zrppM4v9ud7gNHW9r0WHRxBTmVGXIG3ppWP0LMXIt2IROBmffkiO91VC2za/56OXEH/NlbVye13U=  ;
Received: from [64.215.88.90] by web31802.mail.mud.yahoo.com via HTTP; Thu, 28 Sep 2006 11:28:42 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz8k7nhc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28030>

--- Junio C Hamano <junkio@cox.net> wrote:
> We lost blobdiff from commitdiff page with this patch, which I
> think it probably is a good change.  We can say "when we display
> a pathname you can click it to get the blob or tree".

I think so too.

> By the way, just like your "blob" and "tree" link removal, I
> think we can lose "commit" link in shortlog.  The list looks
> rather cluttered with three links; we could replace it with
> "snapshot" link if we wanted to.

I agree.

   Luben

> I am neutral about doing that for long log pages.  The commit
> titles are links there as well, but they do not look like "one
> of the columns that can be clicked in a single line per row
> table" as in shortlog page.  The page could also get "snapshot"
> links.
> 
> 
> 
> 
> 
