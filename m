From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] run-command: Redirect stderr to a pipe before redirecting stdout to stderr
Date: Thu, 6 Mar 2008 01:42:25 -0500
Message-ID: <20080306064225.GS8410@spearce.org>
References: <20080305083516.e1a2a139.chriscool@tuxfamily.org> <20080306064415.c5ca762a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 07:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX9p3-00052K-F9
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 07:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbYCFGmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 01:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757061AbYCFGmd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 01:42:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37926 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688AbYCFGmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 01:42:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JX9oC-0002Mx-FF; Thu, 06 Mar 2008 01:42:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 950F120FBAE; Thu,  6 Mar 2008 01:42:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080306064415.c5ca762a.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76345>

Christian Couder <chriscool@tuxfamily.org> wrote:
> On Wed, 5 Mar 2008, I wrote:
> > With this patch, in the 'start_command' function after forking
> > we now take care of stderr in the child process before stdout.
> > ...
> 
> I am afraid I forgot the 
> 
> From: "Shawn O. Pearce" <spearce@spearce.org>
> 
> at the top of the patch in my last resend, so the patch was attributed to me instead of Shawn.
> 
> Is it possible to do something about it ? (I fear not since it is now in 'next' but maybe I am wrong.)

Nope, its done and over with.

Don't sweat it.  It was a very short patch, you wrote it apparently
independently from me, so the author line from you is just as valid.

I say its fine as is.  Maybe better.  Your version had an API
doc update.  My version is what triggered the "maybe we should
document the API before we modify it further" discussion.  ;-)

-- 
Shawn.
