From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: fix two warnings
Date: Wed, 26 Jul 2006 10:48:41 -0700 (PDT)
Message-ID: <20060726174841.90834.qmail@web31809.mail.mud.yahoo.com>
References: <Pine.LNX.4.63.0607261658130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jul 26 19:48:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5nV0-0007hb-KN
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 19:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWGZRsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 13:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWGZRsn
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 13:48:43 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:36281 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030350AbWGZRsm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 13:48:42 -0400
Received: (qmail 90836 invoked by uid 60001); 26 Jul 2006 17:48:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DXIZYFuAYJWKQUqrguufltvUrSJoCSxPvUeM3sXtJ73ihz90bRovC5L3lkpL/rPx5h80sz32KdQ1UEiwsS4S/pw6Hni1O6C9FaV5373SKk6RBryMsCey5oUZwvc/e8AKDFaB0zqzEbMQTSI3fYliH0KWiuWk9SgZgBpvdOjv4Vk=  ;
Received: from [71.80.231.253] by web31809.mail.mud.yahoo.com via HTTP; Wed, 26 Jul 2006 10:48:41 PDT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0607261658130.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24228>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> These warnings cluttered up my log.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  gitweb/gitweb.cgi |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
> index e226ac2..e5fca63 100755
> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.cgi
> @@ -795,7 +795,7 @@ sub git_read_projects {
>  	if (-d $projects_list) {
>  		# search in directory
>  		my $dir = $projects_list;
> -		opendir my $dh, $dir or return undef;
> +		opendir my ($dh), $dir or return undef;
>  		while (my $dir = readdir($dh)) {
>  			if (-e "$projectroot/$dir/HEAD") {
>  				my $pr = {
> @@ -810,7 +810,7 @@ sub git_read_projects {
>  		# 'git%2Fgit.git Linus+Torvalds'
>  		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
>  		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
> -		open my $fd , $projects_list or return undef;
> +		open my ($fd), $projects_list or return undef;
>  		while (my $line = <$fd>) {
>  			chomp $line;
>  			my ($path, $owner) = split ' ', $line;
> -- 
> 1.4.2.rc2.g6a4e

Can you please give more details of the warnings, cut-and-paste
would be nice, the problem as you perceive it, and your solution to it?

Thanks,
   Luben
