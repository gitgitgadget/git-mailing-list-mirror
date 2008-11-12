From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule: Avoid printing a spurious message.
Date: Wed, 12 Nov 2008 01:07:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811120107240.30769@pacific.mpi-cbg.de>
References: <87myg67ywz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03Ul-00018z-Ml
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYKLAUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbYKLAUz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:20:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:42498 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbYKLAUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:20:54 -0500
Received: (qmail invoked by alias); 12 Nov 2008 00:00:11 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 12 Nov 2008 01:00:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Pzyo1JmpP89+WIDGb3CBMvXIqyA1/B1wBj3rSw9
	9jzBJMQcZfNeEM
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87myg67ywz.fsf@wine.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100700>

Hi,

On Tue, 11 Nov 2008, Alexandre Julliard wrote:

> Fix 'git submodule update' to avoid printing a spurious "Maybe you want
> to use 'update --init'?" once for every uninitialized submodule it
> encounters.
> 
> Signed-off-by: Alexandre Julliard <julliard@winehq.org>
> ---
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index b63e5c3..220d94e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -323,7 +323,7 @@ cmd_update()
>  			# Only mention uninitialized submodules when its
>  			# path have been specified
>  			test "$#" != "0" &&
> -			say "Submodule path '$path' not initialized"
> +			say "Submodule path '$path' not initialized" &&
>  			say "Maybe you want to use 'update --init'?"
>  			continue
>  		fi

Ooops, thanks (& ACK).

Ciao,
Dscho
