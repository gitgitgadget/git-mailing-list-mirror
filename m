From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Using git with Eclipse
Date: Mon, 10 Dec 2007 21:44:42 -0500
Message-ID: <20071211024442.GJ14735@spearce.org>
References: <475DC0CE.9070109@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 03:45:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1v7P-0005H5-NZ
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 03:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXLKCor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 21:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbXLKCor
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 21:44:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56586 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbXLKCoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 21:44:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J1v6n-0000Ds-Mc; Mon, 10 Dec 2007 21:44:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3496220FBAE; Mon, 10 Dec 2007 21:44:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <475DC0CE.9070109@saville.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67777>

Wink Saville <wink@saville.com> wrote:
> I'm trying to use git on an Eclipse workspace and the .metadata 
> directory is chock full of files and was wondering what, if anything, 
> should be ignored. At the moment .history looks like a candidate for 
> ignoring there are probably others.

Ignore all of .metadata; its Eclipse private state that you don't
want to version.  I'd add it to .git/info/exclude so its ignored only
in the repository that is using Eclipse, rather than in .gitignore
(which is published).

-- 
Shawn.
