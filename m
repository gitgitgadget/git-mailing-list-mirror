From: David Lang <david.lang@digitalinsight.com>
Subject: Re: HTTP pushes
Date: Tue, 1 Nov 2005 16:46:23 -0800 (PST)
Message-ID: <Pine.LNX.4.62.0511011644500.1362@qynat.qvtvafvgr.pbz>
References: <20051101020248.GA3928@reactrix.com><Pine.LNX.4.63.0511012008310.11979@wbgn013.biozentrum.uni-wuerzburg.de> <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 01:48:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6mD-0006eW-UW
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVKBAqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKBAqu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:46:50 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:62953 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932098AbVKBAqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:46:50 -0500
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 1 Nov 2005 16:41:56 -0800
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <V77Y7ZGL>; Tue, 1 Nov 2005 19:46:52 -0500
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id V817MX9M; Tue, 1 Nov 2005 16:45:12 -0800
To: Junio C Hamano <junkio@cox.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
References: <20051101020248.GA3928@reactrix.com><Pine.LNX.4.63.0511012008310.11979@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10985>

On Tue, 1 Nov 2005, Junio C Hamano wrote:

>> I think this is useful. There are restrictive firewalls out there, which
>> only allow ports 80 and 443 to be connected to. Your work would fit in
>> right there.
>
> Another solution for this would be to allow connect.c to use a
> HTTP connect passthru proxy. CVS does this with an ugly but easy
> to understand notation:
>
>    ':pserver;proxy=firewall;proxyport=3128:user@host:/path/to/repo
>

please note that there are firewalls out there that don't let you use port 
443 (and the connect command) as a free pass to do anything you want. They 
verify that you at least do a valid SSL handshake immediatly after or they 
figure you are trying to bypass them and shut you down.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
