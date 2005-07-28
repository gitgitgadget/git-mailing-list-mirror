From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 15:07:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <20050728120806.GA2391@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 15:08:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy86b-0000Q7-8R
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 15:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVG1NHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 09:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVG1NHG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 09:07:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:65425 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261232AbVG1NHC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 09:07:02 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C04DEE24A2; Thu, 28 Jul 2005 15:07:01 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A808A913AF; Thu, 28 Jul 2005 15:07:01 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9389391393; Thu, 28 Jul 2005 15:07:01 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3FE6EE24A2; Thu, 28 Jul 2005 15:07:01 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050728120806.GA2391@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Petr Baudis wrote:

> See above. I would much rather see more flexible git-send-pack. Junio,
> what about changing its [heads]* parameter e.g. to
> [remotehead[:localhead]]* ?

IMHO this opens the door for shooting in your own foot. Isn't it much too
easy to make a mistake with that syntax? What is so wrong with git-clone
not allowing you to name the HEAD differently?

Ciao,
Dscho
