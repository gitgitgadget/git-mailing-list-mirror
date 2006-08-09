From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: setting up a git repo on apache
Date: Wed, 9 Aug 2006 18:35:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608091831320.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44DA060B.2050601@eircom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 18:36:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAr1z-0007qV-0k
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 18:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWHIQf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 12:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWHIQf3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 12:35:29 -0400
Received: from mail.gmx.de ([213.165.64.20]:9372 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751017AbWHIQf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 12:35:27 -0400
Received: (qmail invoked by alias); 09 Aug 2006 16:35:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 09 Aug 2006 18:35:26 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alan Larkin <nobrow@eircom.net>
In-Reply-To: <44DA060B.2050601@eircom.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25124>

Hi,

On Wed, 9 Aug 2006, Alan Larkin wrote:

> $ git push http://localhost:/webdav/git/myproj master
> Error: no DAV locking support on remote repo

What do the access_log and the error_log say about this?

It could also be that you have a "Require valid-user" somewhere in there 
by mistake.

Further, you might want to check if it works _with_ authentication (I 
never tried without, and I am not sure if it should be allowed to begin 
with).

There is a recent thread by Junio, Rutger and me, which might help you:

http://thread.gmane.org/gmane.comp.version-control.git/24816/focus=24861

Hth,
Dscho
