From: Nicolas Pitre <nico@cam.org>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 17:20:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606141716460.2703@localhost.localdomain>
References: <1150269478.20536.150.camel@neko.keithp.com>
 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
 <1150307715.20536.166.camel@neko.keithp.com>
 <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
 <1150311567.30681.28.camel@neko.keithp.com>
 <Pine.LNX.4.64.0606141514000.2703@localhost.localdomain>
 <1150319115.30681.54.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 23:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqcn6-0005rv-3a
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 23:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWFNVUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 17:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFNVUl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 17:20:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26835 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932333AbWFNVUl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 17:20:41 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0V000KMCMGK5F0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Jun 2006 17:20:40 -0400 (EDT)
In-reply-to: <1150319115.30681.54.camel@neko.keithp.com>
X-X-Sender: nico@localhost.localdomain
To: Keith Packard <keithp@keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21865>

On Wed, 14 Jun 2006, Keith Packard wrote:

> Hmm. As I'm deltafying along branches, the delta data should actually be
> fairly good; the only 'bad' result will be the sub-optimal object
> ordering in the pack files. I'll experiment with some larger trees to
> see how much additional savings the various repack options yield.

Note that the object list order is unlikely to affect pack size.  It is 
really about optimizing the pack layout for subsequent access to it.


Nicolas
