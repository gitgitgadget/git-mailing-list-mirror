From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Handle the errors from chdir in set_work_tree
Date: Thu, 2 Aug 2007 23:07:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708022306530.14781@racer.site>
References: <81b0412b0708020827p174515b7tc05fefde77f7d7c4@mail.gmail.com>
 <7v8x8ttx7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiph-0001xI-KE
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbXHBWHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbXHBWHp
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:07:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:34420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755436AbXHBWHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:07:44 -0400
Received: (qmail invoked by alias); 02 Aug 2007 22:07:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 03 Aug 2007 00:07:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196KDVGmkB68HzeI7NzN06IgMbvF0ryZz9PvfW+Ms
	3plpOGKrB1H5Wl
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x8ttx7y.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54625>

Hi,

On Thu, 2 Aug 2007, Junio C Hamano wrote:

> Fix work-tree related breakages
> 
> In set_work_tree(), variable rel needs to be reinitialized to
> NULL on every call (it should not be static).
> 
> Make sure the incoming dir variable is not too long before
> copying to the temporary buffer, and make sure chdir to the
> resulting directory succeeds.

ACK.

(Forget my patch, please)

Ciao,
Dscho
