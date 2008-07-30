From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git help broken
Date: Thu, 31 Jul 2008 01:42:15 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807310141060.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLKz-00075A-IV
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762201AbYG3XmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762191AbYG3XmT
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:42:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:51471 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761053AbYG3XmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:42:18 -0400
Received: (qmail invoked by alias); 30 Jul 2008 23:42:16 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp029) with SMTP; 31 Jul 2008 01:42:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PQetqFzLPpeP1qpexivKSrg5A2MZERx14sqH7Vv
	tahsftUB3iUz/Y
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90874>

Hi,

On Wed, 30 Jul 2008, Kevin Ballard wrote:

> `git help diff` no longer finds the git-diff manpage (as of tip of next 
> branch). I haven't tested, but I suspect 
> 940208a771066229bc6a486f6a058e332b71cfe4 is responsible.

Just to save everybody else and her dog the trouble: that commit's oneline 
is "builtin-help: make some internal functions available to other 
builtins".

And from the patch, it is pretty obvious that it does not come close to 
the "man" code path.

Ciao,
Dscho
