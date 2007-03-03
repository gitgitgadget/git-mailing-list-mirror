From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 3 Mar 2007 22:10:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703032210010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45E9A641.8020002@lightspeed.com>
 <Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vabyu9hcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNbUy-00023y-DX
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 22:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbXCCVKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 16:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbXCCVKd
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 16:10:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:34571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932451AbXCCVKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 16:10:33 -0500
Received: (qmail invoked by alias); 03 Mar 2007 21:10:31 -0000
X-Provags-ID: V01U2FsdGVkX1+xL+xgErKxz4ZX6Mf9dnDHOEQ2NIoKBWJY4esFAL
	7wNcH/J9nWXZXT
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vabyu9hcp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41328>

Hi,

On Sat, 3 Mar 2007, Junio C Hamano wrote:

> -	finish "$new_head" "Fast forward"
> +	finish "$new_head" "Fast forward" || exit

Doesn't "exit" default to "exit 0"?

Ciao,
Dscho
