From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] receive-pack: allow deletion of corrupt refs
Date: Thu, 29 Nov 2007 01:04:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711290103400.27959@racer.site>
References: <Pine.LNX.4.64.0711290101420.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 29 02:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXpp-0000ih-16
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759865AbXK2BEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759679AbXK2BEh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:04:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:58748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758949AbXK2BEg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:04:36 -0500
Received: (qmail invoked by alias); 29 Nov 2007 01:04:34 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp058) with SMTP; 29 Nov 2007 02:04:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oZTgX6YeoRXqE07L7/R7nUqkp7kwf+kHWUOIw8S
	poyy+ENuq8OXh+
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711290101420.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66485>

Hi,

On Thu, 29 Nov 2007, Johannes Schindelin wrote:

> Incidentally, some instances of "cd .." in the test cases were fixed, so 
> that subsequent test cases run in t/trash/ irrespective of the outcome 
> of the previous test cases.

Just to clarify: I was quite surprised that my test case did not succeed, 
and eventually found out that $(pwd) was t/trash/child/child after the 
last test.

Ciao,
Dscho
