From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 18 Apr 2007 22:39:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704182233140.4504@xanadu.home>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 04:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMYU-0007DS-03
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 04:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031055AbXDSCjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 22:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031065AbXDSCjL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 22:39:11 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19873 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031055AbXDSCjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 22:39:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGQ00JTK4P8TWF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 22:39:08 -0400 (EDT)
In-reply-to: <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44979>

On Wed, 18 Apr 2007, Junio C Hamano wrote:

> * np/pack (Mon Apr 16 12:32:13 2007 -0400) 25 commits
> 
> Nico's "optionally 64-bit pack idx" aka idx format version 2.
> I've taken another pass at them and am planning to push them out
> on 'master' hopefully this weekend, but a documentation update
> that mention the new --index-version option to git-pack-objects
> would be nice to have before that happens.

Well... In fact I didn't intend for that option to ever be used by 
anything but test scripts in order to trigger some code paths without 
generating jumbo packs (don't know what people would think of me if I 
created a 8GB pack in my test ;-)).  Therefore I didn't think that 
option was worth documenting.

But if you insist I'll send you a patch.


Nicolas
