From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: cannot pread pack file
Date: Wed, 09 Dec 2009 12:43:19 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912091237330.31174@xanadu.home>
References: <4B1FCF81.2010807@harris.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Steven A. Falco" <sfalco@harris.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 18:44:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIQZT-0002qA-3W
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 18:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043AbZLIRnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 12:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbZLIRnN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 12:43:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39786 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbZLIRnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 12:43:13 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KUE009X5BW7DRC0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 Dec 2009 12:43:19 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B1FCF81.2010807@harris.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134989>

On Wed, 9 Dec 2009, Steven A. Falco wrote:

> We have been using git for a year or two now, and suddenly, one
> of our users got the error message:
> 
> fatal: cannot pread pack file: No such file or directory
> fatal: index-pack failed
> 
> while doing a git-pull.  We are using git version git-1.6.5.5.
> 
> I tried doing a "git fsck --full" on his repository and on the
> one he is trying to pull from, and neither shows any error.
> 
> If I clone his repository, the clone also gets the error message
> when trying to pull.
> 
> I can pull from him, but if he pulls from me, he gets the error
> message.
> 
> This is worrying, because the fsck doesn't show an error, but
> clearly something is wrong.

A few questions:

 - What is the OS on which the failing Git is running?

 - How long before the error occurs i.e. how many objects are received
   (and the transfer size) before the error?


Nicolas
