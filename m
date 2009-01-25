From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/10] git-shell: allow running git-cvsserver, not just
 cvs
Date: Sun, 25 Jan 2009 02:53:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901250252400.14855@racer>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sun Jan 25 02:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQuEq-0000ze-Ve
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 02:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbZAYBww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 20:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbZAYBww
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 20:52:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:45209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751689AbZAYBwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 20:52:51 -0500
Received: (qmail invoked by alias); 25 Jan 2009 01:52:49 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp034) with SMTP; 25 Jan 2009 02:52:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+R14QWRBeRpw+qfUzJeEDep1rFmfqH4Ho0+3U5Dr
	Nizx7FWK2xIiyB
X-X-Sender: gene099@racer
In-Reply-To: <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107033>

Hi,

On Sat, 24 Jan 2009, Matthew Ogilvie wrote:

> diff --git a/shell.c b/shell.c
> index e339369..6ed960f 100644
> --- a/shell.c
> +++ b/shell.c
> @@ -40,6 +40,7 @@ static struct commands {
>  } cmd_list[] = {
>  	{ "git-receive-pack", do_generic_cmd },
>  	{ "git-upload-pack", do_generic_cmd },
> +	{ "git-cvsserver", do_cvs_cmd },
>  	{ "cvs", do_cvs_cmd },
>  	{ NULL },
>  };

I do not see any value in this.

Ciao,
Dscho
