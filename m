From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] autoconf: Add test for sys/select.h header file
Date: Fri, 25 Jan 2008 12:30:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801251229250.5731@racer.site>
References: <20080124183446.GJ30676@schiele.dyndns.org> <1201259981-7115-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Robert Schiele <rschiele@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 13:31:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JINiD-000154-Gs
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYAYMak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbYAYMaj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:30:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:39328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754063AbYAYMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 07:30:39 -0500
Received: (qmail invoked by alias); 25 Jan 2008 12:30:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 25 Jan 2008 13:30:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195sz8S8M55c75ub2Rfgp5TuftcIFABjoZIstaxME
	O3vJxyS3R+JNia
X-X-Sender: gene099@racer.site
In-Reply-To: <1201259981-7115-1-git-send-email-jnareb@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71702>

Hi,

On Fri, 25 Jan 2008, Jakub Narebski wrote:

> diff --git a/configure.ac b/configure.ac
> index af177fd..85d7ef5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -235,6 +235,12 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
>  ## Checks for header files.
>  AC_MSG_NOTICE([CHECKS for header files])
>  #
> +# Define NO_SYS_SELECT_H if you don't have sys/select.h.
> +AC_CHECK_HEADER([sys/select.h],
> +[NO_SYS_SELECT_H=],
> +[NO_SYS_SELECT_H=UnfortunatelyYes])
> +AC_SUBST(NO_SYS_SELECT_H)
> +#

Just because I am curious: would that not define "NO_SYS_SELECT_H" in both 
cases?  IOW would the "ifdef NO_SYS_SELECT_H" not be triggered all the 
time?

Thanks,
Dscho
