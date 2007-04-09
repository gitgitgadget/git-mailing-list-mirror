From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes
 'limit' arg
Date: Mon, 09 Apr 2007 15:25:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091523410.28181@xanadu.home>
References: <46197994.70009@gmail.com>
 <alpine.LFD.0.98.0704082034060.28181@xanadu.home>
 <56b7f5510704091151l70cc74b1la82e0c5a67d6885f@mail.gmail.com>
 <alpine.LFD.0.98.0704091455100.28181@xanadu.home>
 <56b7f5510704091220w69529e72n2f982c097c4e26a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:41:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HazUH-0005R1-K8
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbXDITZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbXDITZI
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:25:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35182 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbXDITZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:25:07 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG80048PWLUSOG0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 15:25:06 -0400 (EDT)
In-reply-to: <56b7f5510704091220w69529e72n2f982c097c4e26a0@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44072>

On Mon, 9 Apr 2007, Dana How wrote:

> For testing, I've been using git-fsck/git-verify-pack/git-unpack-objects .
> The only bugs they ever caught were (1) offset wraparound in .idx
> before I started this patchset (with a very bad error message) and
> (2) I failed to flush out the buffer before changing packs.
> Everything else has been detected manually (not always by me).  Hmm.

Make sure you always run 'make test' as well when you're done.


Nicolas
