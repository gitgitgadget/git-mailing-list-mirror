From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Build configuration to skip ctime for modification
 test
Date: Wed, 23 Jul 2008 17:59:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231757550.8986@racer>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local>
 <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:00:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhh6-0001jy-BX
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbYGWQ7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbYGWQ7D
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:59:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:48615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753248AbYGWQ7B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:59:01 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:58:59 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp064) with SMTP; 23 Jul 2008 18:58:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181p6ZxjlU1WzvuoySkL8oeZ4qa7ymYphxkWBw6XQ
	AZ0nTdzhYhjELH
X-X-Sender: gene099@racer
In-Reply-To: <20080723164614.GB5283@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89712>

Hi,

On Wed, 23 Jul 2008, Alex Riesen wrote:

> Because exactly the file mode (the executable bit) is the reason for
> checking ctime.

But ctime is broken on Windows.  Because ctime is supposed to change 
whenever the _inode_ changes.

You have to admit that saying "I ignore the ctime because the executable 
bit is broken" must leave the reader puzzled.

Ciao,
Dscho
