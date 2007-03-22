From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 12:40:21 +0200
Message-ID: <20070322104021.GJ29341@mellanox.co.il>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
	<20070322074051.GA29341@mellanox.co.il>
	<7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
	<20070322083757.GC29341@mellanox.co.il>
	<7vr6rhtvr0.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 11:39:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUKhz-0001Nc-B6
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 11:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbXCVKjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 06:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbXCVKjk
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 06:39:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:25363 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030455AbXCVKjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 06:39:39 -0400
Received: by ug-out-1314.google.com with SMTP id 44so646577uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 03:39:37 -0700 (PDT)
Received: by 10.67.101.10 with SMTP id d10mr4671887ugm.1174559977375;
        Thu, 22 Mar 2007 03:39:37 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id i39sm3013389ugd.2007.03.22.03.39.36;
        Thu, 22 Mar 2007 03:39:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr6rhtvr0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42857>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Specifically, as far as a *user* is concerned:
> > 1. the fact that "---" separates commit message from patch, and
> >    that text after "---" is ignored seems to be undocumented
> > 2. the fact that message subject is appended to the log,
> >    the rules for removing [PATCH] etc from subject seem to be undocumented
> > 3. if I want to have some text coming *before* the commit
> >    message ignored, there's no way to do this
> > 4. there's no way to override the subject from within the message
> >    (like there is with author/From line)
> 
> How about this?

Looks good. What about 3?
> 
> 
> Also check t5100 and its sample mailbox,
> especially the "third patch" from A U Thor, which I forwarded
> with the subject "another patch".

It's funny ... but what should I look at there, specifically?

-- 
MST
