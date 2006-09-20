From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] describe: fall back to 'HEAD' if no appropriate tag
 exists
Date: Thu, 21 Sep 2006 00:53:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609210051570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609202324210.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xkef97b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 00:53:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQAwT-0007AT-Mz
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWITWxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 18:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWITWxS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:53:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:8926 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932433AbWITWxS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 18:53:18 -0400
Received: (qmail invoked by alias); 20 Sep 2006 22:53:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 21 Sep 2006 00:53:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xkef97b.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27424>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now, if no tag exists to say something like '<tag>-gfffffff', say
> > 'HEAD-gfffffff' instead of erroring out.
> 
> Another possibility is just to do
> 
>         puts(sha1_to_hex(cmit->object.sha1))
> 
> in this case.

Okay. Could we have the abbreviated sha1, at least?

Ciao,
Dscho
