From: Ian Hilt <ian.hilt@gmx.com>
Subject: Re: [PATCH] t4030: Don't use echo -n
Date: Thu, 30 Oct 2008 19:52:15 -0400
Message-ID: <20081030235215.GB18221@sys-0.hiltweb.site>
References: <1225404776-51748-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 01:00:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvhQz-0006Vi-9i
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 01:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYJ3X7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 19:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYJ3X7A
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 19:59:00 -0400
Received: from mail.gmx.com ([74.208.5.67]:45582 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752946AbYJ3X67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 19:58:59 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2008 19:58:59 EDT
Received: (qmail invoked by alias); 30 Oct 2008 23:52:18 -0000
Received: from cpe-75-185-223-130.woh.res.rr.com (EHLO sys-0.hiltweb.site) [75.185.223.130]
  by mail.gmx.com (mp-us005) with SMTP; 30 Oct 2008 19:52:18 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+WyzVzuUWWVxjtYmO5psTG11aQaiD1CeRJDuVwjQ
	zm2yEZdfP9Fxwd
Content-Disposition: inline
In-Reply-To: <1225404776-51748-1-git-send-email-benji@silverinsanity.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99536>

On Thu, Oct 30, 2008 at 06:12:56PM -0400, Brian Gernhardt wrote:
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>

No commit message???

> ---
>  t/t4030-diff-textconv.sh |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> index 3945731..7ec244f 100755
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -96,16 +96,15 @@ cat >expect.typechange <<'EOF'
>  -1
>  diff --git a/file b/file
>  new file mode 120000
> -index ad8b3d2..67be421
> +index ad8b3d2..8e4020b
>  --- /dev/null
>  +++ b/file
>  @@ -0,0 +1 @@
>  +frotz
> -\ No newline at end of file
>  EOF
>  # make a symlink the hard way that works on symlink-challenged file systems
>  test_expect_success 'textconv does not act on symlinks' '
> -	echo -n frotz > file &&
> +	echo frotz > file &&
>  	git add file &&
>  	git ls-files -s | sed -e s/100644/120000/ |
>  		git update-index --index-info &&
> -- 
> 1.6.0.3.523.g304d0

This doesn't apply for me.  My tip is up-to-date, but it doesn't even have
this file it t/.

A little bewildered,

	Ian
