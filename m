From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] increase git el1T3nEss
Date: Wed, 29 Oct 2008 16:28:16 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810291623360.19665@iabervon.org>
References: <1225257832-29086-1-git-send-email-pasky@suse.cz> <20081029170631.GA12078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>, Sam Vilain <sam@vilain.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 21:29:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHfa-0006tp-4G
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbYJ2U2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbYJ2U2T
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:28:19 -0400
Received: from iabervon.org ([66.92.72.58]:34821 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159AbYJ2U2S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:28:18 -0400
Received: (qmail 20767 invoked by uid 1000); 29 Oct 2008 20:28:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Oct 2008 20:28:16 -0000
In-Reply-To: <20081029170631.GA12078@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99410>

On Wed, 29 Oct 2008, Jeff King wrote:

> The uptake of git by script kiddies has been disappointingly
> minimal. Let's make it more palatable by allowing mixed-case
> and l33t-speak commands.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This commit was made by "git c0mM1t".
> 
>  git.c |   27 ++++++++++++++++++++++++++-
>  1 files changed, 26 insertions(+), 1 deletions(-)
> 
> diff --git a/git.c b/git.c
> index 89feb0b..fd0ca67 100644
> --- a/git.c
> +++ b/git.c
> @@ -261,6 +261,31 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
>  	return 0;
>  }
>  
> +static char deelite(char in) {
> +	if (isalpha(in))
> +		return tolower(in);
> +	switch (in) {
> +	case '0': return 'o';
> +	case '1': return 'i';
> +	case '3': return 'e';
> +	case '5': return 's';
> +	case '7': return 'l';

Your mapping doesn't comply with ISO 1337.5p34k; 1 can be l (in addition 
to i), and 7 is T. Also, you're missing 4.

	-Daniel
*This .sig left intentionally blank*
