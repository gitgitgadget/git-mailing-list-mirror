From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fetch-pack: remove --keep-auto and make it the default.
Date: Thu, 25 Jan 2007 09:23:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701231101040.3011@xanadu.home> <7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 09:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ztx-0001Qm-Sg
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 09:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965704AbXAYIXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 03:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965705AbXAYIXv
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 03:23:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:34234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965704AbXAYIXu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 03:23:50 -0500
Received: (qmail invoked by alias); 25 Jan 2007 08:23:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 25 Jan 2007 09:23:49 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37711>

Hi,

On Wed, 24 Jan 2007, Junio C Hamano wrote:

>   Ok, how about this, on top of the previous ones?

Thanks!

> @@ -653,6 +663,8 @@ int main(int argc, char **argv)
>  	struct stat st;
>  
>  	setup_git_directory();
> +	setup_ident();
> +	git_config(fetch_pack_config);

Why do you need setup_ident()?

Ciao,
Dscho
