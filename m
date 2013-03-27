From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Support custom tunnel schemes instead of SSH
 only
Date: Wed, 27 Mar 2013 04:32:55 +0000
Message-ID: <20130327043255.GA3667@dcvr.yhbt.net>
References: <51521216.2050309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wieser <wieser.eric@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 05:33:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKi3A-0002aI-5s
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 05:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754866Ab3C0Ec4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 00:32:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39176 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab3C0Ecz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 00:32:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E09A1F442;
	Wed, 27 Mar 2013 04:32:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <51521216.2050309@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219239>

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> This originates from an msysgit pull request, see:
> 
> https://github.com/msysgit/git/pull/58
> 
> Signed-off-by: Eric Wieser <wieser.eric@gmail.com>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

Thanks, looks obviously correct.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 049c97b..6a212eb 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -295,7 +295,7 @@ sub gs_do_switch {
>  	my $full_url = add_path_to_url( $self->url, $path );
>  	my ($ra, $reparented);
>  
> -	if ($old_url =~ m#^svn(\+ssh)?://# ||
> +	if ($old_url =~ m#^svn(\+\w+)?://# ||
>  	    ($full_url =~ m#^https?://# &&
>  	     canonicalize_url($full_url) ne $full_url)) {
>  		$_[0] = undef;
> -- 

Junio:

The following changes since commit 2bba2f0e6542d541e9f27653d8c9d5fc8d0e679c:

  More topics from the second batch for 1.8.3 (2013-03-26 13:16:11 -0700)

are available in the git repository at:

  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to 3747c015704399dea1aa7ae6569a507e5727e20b:

  git-svn: Support custom tunnel schemes instead of SSH only (2013-03-27 04:28:04 +0000)

----------------------------------------------------------------
Sebastian Schuberth (1):
      git-svn: Support custom tunnel schemes instead of SSH only

 perl/Git/SVN/Ra.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
