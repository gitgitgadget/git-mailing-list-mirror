From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Fix few 'use of undefined value' warnings
Date: Thu, 17 May 2007 13:25:11 +0200
Message-ID: <20070517112510.GM4489@pasky.or.cz>
References: <20070427164352.396.54191.stgit@rover> <20070517013209.GJ4489@pasky.or.cz> <7vabw4ccy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 13:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoe6s-0006wn-GJ
	for gcvg-git@gmane.org; Thu, 17 May 2007 13:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbXEQLZO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 07:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755205AbXEQLZO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 07:25:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34053 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140AbXEQLZN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 07:25:13 -0400
Received: (qmail 30179 invoked by uid 2001); 17 May 2007 13:25:11 +0200
Content-Disposition: inline
In-Reply-To: <7vabw4ccy5.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47511>

On Thu, May 17, 2007 at 06:05:06AM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > On Fri, Apr 27, 2007 at 06:43:53PM CEST, Petr Baudis wrote:
> >> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> >> index b67ce41..b51103e 100755
> >> --- a/gitweb/gitweb.perl
> >> +++ b/gitweb/gitweb.perl
> >> @@ -1057,6 +1058,7 @@ sub git_get_project_description {
> >>  	open my $fd, "$projectroot/$path/description" or return undef;
> >>  	my $descr = <$fd>;
> >>  	close $fd;
> >> +	$descr or return undef;
> >>  	chomp $descr;
> >>  	return $descr;
> >>  }
> >
> > It looks like this hunk has been skipped...?
> 
> It is more like the whole messages was missed, and then 198a2a8a
> and others tried to do the same thing but missed this one.

Oh, aha - I thought that it was applied when you replied "thanks"...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
