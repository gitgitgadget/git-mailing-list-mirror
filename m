From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 02:00:54 -0400
Message-ID: <20060515060054.GA28252@spearce.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4F8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 08:01:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfW8d-0003Yy-Ml
	for gcvg-git@gmane.org; Mon, 15 May 2006 08:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWEOGBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 02:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWEOGBB
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 02:01:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14215 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932314AbWEOGBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 02:01:00 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfW8X-0002Pn-Hh; Mon, 15 May 2006 02:00:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 38889212667; Mon, 15 May 2006 02:00:55 -0400 (EDT)
To: "Brown, Len" <len.brown@intel.com>
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670F4F8@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20024>

"Brown, Len" <len.brown@intel.com> wrote:
> it is tiresome to access kernel.org/git tree display
> to see the list of commits that changed a particular file.
> (and for files on my local disk, this isn't available).
> 
> How do I print the list of commits that change a particular file
> on my local disk?

I'm confused - why aren't these available on your local disk?  Do you
not have a clone of the kernel repository local?  If you don't have
a clone you aren't really going to be able to get a history.

But assuming you had one use whatchanged:

	git whatchanged A

will show only the commits which affected file A, listing them in
reverse order (most recent to oldest).

-- 
Shawn.
