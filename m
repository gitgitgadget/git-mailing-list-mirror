From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] remove shortlog from git-commit output
Date: Mon, 16 Apr 2007 21:23:23 +0300
Message-ID: <20070416182323.GC32515@mellanox.co.il>
References: <20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416053435.GA23255@mellanox.co.il>
	<7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
	<20070416144038.GA32515@mellanox.co.il>
	<Pine.LNX.4.64.0704161554540.5400@reaper.quantumfyre.co.uk>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdVrZ-0002X2-Uz
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 20:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbXDPSXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 14:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbXDPSXY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 14:23:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:34453 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbXDPSXY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 14:23:24 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1183206uga
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 11:23:22 -0700 (PDT)
Received: by 10.66.232.10 with SMTP id e10mr4491265ugh.1176747802464;
        Mon, 16 Apr 2007 11:23:22 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id j2sm6666283ugf.2007.04.16.11.23.20;
        Mon, 16 Apr 2007 11:23:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704161554540.5400@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44683>

> Quoting Julian Phillips <julian@quantumfyre.co.uk>:
> Subject: Re: [PATCH] remove shortlog from git-commit output
> 
> On Mon, 16 Apr 2007, Michael S. Tsirkin wrote:
> 
> >Make git-commit only display --summary since addition/deletion
> >are notable events that do not happen with every commit.
> >
> >Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
> >
> >---
> >
> >>>BTW, Junio, why does git-commit need to display the diffstat?
> >>>You just made the commit ...
> >>
> >>Don't ask me.  It was not my idea.
> >>
> >>We only had --summary per popular list request, and it made
> >>certain amount of sense since addition/deletion are notable
> >>events that do not happen with _every_ commit.
> >
> >So how about this?
> >
> 
> Personally I quite like the shortstat ... and certainly is/will be more 
> useful to me than having the commit subject - despite normally having more 
> terminals lying around than is good for my sanity.
> 
> Can't we keep it? It's not like it takes up much space ...

What's it used for? Would it make more sense to have it show
up in the commit log editor, with the list of files being checked in?

-- 
MST
