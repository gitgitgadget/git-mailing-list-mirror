From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 09 Feb 2008 18:38:39 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802091838070.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
 <200802091525.36284.kendy@suse.cz> <20080209220551.GA30139@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Holesovsky <kendy@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:39:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNzIJ-0004wJ-PE
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 00:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674AbYBIXip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 18:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756972AbYBIXin
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 18:38:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60012 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbYBIXil (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 18:38:41 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JVZ00D55WCGFCH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 09 Feb 2008 18:38:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080209220551.GA30139@glandium.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73275>

On Sat, 9 Feb 2008, Mike Hommey wrote:

> Speaking of which, I haven't taken a look at builtin-pack-objects.c deep
> enough but shouldn't it be possible to do prepare_pack and
> write_pack_file in one pass ?

No.


Nicolas
