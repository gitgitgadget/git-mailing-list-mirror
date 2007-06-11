From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Sun, 10 Jun 2007 22:09:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706102206590.12885@xanadu.home>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 04:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxZLW-0007J7-J9
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 04:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762209AbXFKCJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 22:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762600AbXFKCJX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 22:09:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36163 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762209AbXFKCJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 22:09:23 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JJG00CTU8NGIRH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Jun 2007 22:09:16 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0706091854330.4059@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49813>

On Sat, 9 Jun 2007, Johannes Schindelin wrote:

> The annotations are tracked in a new ref, refs/annotations/commits,
> in the same fan-out style as .git/objects/??/*, only that they only
> exist in the object database now.

Isn't this abusing the refs namespace a bit?  Why not 
.git/annotations/... instead?


Nicolas
