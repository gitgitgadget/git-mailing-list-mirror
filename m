From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Wiki after engine update lost macros; special pages like RecentChanges do not work
Date: Sat, 12 May 2007 17:40:02 +0200
Message-ID: <200705121740.02982.jnareb@gmail.com>
References: <200705110304.23115.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun May 13 01:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn1QJ-0007N7-Ce
	for gcvg-git@gmane.org; Sun, 13 May 2007 01:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306AbXELXyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755877AbXELXyq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 19:54:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:44105 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbXELXyp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 19:54:45 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1071307uga
        for <git@vger.kernel.org>; Sat, 12 May 2007 16:54:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=THSFZ556ko6Ex/gI0a7xhlMpdP8rlrAOwO7cEI0WecUtMr2JZQv5alAD2rRV3B8sB+uLPvHZr3kUnCRPjK43LOXZSr7fd5GFad9M/sHzYiK4foF9tPlw77bekOTWhwQcB3WfsAICixLxL/7YbSAtSGg4V9oFzNYgDK1h/95e1t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OUg5RTjqDSv+nTS/EdgRLQQWd/9LYv3joEhOfuMZS5+Vck7YTcCHfQq2J1/wgChkx0yWuY2L52T3CmEBhozj6gu1L8RNzUN34UspQApZWV+uFgbHzbBZFtwadD1meywoT8WX2gwzGdvCJMD6tK9bK4qkkImAVEx9yOqAmEbdpiE=
Received: by 10.67.44.4 with SMTP id w4mr2634609ugj.1179014084523;
        Sat, 12 May 2007 16:54:44 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id u6sm10568381uge.2007.05.12.16.54.42;
        Sat, 12 May 2007 16:54:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200705110304.23115.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47112>

Jakub Narebski wrote:

> After wiki engine (MoinMoin) update at http://git.or.cz/gitwiki MoinMoin 
> macros like {{RecentChanges}} or {{SystemInfo}} (by the way, somehow 
> link to SystemInfo was lost on FrontPage). It looks like some 
> configuration related to using Wikipedia-like links syntax was lost:
> 
>  * You can make links using [[linkname]] (or even [[target|label]]
>  * If you ever need to use macros here, use a  {{macroname}}  syntax.
> 
> The second part is lost.

It looks like the problem is caused by stale caches of wiki pages.
I was able to make RecentChanges page work by choosing "Delete Cache"
action from combo box, but this solution doesn't work for example on
template page to create new pages.  So currently you cannot create
new pages on GitWiki.

Pasky, could you please remove / delete cache? TIA.
-- 
Jakub Narebski
Poland
