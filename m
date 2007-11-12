From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 13:57:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121355380.4362@racer.site>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZnZ-0006rM-2Y
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758615AbXKLN5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758627AbXKLN5l
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:57:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:52468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758355AbXKLN5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:57:41 -0500
Received: (qmail invoked by alias); 12 Nov 2007 13:57:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 12 Nov 2007 14:57:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19T87pyDghTu1zY9iiCKi4akccLAelaL6KmVYrNrz
	0d6caVqH0XqZzn
X-X-Sender: gene099@racer.site
In-Reply-To: <20071112131927.GA1701@c3sl.ufpr.br>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64621>

Hi,

On Mon, 12 Nov 2007, Bruno Cesar Ribas wrote:

> A bare repository is the way to publish your changes to the public. 
> git-daemon and http-clones use a bare repository that only contains 
> adminsitrative files.

More to the point, a bare repository is one which does not have a working 
directory attached.

As such, many commands do not make any sense at all, such as "git add" 
(_what_ do you want to add?  There is not even a working directory to work 
with!), or "git commit".

Ciao,
Dscho
