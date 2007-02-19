From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 15:56:47 -0500
Message-ID: <20070219205647.GB27722@spearce.org>
References: <200702191839.05784.andyparkins@gmail.com> <17881.62094.56975.799862@lisa.zopyra.com> <m3fy91q3bq.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, Andy Parkins <andyparkins@gmail.com>,
	git@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJFZE-0003kr-NO
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbXBSU44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbXBSU44
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:56:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52603 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642AbXBSU44 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:56:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJFYx-0005G8-8E; Mon, 19 Feb 2007 15:56:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5193220FBAE; Mon, 19 Feb 2007 15:56:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m3fy91q3bq.fsf@maximus.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40151>

Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Bill Lear <rael@zopyra.com> writes:
> 
> > Would this be less error-prone, and just as efficient?:
> >
> > #define PATH_REMOTES "remotes/"
> > #define LIT_STRLEN(S) ((sizeof(S) / sizeof(S[0])) -1)
> > #define STRLEN_PATH_REMOTES LIT_STRLEN(PATH_REMOTES)
> 
> sizeof(char) is always 1.

Except when someone does something silly, like say:

	#define char double

:-)

-- 
Shawn.
