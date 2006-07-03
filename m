From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 23:29:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607032327470.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060703171751.2ed33220.tihirvon@gmail.com>
 <Pine.LNX.4.63.0607031632290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060703182621.dbed5b5f.tihirvon@gmail.com>
 <Pine.LNX.4.63.0607031731550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060703191635.21ba0af3.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 23:29:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVzL-0007Ez-Qk
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWGCV3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWGCV3s
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:29:48 -0400
Received: from mail.gmx.de ([213.165.64.21]:41437 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750735AbWGCV3s (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:29:48 -0400
Received: (qmail invoked by alias); 03 Jul 2006 21:29:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 03 Jul 2006 23:29:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060703191635.21ba0af3.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23214>

Hi,

On Mon, 3 Jul 2006, Timo Hirvonen wrote:

> Seems that C89 requires free(NULL) to be a no-op but on some old systems 
> (SunOS) it may crash.  IMNSHO these systems were designed to crash valid 
> programs and torture developers.

At least it is not Malbolge. Or even VAX. (In that order.)

> There are probably many free(NULL) and realloc(NULL, ...) uses in the 
> git source code and are not worth fixing.

AFAIK realloc(NULL, ...) was fine even with K&R, whereas free(NULL) poses 
problems. Anyway, I do not _want_ to say that NULL should be free()d, 
because it just sounds wrong.

Ciao,
Dscho
