From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 18:43:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261842580.29044@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0510260910290.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 18:47:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUoNh-00080N-0f
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 18:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVJZQni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVJZQni
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 12:43:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19103 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964807AbVJZQnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 12:43:37 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6715E13F27C; Wed, 26 Oct 2005 18:43:36 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4AE8C9CCAD; Wed, 26 Oct 2005 18:43:36 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0D7D79ABBC; Wed, 26 Oct 2005 18:43:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2AA2713F27C; Wed, 26 Oct 2005 18:43:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510260910290.10477@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10678>

Hi,

On Wed, 26 Oct 2005, Linus Torvalds wrote:

> On Wed, 26 Oct 2005, Randal L. Schwartz wrote:
> > 
> > got it... a bit messy, but here it is:
> > 
> > Subject: [PATCH] fix for openbsd
> 
> I think we might as well do it for any error, and skip the test of the 
> actual errno entirely.

Hah! I beat you at your own game! (I already sent out a totally untested 
patch ;-)

Ciao,
Dscho
