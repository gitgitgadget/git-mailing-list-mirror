From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Basename matching during rename/copy detection
Date: Thu, 21 Jun 2007 14:22:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706211418430.4059@racer.site>
References: <20070621030622.GD8477@spearce.org> <200706211050.03519.andyparkins@gmail.com>
 <Pine.LNX.4.64.0706211252190.4059@racer.site> <200706211344.47560.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 15:22:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1McM-0003VN-Uh
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 15:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbXFUNWd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 09:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755424AbXFUNWd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 09:22:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:60127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755464AbXFUNWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 09:22:32 -0400
Received: (qmail invoked by alias); 21 Jun 2007 13:22:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 21 Jun 2007 15:22:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18b/4cZom0bRxid5T8SpjqAVWJZQpdL0LlW91SPAU
	iEXqcV/jVf7+Om
X-X-Sender: gene099@racer.site
In-Reply-To: <200706211344.47560.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50624>

Hi,

On Thu, 21 Jun 2007, Andy Parkins wrote:

> I open up gimp, draw a big red X and save it as new-button.png.  Then I 
> copy that file to open-button.png and save-button.png, knowing that at 
> some point in the future, someone will come and replace those red-X 
> images with something appropriate.

So you have a couple of identical files in your repo, which are 
placeholders. That is quite different from what I criticised of being 
stupid.

Well, I would not have checked in the files in your place, but only one:

	dumb-red-X.png

Then, my Makefile would have checked for the existence of, say, 
my-wonderful-ok-button.png, and if it does not exist yet, copy 
dumb-red-X.png to it.

Now, when somebody comes along, paining the prettiest ok button I ever 
saw, I copy that over the copy of dumb-red-X.png, and check it in.

It has the further bonus that I know exactly which buttons I have to find 
a suck^Wgifted artist for.

Ciao,
Dscho
