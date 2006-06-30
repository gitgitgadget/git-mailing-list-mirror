From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] consider previous pack undeltified object state only
 when reusing delta data
Date: Fri, 30 Jun 2006 11:45:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606301144450.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain>
 <7vwtazobkw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606292335190.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 11:46:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwFZY-0000v6-N0
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 11:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWF3Jp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 05:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWF3Jp5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 05:45:57 -0400
Received: from mail.gmx.net ([213.165.64.21]:52864 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932223AbWF3Jp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 05:45:57 -0400
Received: (qmail invoked by alias); 30 Jun 2006 09:45:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 30 Jun 2006 11:45:55 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606292335190.1213@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22972>

Hi,

On Thu, 29 Jun 2006, Nicolas Pitre wrote:

> Without this there would never be a chance to improve packing for 
> previously undeltified objects.

Earlier this year, I was quite surprised to learn that multiple repackings 
actually improved packing. Does that patch mean this feature is gone?

Ciao,
Dscho
