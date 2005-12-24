From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] add xmktime() function that always accounts for the
 TZ env
Date: Sat, 24 Dec 2005 13:45:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512241344200.5891@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121339.GB3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 25 15:45:32 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqX7m-00079Q-WF
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 15:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVLYOpT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Dec 2005 09:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVLYOpT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 09:45:19 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8669 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750832AbVLYOpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 09:45:17 -0500
Received: by wrzx28.rz.uni-wuerzburg.de (Postfix, from userid 51)
	id EC68F13FE1C; Sun, 25 Dec 2005 15:45:16 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4E83D140B78; Sat, 24 Dec 2005 13:45:50 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224121339.GB3963@mail.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14048>

Hi,

On Sat, 24 Dec 2005, Eric Wong wrote:

> This function was added because mktime in dietlibc doesn't seem to
> account for the TZ env.  Also, xmktime() now shares the same
> always-summer bug TZ parsing elsewhere, so at least we can
> be wrong about summer consistently.

How about making this a compat function, which is used when the Makefile 
variable MKTIME_IGNORES_TZ is set?

Ciao,
Dscho
