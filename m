From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] connect: display connection progress
Date: Mon, 7 May 2007 07:20:39 +0300
Message-ID: <20070507042039.GD30339@mellanox.co.il>
References: <20070506195230.GA30339@mellanox.co.il>
	<7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 06:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkuiX-0002Nm-Qp
	for gcvg-git@gmane.org; Mon, 07 May 2007 06:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbXEGEUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 00:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbXEGEUj
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 00:20:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:17268 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbXEGEUi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 00:20:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1045705uga
        for <git@vger.kernel.org>; Sun, 06 May 2007 21:20:37 -0700 (PDT)
Received: by 10.67.101.10 with SMTP id d10mr4765849ugm.1178511637174;
        Sun, 06 May 2007 21:20:37 -0700 (PDT)
Received: from ?127.0.0.1? ( [85.250.212.226])
        by mx.google.com with ESMTP id e23sm10157305ugd.2007.05.06.21.20.35;
        Sun, 06 May 2007 21:20:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46406>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] connect: display connection progress
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Make git notify the user about host resolution/connection attempts.  This
> > is useful both as a progress indicator on slow links, and helps reassure the
> > user there are no DNS/firewall problems.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
> >
> > ---
> >
> > I find the following useful.
> > This currently only covers native git protocol. I expect it would
> > be easy to extend this to other protocols, if there's interest.
> > Opinions?
> 
> I think giving this kind of feedback makes a lot of sense, from
> both the "assurance" point of view and also debuggability.
> 
> But please do this only under verbose, or squelch it if "quiet"
> is asked.

Squelching it if quiet is set makes more sense to me.
I'll do that.

-- 
MST
