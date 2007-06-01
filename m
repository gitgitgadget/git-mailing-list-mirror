From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Unify write_index_file functions
Date: Fri, 01 Jun 2007 17:01:00 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0706011655130.12885@xanadu.home>
References: <20070601194856.66DFB4D7206@potomac.gnat.com>
 <56b7f5510706011316v6e4c6f9fj33ae61f0b30f1772@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Geert Bosch <bosch@gnat.com>,
	git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 23:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuEFE-0000jh-Rn
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 23:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762514AbXFAVBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 17:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762893AbXFAVBI
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 17:01:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59924 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763716AbXFAVBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 17:01:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIZ003276DOAIG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 01 Jun 2007 17:01:00 -0400 (EDT)
In-reply-to: <56b7f5510706011316v6e4c6f9fj33ae61f0b30f1772@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48886>

On Fri, 1 Jun 2007, Dana How wrote:

> (2) write_idx_file has a sha1 argument with different in & out meanings,
> requiring copies at some call sites.  Should this be 2 separate args?

I think the copy could be avoided entirely.  The pack_file_sha1 array 
doesn't need to have global scope.  The simple sha1[20] array with this 
patch can serve the pack_file_sha1 purpose as well just fine.


Nicolas
