From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull question
Date: Mon, 16 Oct 2006 11:11:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610161109300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <012c01c6f0be$7d329fc0$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 11:11:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZOVE-0003qn-0E
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 11:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWJPJLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWJPJLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 05:11:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:21451 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161262AbWJPJLP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 05:11:15 -0400
Received: (qmail invoked by alias); 16 Oct 2006 09:11:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 16 Oct 2006 11:11:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <012c01c6f0be$7d329fc0$1267a8c0@Jocke>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28954>

Hi,

On Mon, 16 Oct 2006, Joakim Tjernlund wrote:

> Why isn't
>   git checkout -b myb otherb
>   git pull . thirdb
> 
> the same as
>   git checkout -b myb otherb
>   git pull . thirdb:myb

You have to understand that "thirdb:myb" means "fetch the branch thirdb 
and _store_ it as myb (if it fast forwards)".

So, it makes no sense at all to use the "remote:local" syntax with pull.

Hth,
Dscho
