From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Mon, 22 Aug 2011 16:57:27 +0100 (BST)
Message-ID: <1314028647.33750.YahooMailClassic@web29502.mail.ird.yahoo.com>
References: <4E52759E.3020005@drmicha.warpmail.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>, madduck@madduck.net,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 22 17:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvWsa-0006Ub-2L
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 17:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325Ab1HVP5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 11:57:31 -0400
Received: from nm8-vm1.bullet.mail.ird.yahoo.com ([77.238.189.198]:42149 "HELO
	nm8-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751254Ab1HVP5a convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 11:57:30 -0400
Received: from [77.238.189.52] by nm8.bullet.mail.ird.yahoo.com with NNFMP; 22 Aug 2011 15:57:28 -0000
Received: from [212.82.108.243] by tm5.bullet.mail.ird.yahoo.com with NNFMP; 22 Aug 2011 15:57:28 -0000
Received: from [127.0.0.1] by omp1008.mail.ird.yahoo.com with NNFMP; 22 Aug 2011 15:57:28 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 656422.19704.bm@omp1008.mail.ird.yahoo.com
Received: (qmail 33932 invoked by uid 60001); 22 Aug 2011 15:57:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1314028648; bh=y0AuxInHlEWYjuX8DRwM1NT9fxEO9kiSYTJbBODQ40g=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=BTajG7A8DlpzK4poBXYg1PpNvFQGEhc7OM7IZLNPpAUvdaLfsxXAvSv/h1FWhodwq4lunwXpfJGcTdUG/ISfnVUA5L94fBQdYseue/zTZ821Ya63z+IghPRKrS+vDlRXAIm0+36diuRUOBuj7HOSyBdQ8PU0gbYS8ShaBFM/CEA=
X-YMail-OSG: GlYevJQVM1my5nlVcWtw8e0FjVdU1iVWPCwC.WX13JX2rvD
 ZIV8U4GfawjPbqbpQ35pD4fekcEBNGbfGUxsU4_9005JYy5q3wk1nuf0cVGY
 SxBf81wQ6iWRXqav8fsS.x2KTST_t7M3gSFI.oF8jJWI7C9t5LpreTziWlJ_
 nmVa8xf_fCAx3LuyLoBC003Taaln1eiBGYsbNldrfCjyxDrBXVH271.FWq4l
 elDYIZvoiMw21Y79Jd9U9g7Eq4JhbukG4KIaHHpMfd8Y710xoHCnUkAPlKdb
 rciRx1mpV0s9VwtDvFdw34.mpb4RFp3HlJ0dm9SxrIfTWWehRD0FHDWO87Kz
 oA0Z612C9xpxX7bIlgz1i0Skkdbtnvb2rLY.bv4ONmNu84qnAuFilgvzueU0
 IHIO3aCBu4yp.B2rVxM8j2Jb0Z7RG
Received: from [81.101.129.153] by web29502.mail.ird.yahoo.com via HTTP; Mon, 22 Aug 2011 16:57:27 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.315625
In-Reply-To: <4E52759E.3020005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179869>

--- On Mon, 22/8/11, Michael J Gruber <git@drmicha.warpmail.net> wrote:

> >> It is not trying to do that at all. git-svn is
> trying to
> >> figure out what
> >> the "base path" is in an svn repo which possibly
> hosts
> >> multiple repos,
> >> and that is what the message reports.
> > 
> > Okay... thanks for clarifying that. Maybe it could try
> to be clever? Afterall, --stdlayout isn't compatible with a
> URL ending in "trunk" (or having 'trunk' as part of the
> URL). Just a suggestion.
> 
> You *could* have this layout:
> 
> foo/trunk/trunk
> foo/trunk/tags/v1
> foo/trunk/tags/v2
> 
> That's a perfectly valid layout. The fact that it is
> stupidly named
> should not activate git-svn magic.

Fair enough. Perhaps --stdlayout in combination with URL having "trunk" in the name can emit a warning? e.g. "are you sure? That looks a bit stupidly named". I wrote because I think git-svn could either try a bit harder at guessing, or be a bit clearer about the repository not conforming to a standard layout (if the URL is wrong).

Hin-Tak
