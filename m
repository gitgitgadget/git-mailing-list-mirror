From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Tue, 08 May 2007 11:35:17 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081131440.24220@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 17:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRwc-0000Iz-0P
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968292AbXEHPqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbXEHPpk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:45:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35871 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbXEHPfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:35:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ00299BAT5L70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 11:35:17 -0400 (EDT)
In-reply-to: <11786309071033-git-send-email-tytso@mit.edu>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46591>

On Tue, 8 May 2007, Theodore Ts'o wrote:

> This allows the user to regenerate the deltas in packs while doing
> a git-gc.  The user could just run git-repack -a -d -f -l after
> running git-gc, but then the first git-repack run by git-gc is
> a bit of waste.

Given the patch I just posted and my previous arguments I don't think 
this patch is in the spirit of git-gc.  I'd prefer if git-gc remained as 
simple with the least options as possible, but I don't care that much 
either.


Nicolas
