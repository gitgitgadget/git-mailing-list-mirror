From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Missing MIME-headers in git-email-tool ..
Date: Tue, 30 Oct 2007 10:31:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301028360.4362@racer.site>
References: <20071030095338.GZ6372@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImoOg-00048z-4H
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbXJ3KcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbXJ3KcW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:32:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42641 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752096AbXJ3KcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 06:32:21 -0400
Received: (qmail invoked by alias); 30 Oct 2007 10:32:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 30 Oct 2007 11:32:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JTAAp7meJIDM6GuVXrjIr2O+neVm5p3WA4451GZ
	g+JrRYYdrRoz+t
X-X-Sender: gene099@racer.site
In-Reply-To: <20071030095338.GZ6372@mea-ext.zmailer.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 30 Oct 2007, Matti Aarnio wrote:

> The  git-send-email  does send posts without any sort of MIME labeling:
> 
>   From: / To: removed
> 
>   Subject: [PATCH 0/2] Blackfin I2C/TWI driver updates
>   Date: Tue, 30 Oct 2007 17:33:15 +0800
>   Message-Id: <1193736797-9005-1-git-send-email-bryan.wu@analog.com>
>   X-Mailer: git-send-email 1.5.3.4
>   Precedence: bulk
> 
> 
> which per MIME rules means that the message in question is equivalent
> to one with header labels:
> 
>   MIME-Version: 1.0
>   Content-Type: text/plain; charset=US-ASCII
>   Content-Transfer-Encoding: 7bit

AFAICT MIME headers are only added when needed.  (But that might only 
apply to format-patch; however, if you signed off with your name, all 
should be well.)

> Now if the  git-send-email would add following three lines in all
> outgoing email headers, things would be 99% correct for a long time..
> 
>   MIME-Version: 1.0
>   Content-Type: text/plain; charset=ISO-8859-15
>   Content-Transfer-Encoding: 8BIT

No.

Not at all.

ISO-8859-15 is just as wrong as ASCII.  You just forget about the majority 
of the population on this earth. That is just as arrogant and snobbish as 
the people who thought that ASCII would be good enough for everyone.

Ciao,
Dscho
