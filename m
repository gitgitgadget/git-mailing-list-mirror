From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 6/6] Use new compress helpers in builtin-pack-objects.c
Date: Thu, 10 Jan 2008 17:26:09 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801101724250.3054@xanadu.home>
References: <e5bfff550801101334p5df5adaerf0eeae02ddf28334@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 23:26:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5rH-0004BF-LG
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 23:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbYAJW0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 17:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbYAJW0P
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 17:26:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58157 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYAJW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 17:26:14 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JUG00F518ZLU370@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 10 Jan 2008 17:26:09 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <e5bfff550801101334p5df5adaerf0eeae02ddf28334@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70105>

On Thu, 10 Jan 2008, Marco Costalba wrote:

> This is the last one for this evening, this is interesting
> because pack_compression_level instead of the usual
> zlib_compression_level is used.

See documentation for the core.compression, core.loosecompression and 
pack.compression config variables.


Nicolas
