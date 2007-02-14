From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 23:39:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702142338450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx>
 <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 23:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHSma-0006g2-Qg
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 23:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXBNWjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 17:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbXBNWjW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 17:39:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751250AbXBNWjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 17:39:21 -0500
Received: (qmail invoked by alias); 14 Feb 2007 22:39:20 -0000
X-Provags-ID: V01U2FsdGVkX19EzEgGV05EgGcYhWtEWfv5bc5I/YimbCUFjlnnbw
	pzrg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39768>

Hi,

On Wed, 14 Feb 2007, Johannes Schindelin wrote:

> diff --git a/builtin-config.c b/builtin-config.c
> index 0f9051d..a42d251 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -147,6 +152,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  			} else {
>  				die("$HOME not set");
>  			}
> +		else if (!strcmp(argv[1], "--system-wide")) {

Ooops. There is a "}" missing before "else".

Sorry,
Dscho
