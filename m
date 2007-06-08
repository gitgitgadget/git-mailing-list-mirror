From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Teach filter-branch about subdirectory filtering
Date: Fri, 8 Jun 2007 23:05:05 +0200
Message-ID: <20070608210505.GA3025@steel.home>
References: <Pine.LNX.4.64.0706080130000.4046@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 23:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwldx-0006s7-NJ
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 23:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXFHVFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 17:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXFHVFJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 17:05:09 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:39476 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXFHVFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 17:05:08 -0400
Received: from tigra.home (Fc805.f.strato-dslnet.de [195.4.200.5])
	by post.webmailer.de (fruni mo60) (RZmta 7.2)
	with ESMTP id C01c1dj58Kfvc7 ; Fri, 8 Jun 2007 23:05:06 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0DAF2277BD;
	Fri,  8 Jun 2007 23:05:06 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4F72ABEA7; Fri,  8 Jun 2007 23:05:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706080130000.4046@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWosH
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49500>

Johannes Schindelin, Fri, Jun 08, 2007 02:30:35 +0200:
> 
> With git-filter-branch --subdirectory-filter <subdirectory> you can
> get at the history, as seen by a certain subdirectory. The history
> of the rewritten branch will only contain commits that touched that
> subdirectory, and the subdirectory will be rewritten to be the new
> project root.
> 

Maybe it could be made more general

    --subdirectory-filter <from> [--subdirectory-filter-to <to>]

<to> meaning root by default, and allow multiple filters to be set?
You would have to deal with file name conflicts in case some filters
refer to the same target directory, though.

It has already been asked how to split a project into many projects
based on directory boundaries. That'd help...
