From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: What shall we do with the GECOS field again?
Date: Tue, 20 Sep 2005 12:31:15 +0200
Message-ID: <20050920103115.GA8979@puritan.pnetwork>
References: <20050919134838.GC2903@pasky.or.cz> <20050919163219.GA8862@puritan.pnetwork> <7v8xxsfqrw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 20 12:32:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHfPE-0005eJ-7G
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 12:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVITKbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 06:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVITKbR
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 06:31:17 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:65208 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S964965AbVITKbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 06:31:16 -0400
Received: from puritan.petwork ([213.112.43.228] [213.112.43.228])
          by mxfep02.bredband.com with ESMTP
          id <20050920103115.OALT3281.mxfep02.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Tue, 20 Sep 2005 12:31:15 +0200
Received: by puritan.petwork (Postfix, from userid 1000)
	id 45FCDADFEA; Tue, 20 Sep 2005 12:31:15 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8xxsfqrw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8989>

Junio C Hamano wrote:

> Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org> writes:

> > If we stop using GECOS, then can we please start using $EMAIL (or
> > perhaps use it regardless of whether we use GECOS or not)?  A lot of
> > applications seem to look for $EMAIL and I think that it's universal
> > enough for git to use it as well.  To me it seems that both
> > GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and
> > GIT_COMMITTER_EMAIL can use it,...

> I am not convinced $EMAIL is used as widely as you claim above (could
> you give a list of applications please?), but if it is that sounds
> like a sensible idea.

I was sadly mistaken.  It doesn't seem to be so well-used after all.
Here's a list of applications that use it:

* mutt (the only one that really counts)
* darcs (which also uses DARCS_EMAIL)
* various debian utilities (who cares)
* Vim's changelog package (which I have written, so that doesn't count)

Quite a sad list, so I suppose that there's really no point in it...,
        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
