From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/4] add xmktime() function that always accounts for the TZ env
Date: Sat, 24 Dec 2005 11:52:47 -0800
Message-ID: <20051224195247.GF3963@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121339.GB3963@mail.yhbt.net> <7vy82aqp5r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 20:52:57 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqFRk-0006m3-G1
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 20:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVLXTws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 14:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVLXTws
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 14:52:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42883 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932343AbVLXTwr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 14:52:47 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id A2BC47DC005; Sat, 24 Dec 2005 11:52:47 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy82aqp5r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14033>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This function was added because mktime in dietlibc doesn't seem to
> > account for the TZ env.  Also, xmktime() now shares the same
> > always-summer bug TZ parsing elsewhere,
> 
> Where elsewhere?
 
match_alpha() in date.c

-- 
Eric Wong
