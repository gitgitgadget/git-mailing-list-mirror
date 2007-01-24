From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 12:03:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 12:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9fud-0003S5-VD
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 12:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXAXLD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 06:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbXAXLD2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 06:03:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:53633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751154AbXAXLD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 06:03:28 -0500
Received: (qmail invoked by alias); 24 Jan 2007 11:03:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 24 Jan 2007 12:03:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37624>

Hi,

On Wed, 24 Jan 2007, Francis Moreau wrote:

> I'm looking for a command that would give the same output than 'git
> describe' but on a remote server.
> 
> Is this possible ?

It would be possible; at a high cost (especially on the remote server): 
You definitely need _all_ commits between the commit you want to describe 
and the tag it eventually finds, and possibly all other commits, too.

So it boils down to fetching all commit objects. It is much cheaper, and 
more efficient, to just fetch the repo and do it locally.

Hth,
Dscho
