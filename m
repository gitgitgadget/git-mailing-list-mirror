From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Update cogito.spec.in
Date: Fri, 16 Sep 2005 13:06:05 +0200
Message-ID: <20050916110605.GC25169@pasky.or.cz>
References: <20050916064720.GI8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 13:08:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGE2m-00035Z-6U
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 13:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbVIPLGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 07:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVIPLGI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 07:06:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32409 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932642AbVIPLGI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 07:06:08 -0400
Received: (qmail 27663 invoked by uid 2001); 16 Sep 2005 13:06:05 +0200
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050916064720.GI8041@shell0.pdx.osdl.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8678>

Dear diary, on Fri, Sep 16, 2005 at 08:47:24AM CEST, I got a letter
where Chris Wright <chrisw@osdl.org> told me that...
> e0ca49e6c375a68b3e4b3edfff752fef2cf585f6
> diff --git a/cogito.spec.in b/cogito.spec.in
> --- a/cogito.spec.in
> +++ b/cogito.spec.in
> @@ -1,15 +1,14 @@
>  Name: 		cogito
>  Version: 	@@VERSION@@
>  Release: 	1
> -Vendor: 	Petr Baudis <pasky@suse.cz>
>  Summary:  	The Cogito Version Control System
>  License: 	GPL
>  Group: 		Development/Tools
>  URL: 		http://kernel.org/pub/software/scm/cogito/
>  Source: 	http://kernel.org/pub/software/scm/cogito/%{name}-%{version}.tar.gz
> -BuildRoot:	%{_tmppath}/%{name}-%{version}-root
> -Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5, git-core >= 0.99.3
> -BuildArchitectures:	noarch
> +BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
> +Requires: 	git-core >= 0.99.3
> +BuildArch:	noarch

Why did you remove all the stuff from Requires? They actually are ending
up adding even trivial stuff like less to it in GIT.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
