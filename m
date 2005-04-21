From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Docs update
Date: Thu, 21 Apr 2005 22:43:49 +0200
Message-ID: <20050421204348.GJ7443@pasky.ji.cz>
References: <42680FCC.6030901@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 22:39:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOiSX-00012U-Aq
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVDUUn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVDUUn7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:43:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51079 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261861AbVDUUnw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:43:52 -0400
Received: (qmail 20654 invoked by uid 2001); 21 Apr 2005 20:43:49 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <42680FCC.6030901@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 10:40:44PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> @@ -156,3 +317,23 @@
>  unpack-file
>  	unpack-file.c <sha1>
>  
> +
> +
> +git Environment Variables
> +GIT_CACHE_DIRECTORY
> +AUTHOR_NAME
> +AUTHOR_EMAIL
> +AUTHOR_DATE
> +RSYNC_FLAGS
> +GIT_INDEX_FILE
> +
> +
> +.git Repository Files
> +
> +.git/HEAD
> +This file always contains the last (head) commit object created for this branch of the repository.
> +(Usually symlinked to a file in .git/heads/)
> +
> +.git/heads/
> +This directory contains a file for each branch of the .git repository.
> +The name of the file is the friendly name of the branch (eg pasky)

Make a choice - either you are describing git or Cogito. The frmer has
no RSYNC_FLAGS and does not care about any heads or anything at all (you
might mention it as a recommended convention, though).


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
