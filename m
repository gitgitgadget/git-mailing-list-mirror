From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-cvsserver won't add new content on update
Date: Thu, 18 Jan 2007 11:22:22 -0500
Message-ID: <20070118162222.GE15428@spearce.org>
References: <200701181616.38318.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 17:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7a20-0000e6-NL
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 17:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbXARQW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 11:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXARQW0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 11:22:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54909 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbXARQW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 11:22:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7a1r-0006ZB-2N; Thu, 18 Jan 2007 11:22:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D824C20FBAE; Thu, 18 Jan 2007 11:22:22 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200701181616.38318.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37120>

Andy Parkins <andyparkins@gmail.com> wrote:
> I am trying to use git-cvsserver to supply CVS access to my git repository.  
> The checkout worked okay, but now, during normal operation, I've made changes 
> and added content.  After a cvs update the changed files all seem to have 
> been updated as expected, however the added files are not being added.  
> However, CVS is reporting that the file is added; but it never appears.
> 
> some/sub/directory$ cvs update
> A some/sub/directory/file.c

You need to commit first to get the file completely added.
What you are seeing above is that the file was listed in
some/sub/directory/CVS/Entries so that the next commit will
know to upload the file to the server.  Until then its not
actually going to do that...

-- 
Shawn.
