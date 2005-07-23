From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: Last mile to 1.0?
Date: Sat, 23 Jul 2005 10:47:16 -0400
Message-ID: <42E25874.2090201@qualitycode.com>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net> <20050723085031.GD3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 16:48:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwLIJ-0000az-9b
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 16:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVGWOrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 10:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVGWOry
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 10:47:54 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:48906 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261748AbVGWOry
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 10:47:54 -0400
Received: from [192.168.15.100] (186-49.35-65.tampabay.res.rr.com [65.35.49.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 360983C09;
	Sat, 23 Jul 2005 14:47:47 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050723085031.GD3255@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson wrote:
> Git falls into the category of distributed source code management tools,
> similar to Arch or Darcs (or, in the commercial world, BitKeeper).  This
> means that every working directory is a full-fledged repository with
> full revision tracking capabilities.

That's not actually what "distributed" means. There are several 
distributed SCM tools[1] that store repo information outside the actual 
working directory.

Perhaps that last sentence could be something like "This means that each 
developer has a local full-fledged repository with full revision 
tracking capabilities, not dependent on network access to a central 
server." I'm sure there are better wordings, but I hate to point out an 
problem without offering at least one possible improvement.

Kevin

[1] I believe that ArX, monotone, codeville, and svk all fall into this 
category. Possibly even Arch itself, although I haven't researched that.
