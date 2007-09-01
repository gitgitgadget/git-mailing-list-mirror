From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-tag: Fix -l option to use better shell style globs.
Date: Sat, 1 Sep 2007 01:31:58 -0400
Message-ID: <20070901053158.GF18160@spearce.org>
References: <46D8F431.70801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 07:32:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRLae-0006KD-VG
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 07:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbXIAFcH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 01:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbXIAFcH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 01:32:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33201 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbXIAFcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 01:32:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRLaR-0001o8-P6; Sat, 01 Sep 2007 01:31:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CF75A20FBAE; Sat,  1 Sep 2007 01:31:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46D8F431.70801@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57253>

Carlos Rica <jasampler@gmail.com> wrote:
> This patch removes certain behaviour of "git tag -l foo", currently
> listing every tag name having "foo" as a substring.  The same
> thing now could be achieved doing "git tag -l '*foo*'".

Even though this is a behavior change, I think its the right thing
to do.  The current behavior of searching "*$arg*" is downright
annoying and not what most users would expect I think, especially
when tools like for-each-ref don't do that.

Then again, I do "*$arg*" in git-gui's revision selection widget.
But there its immediately obvious what is happening and anyone I
have talked[*1*] to prefers it that way.


*1*: Disclaimer: people I talked to has thus far been limited to
     day-job coworkers.
 
-- 
Shawn.
