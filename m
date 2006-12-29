From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Allow non-fast-forward of remote tracking branches
 in default clone
Date: Fri, 29 Dec 2006 17:39:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612291737490.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1167251519.2247.10.camel@dv> <7vfyb159dn.fsf@assigned-by-dhcp.cox.net>
 <1167341346.12660.17.camel@dv> <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net>
 <7vk60btucu.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 17:39:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0Klk-00012N-9S
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 17:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025AbWL2Qjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 11:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbWL2Qjb
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 11:39:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:52514 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754985AbWL2Qja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 11:39:30 -0500
Received: (qmail invoked by alias); 29 Dec 2006 16:39:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 29 Dec 2006 17:39:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk60btucu.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35594>

Hi,

On Thu, 28 Dec 2006, Junio C Hamano wrote:

>  		git-repo-config remote."$origin".fetch \
> -			"refs/heads/*:$remote_top/*" '^$' &&
> +			"+refs/heads/*:$remote_top/*" '^$' &&

Minor nit: these days, it is cleaner (and clearer) to use "git-repo-config 
--add" instead of using the "^$" construct yourself. However, I don't 
think this patch has to be changed.

Ciao,
Dscho
