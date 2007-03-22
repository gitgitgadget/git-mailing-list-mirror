From: Nicolas Pitre <nico@cam.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 13:28:55 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703221327370.18328@xanadu.home>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com>
 <200703211024.04740.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703221257020.18328@xanadu.home>
 <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:29:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUR6A-0008IF-3B
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 18:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934136AbXCVR25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934144AbXCVR25
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 13:28:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50199 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934136AbXCVR24 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 13:28:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFB00A86F87EKE0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 22 Mar 2007 13:28:56 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42871>

On Thu, 22 Mar 2007, Linus Torvalds wrote:

> On Thu, 22 Mar 2007, Nicolas Pitre wrote:
> 
> > On Thu, 22 Mar 2007, Linus Torvalds wrote:
> > 
> > > I can't really say whether there are other problems too - electric fence 
> > > has a few bugs in that it considers zero-length allocations to be 
> > > "probably a bug" and aborts. This makes some of the tests fail with 
> > > efence, when re_compile_internal wants to allocate a zero-length object.
> > 
> > You can tell it not to abort on zero-length allocations by setting the 
> > EF_ALLOW_MALLOC_0 environment variable to 1.
> 
> Ahh,that gets me further, but then it bombs out on the added error 
> messages. Is there something for that braindamage too?

The efence man page doesn't mention any.


Nicolas
