From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document that using -M without other diff options is
 not a good idea
Date: Thu, 1 Nov 2007 15:09:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711011508490.4362@racer.site>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 16:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inbgi-0008Bt-9j
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 16:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbXKAPKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 11:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbXKAPKN
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 11:10:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:48990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751389AbXKAPKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 11:10:12 -0400
Received: (qmail invoked by alias); 01 Nov 2007 15:10:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 01 Nov 2007 16:10:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/A4AUoJLnApFBEf46uK8S7/yhkyr8Tebljs6ulKN
	40Iwk2fpe83LYf
X-X-Sender: gene099@racer.site
In-Reply-To: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62972>

Hi,

On Thu, 1 Nov 2007, Miklos Vajna wrote:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> I just noticed that I used 'git log -M' in some scripts which is obviously bad.
> People should not use that option without other diff options.
> 
>  Documentation/diff-options.txt |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index b1f528a..ed827f8 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -92,7 +92,9 @@
>  	Break complete rewrite changes into pairs of delete and create.
>  
>  -M::
> -	Detect renames.
> +	Detect renames. It's no good using this option if you don't use diff
> +	options like `--name-status`, `-p` or `--stat` as it will just slow
> +	down the revision walker.

As I remarked on IRC earlier, this will also show up in the man page of 
git-diff, too.  Rather funny, no?

Ciao,
Dscho
