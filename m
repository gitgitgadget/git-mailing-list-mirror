From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import.c: don't try to commit marks file if write failed
Date: Thu, 17 Jan 2008 21:09:12 -0500
Message-ID: <20080118020911.GQ24004@spearce.org>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org> <478F893A.6050105@nrlssc.navy.mil> <7vmyr4jpww.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 03:10:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFgg8-00040l-3w
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 03:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbYARCJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 21:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758104AbYARCJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 21:09:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36188 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbYARCJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 21:09:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JFgfK-00026I-BI; Thu, 17 Jan 2008 21:09:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C26120FBAE; Thu, 17 Jan 2008 21:09:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmyr4jpww.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70949>

Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > We also move the assignment of -1 to the lock file descriptor
> > up, so that rollback_lock_file() can be called safely after a
> > possible attempt to fclose(). This matches the contents of
> > the 'if' statement just above testing success of fdopen().
> >
> > Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> > ---
> 
> Shawn, could you lend an extra set of eyeballs on this one
> please?  It looks sane to me but obviously you are more familiar
> with the code.

I agree.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
-- 
Shawn.
