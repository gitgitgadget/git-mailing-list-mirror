From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 23:58:35 -0500
Message-ID: <20080306045835.GO8410@spearce.org>
References: <20080304051149.GS8410@spearce.org> <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com> <20080305053612.GA8410@spearce.org> <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com> <20080305081523.GK8410@spearce.org> <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com> <47CEB44F.9040404@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imran M Yousuf <imyousuf@gmail.com>,
	Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Noel Grandin <noel@peralex.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 05:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8Cn-0008Kd-UW
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbYCFE6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757524AbYCFE6u
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:58:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37705 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758285AbYCFE6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 23:58:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JX8BU-0006Z9-MZ; Wed, 05 Mar 2008 23:58:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5214620FBAE; Wed,  5 Mar 2008 23:58:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47CEB44F.9040404@peralex.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76329>

Noel Grandin <noel@peralex.com> wrote:
> Imran M Yousuf wrote:
> > To start with I was actually thinking of JNI + "exec from C". So later
> > when libification is completed we can replace the execs with call to
> > the libs directly instead. Is this a viable fourth option (sorry I
> > forgot to mention it the first time around)?
> 
> This is probably a good idea. JGIT is always going to be 2 steps behind
> the native GIT code when comes to accessing on-disk structures.

I'm not sure that is really going to be a major issue.

Thus far the Git on disk structure has been very stable over time.
We are 3 years old and yet have had very few file format changes,
and we are basically still backwards compatible.

The only new major on disk structure that JGit didn't support was
pack index v2, which I just taught JGit to parse tonight.  So yea,
we are a few months behind the bleeding edge on disk format, but
we are caught up again.
 
-- 
Shawn.
