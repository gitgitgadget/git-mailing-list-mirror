From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Fix few 'use of undefined value' warnings
Date: Thu, 17 May 2007 03:32:09 +0200
Message-ID: <20070517013209.GJ4489@pasky.or.cz>
References: <20070427164352.396.54191.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 03:32:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoUqo-0004Py-B2
	for gcvg-git@gmane.org; Thu, 17 May 2007 03:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbXEQBcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 21:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbXEQBcM
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 21:32:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56650 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809AbXEQBcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 21:32:11 -0400
Received: (qmail 22068 invoked by uid 2001); 17 May 2007 03:32:09 +0200
Content-Disposition: inline
In-Reply-To: <20070427164352.396.54191.stgit@rover>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47477>

On Fri, Apr 27, 2007 at 06:43:53PM CEST, Petr Baudis wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b67ce41..b51103e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1057,6 +1058,7 @@ sub git_get_project_description {
>  	open my $fd, "$projectroot/$path/description" or return undef;
>  	my $descr = <$fd>;
>  	close $fd;
> +	$descr or return undef;
>  	chomp $descr;
>  	return $descr;
>  }

It looks like this hunk has been skipped...?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
