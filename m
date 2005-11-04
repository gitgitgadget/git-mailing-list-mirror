From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem cloning the Linux history tree
Date: Fri, 04 Nov 2005 14:17:33 +0100
Message-ID: <20051104131733.7012A353C33@atlas.denx.de>
References: <7vacgkzqau.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 14:19:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY1Ru-0007eK-HB
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 14:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVKDNRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 08:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVKDNRj
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 08:17:39 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:29079 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1751415AbVKDNRj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 08:17:39 -0500
Received: from mail.m-online.net (svr20.m-online.net [192.168.3.148])
	by mail-out.m-online.net (Postfix) with ESMTP id 62FF2702FF;
	Fri,  4 Nov 2005 14:16:12 +0100 (CET)
X-Auth-Info: hj67ix1Ivww8kKYOtmHEZUG8DQykGJKcgyGdjGt1NyQ=
X-Auth-Info: hj67ix1Ivww8kKYOtmHEZUG8DQykGJKcgyGdjGt1NyQ=
Received: from mail.denx.de (p549660AA.dip.t-dialin.net [84.150.96.170])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id DA3F5123AB5;
	Fri,  4 Nov 2005 14:17:33 +0100 (CET)
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by mail.denx.de (Postfix) with ESMTP id 810A86D00AC;
	Fri,  4 Nov 2005 14:17:33 +0100 (MET)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 7012A353C33;
	Fri,  4 Nov 2005 14:17:33 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: Your message of "Fri, 04 Nov 2005 01:59:53 PST."
             <7vacgkzqau.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11129>

In message <7vacgkzqau.fsf@assigned-by-dhcp.cox.net> you wrote:
>
> > Missing object of tag v2.6.14-rc3... unable to retrieve
> 
> I do not have a clue on this one; I am assuming that it is
> coming from cg-fetch.
> 


> Quick question.  Is the source repository fully packed (i.e. git
> repack followed by git prune)?  If that is the case there is

Yes, it is. I decided to run repack + update-server-info hoping  that
would help to cleanup the state.

> nothing to worry about.  The latest git prunes empty
> $GIT_OBJECT_DIRECTORY/??/ directories and recreates them on
> demand.

I see. Thanks.

> > error: Could not interpret tags/DENX-2005-10-02-18:30 as something to pull
> 
> This one I can answer.  It is the colon in your tag name.
> Please rename it to make git-check-ref-format(1) happy, run
> git-update-server-info(1) and try again.

Understood. Thanks.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
No one can guarantee the actions of another.
	-- Spock, "Day of the Dove", stardate unknown
