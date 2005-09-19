From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 18:32:19 +0200
Message-ID: <20050919163219.GA8862@puritan.pnetwork>
References: <20050919134838.GC2903@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 19 18:34:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOZ8-0001sQ-Pz
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVISQcY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVISQcY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:32:24 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:58033 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932429AbVISQcX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 12:32:23 -0400
Received: from puritan.petwork ([213.112.43.228] [213.112.43.228])
          by mxfep02.bredband.com with ESMTP
          id <20050919163218.HAFA3281.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Mon, 19 Sep 2005 18:32:18 +0200
Received: by puritan.petwork (Postfix, from userid 1000)
	id 354A5ADFEA; Mon, 19 Sep 2005 18:32:19 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050919134838.GC2903@pasky.or.cz>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8883>

Petr Baudis wrote:

>   So my proposal (patch will follow soon) is to cut everything after the
> first , or ; from the GECOS field. These are the usual delimiters used
> in the GECOS field, and hopefully this will prevent polluting the
> realname fields of commit headers with crap and surprising the users.
> In the (I think rather rare) situation of the "Baudis, Petr"-like GECOS
> fields, this will just result in only the surname being in the realname
> field, which seems to be much less harmful and comparably less evil to
> me. 

If we stop using GECOS, then can we please start using $EMAIL (or
perhaps use it regardless of whether we use GECOS or not)?  A lot of
applications seem to look for $EMAIL and I think that it's universal
enough for git to use it as well.  To me it seems that both
GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and
GIT_COMMITTER_EMAIL can use it, as I set $EMAIL as

EMAIL="Nikolai Weibull <something@something.something>"

Perhaps I should provide a patch instead of just putting out requests?,
        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
