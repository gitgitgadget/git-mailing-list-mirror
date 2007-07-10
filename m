From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support wholesale directory renames in fast-import
Date: Tue, 10 Jul 2007 09:55:54 -0400
Message-ID: <20070710135554.GK4436@spearce.org>
References: <7154c5c60707091809y7e0b67d5u3f94658b7e814325@mail.gmail.com> <20070710031036.GA9045@spearce.org> <469346D8.4080906@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Frech <david@nimblemachines.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 15:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GCH-0004PZ-Li
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbXGJN4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbXGJN4F
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:56:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39572 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbXGJN4E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 09:56:04 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I8GC3-0004Wv-3Y; Tue, 10 Jul 2007 09:55:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5D61220FBAE; Tue, 10 Jul 2007 09:55:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <469346D8.4080906@dawes.za.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52070>

Rogan Dawes <lists@dawes.za.net> wrote:
> Shawn O. Pearce wrote:
> >-Zero or more `filemodify`, `filedelete` and `filedeleteall` commands
> >+Zero or more `filemodify`, `filedelete`, `filename` and
>                                                 ^^ filerename

Ugh.  Thanks.  I just pushed out a corrected version.

-- 
Shawn.
