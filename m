From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Mon, 23 Apr 2007 22:44:30 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704232236250.12375@xanadu.home>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
 <alpine.LFD.0.98.0704220925420.28339@xanadu.home> <462D5370.8040905@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgB1R-0008C9-4r
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 04:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbXDXCof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 22:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbXDXCof
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 22:44:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39750 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbXDXCoe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 22:44:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGZ00CH6EA9VA90@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Apr 2007 22:44:33 -0400 (EDT)
In-reply-to: <462D5370.8040905@zytor.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45407>

On Mon, 23 Apr 2007, H. Peter Anvin wrote:

> Nicolas Pitre wrote:
> > 
> > Object names aren't 40 bytes.  They are 20 bytes.
> > It  is their hex representation that takes 40 bytes.
> > 
> 
> Sure, but that's the way they're stored in *most* git objects, in particular
> in commit objects.

Commit objects aren't *most* objects.  They usually are blob and tree 
objects, and for the later the SHA1 references are stored as 20 byte 
binary.


Nicolas
