From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and rebased
 remote branches
Date: Tue, 10 Feb 2009 22:22:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902102220550.10279@pacific.mpi-cbg.de>
References: <20090210202046.8EBEC3360AC@rincewind>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX04e-0002Di-TB
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342AbZBJVVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbZBJVVx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:21:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:58159 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755303AbZBJVVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:21:52 -0500
Received: (qmail invoked by alias); 10 Feb 2009 21:21:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 10 Feb 2009 22:21:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+boh4lJZOb/kVrn+/GedHRBaEYVFGy+2shydwPE1
	x1okd4FpW2qIXJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090210202046.8EBEC3360AC@rincewind>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109314>

Hi,

On Tue, 10 Feb 2009, Marc Branchaud wrote:

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 1f59960..be0316a 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -112,6 +112,8 @@ cat > test/expect << EOF
>    URL: $(pwd)/one
>    Remote branch merged with 'git pull' while on branch master
>      master
> +  Remote branch rebased with 'git pull' while on branch rebaser
> +    side

I'm not a native speaker... but "rebased with" sounds wrong, but so does 
"Remote branch rebased onto with 'git pull' while on branch rebaser"...

Otherwise, the patch looks good to me.

Thanks,
Dscho
