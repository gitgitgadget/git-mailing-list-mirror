From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Questions on patch lifecycle
Date: Tue, 22 Apr 2008 00:43:36 -0400
Message-ID: <20080422044336.GA29771@spearce.org>
References: <1208837481.26863.374.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: "Roman V. Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 06:44:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoAMz-0005n8-LX
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 06:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYDVEnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 00:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbYDVEnk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 00:43:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59783 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYDVEnj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 00:43:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JoALy-0007mD-4Y; Tue, 22 Apr 2008 00:43:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A539D20FBAE; Tue, 22 Apr 2008 00:43:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1208837481.26863.374.camel@goose.sun.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80057>

"Roman V. Shaposhnik" <rvs@sun.com> wrote:
>    0. Junio, are you the only Git maintainer or are there
>       others responsible for particular subsystems of Git?

There are a number of subsystem maintainers, but most stuff
does go through Junio, yes.
   
>    1. What's the official way of submitting a patch?
>       Is git-send-email(1) to this mailing list
>       good enough? Does a submitter have to have
>       a public tree that maintainer(s) can pull from?

Docmentation/SubmittingPatches

>    2. Once the patch is submitted how does the author
>       get notified whether it is accepted, rejected
>       or needs additional work.

Rejections get emailed to the author, and generally also to the list.

Acceptance needs to be watched for by the author by fetching Junio's
nightly updates, and seeing if your patch made it into next, or into
pu, or not at all.

If it isn't there after a couple of days and if you have also not
received a rejection notice indicating why it was not applied,
it probably got dropped.  A polite reminder would then be OK.

-- 
Shawn.
