From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Tue, 01 May 2007 14:39:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0705011438490.6574@xanadu.home>
References: <463679EB.2010301@gmail.com> <20070501050633.GZ5942@spearce.org>
 <56b7f5510704302241n79601619kda8251a9f7776884@mail.gmail.com>
 <20070501060340.GD5942@spearce.org>
 <alpine.LFD.0.98.0705011318000.6574@xanadu.home>
 <56b7f5510705011058y89e4aa4p8f8b7eccde30af78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 20:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HixGm-0005Hy-0d
	for gcvg-git@gmane.org; Tue, 01 May 2007 20:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031280AbXEASj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 14:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031288AbXEASj6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 14:39:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37202 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031280AbXEASj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 14:39:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHD00E5VL6I2T70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2007 14:39:55 -0400 (EDT)
In-reply-to: <56b7f5510705011058y89e4aa4p8f8b7eccde30af78@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45970>

On Tue, 1 May 2007, Dana How wrote:

> I was in the middle of creating pack-write.c at Shawn's suggestion. It 
> will only contain fixup_header_footer(), to be called by fast-import.c 
> and builtin-pack-object.c.  index-pack.c also has 
> readjust_pack_header_and_sha1(), which is compatible except it doesn't 
> close the file.  I was going to leave it alone for now.  This new file 
> should be the logical place to put other common pack-writing-related 
> things.  Please barf now if you don't think I should do this tiny 
> refactoring at this point.

That's fine.  Please go ahead.


Nicolas
