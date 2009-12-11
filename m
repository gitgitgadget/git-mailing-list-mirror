From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/6] Gitweb caching changes v2
Date: Fri, 11 Dec 2009 07:51:20 -0800 (PST)
Message-ID: <m3hbrxcxuu.fsf@localhost.localdomain>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 16:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ7mC-0003At-3M
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 16:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbZLKPvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 10:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbZLKPvQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 10:51:16 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:61425 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbZLKPvP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 10:51:15 -0500
Received: by gv-out-0910.google.com with SMTP id r4so16326gve.37
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=L6pT1oncWS7KhZ6l9Z03aXZCNxTBFvQg3DzpM6KfCkA=;
        b=xtVPHuemm67y33NfhKlnER1dAY3p2ozJPTKsf+lvrjuoBdYsAF0UzPk4CjcR7U7c4s
         WK9kth0ScutVPEQFGbhzedzGDZEjt2m3t/eoqIkhs61TZXRte/PPIhVaKkb3UIi/z3D2
         fy+X8JCJUcxZd8ywk7/PfTyCw6DTGlTrtPnkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ZphiOSKOwtY0fWRbxt/QZ+mqAD9smGtdQxHYvjyYCKG2eAM3ZEVk2TuVZdJrfV7Oaq
         IkRm2QmiQkMe9z9zeOeaoOJ2TUqqYsNj7ATnwOxZJ0AqHEEG7GjoCKrlWXDMHe+PTwgF
         u3LuBT4Oa+lymjmQgK3hnrCbVBUcOJ8QMuikg=
Received: by 10.102.122.15 with SMTP id u15mr621505muc.23.1260546680933;
        Fri, 11 Dec 2009 07:51:20 -0800 (PST)
Received: from localhost.localdomain (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id u9sm5174743muf.7.2009.12.11.07.51.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 07:51:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBBFqEgP006179;
	Fri, 11 Dec 2009 16:52:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBBFprNx006174;
	Fri, 11 Dec 2009 16:51:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135093>

"John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

> Evening everyone,
> 
> This is the latest incarnation of gitweb w/ caching.  This is
> finally at the point where it should probably start either being
> considered for inclusion or mainline, or I need to accept that this
> will never get in and more perminantely fork (as is the case with
> Fedora where this is going in as gitweb-caching as a parrallel rpm
> package).
> 
> That said this brings the base up to mainline (again), it updates a
> number of elements in the caching engine, and this is a much cleaner
> break-out of the tree vs. what I am currently developing against.
> 
> New things known to work:
>     - Better breakout
>     - You can actually disable the cache now
> 
> - John 'Warthog9' Hawley 
> 
> John 'Warthog9' Hawley (6):
>   GITWEB - Load Checking
>   GITWEB - Missmatching git w/ gitweb
>   GITWEB - Add git:// link to summary pages
>   GITWEB - Makefile changes
>   GITWEB - File based caching layer

This patch didn't made it to git mailing list.  I suspect that you ran
afoul vger anti-SPAM filter.

Does this "File based caching layer" have anything common with GSoC
2008 project, available at git://repo.or.cz/git/gitweb-caching.git ?

>   GITWEB - Separate defaults from main file

-- 
Jakub Narebski
Poland
ShadeHawk on #git
