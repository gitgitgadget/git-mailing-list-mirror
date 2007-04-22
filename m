From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sun, 22 Apr 2007 09:27:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704220925420.28339@xanadu.home>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 15:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfc62-0005u4-DE
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 15:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030858AbXDVN1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 09:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030863AbXDVN1P
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 09:27:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64579 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030858AbXDVN1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 09:27:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGW006RNIPD9LA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 22 Apr 2007 09:27:14 -0400 (EDT)
In-reply-to: <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45238>

On Sat, 21 Apr 2007, Marco Costalba wrote:

> On 4/21/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 4/21/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > > Well, why to store always the full length SHA?
> > 
> > When Shawn gets done with full compression the SHAs would get stored
> > in the packfile once  and then be replaced with a token generated from
> > the compression algorithm. Compression tokens are designed to use the
> > minimal number of bits depending on frequency of occurrence.
> > 
> 
> Currently in Lunux tree there are about 445.424 objects (git
> count-objects -v), if each object has his 40 bytes name it is about
> 20MB to store sha *once*, probably with no real disambiguate need to
> be that much.

Object names aren't 40 bytes.  They are 20 bytes.

It  is their hex representation that takes 40 bytes.


Nicolas
