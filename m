From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git GUI bug?
Date: Thu, 17 Apr 2008 02:08:43 -0400
Message-ID: <20080417060843.GO29771@spearce.org>
References: <7e6dd49b-133d-4b71-96bd-d1ca0357aa15@b1g2000hsg.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 08:09:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmNJa-0001Cl-O1
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 08:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYDQGIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 02:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYDQGIr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 02:08:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38145 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYDQGIr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 02:08:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JmNIb-0006gT-4F; Thu, 17 Apr 2008 02:08:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D672620FBAE; Thu, 17 Apr 2008 02:08:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7e6dd49b-133d-4b71-96bd-d1ca0357aa15@b1g2000hsg.googlegroups.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79769>

Dill <sarpulhu@gmail.com> wrote:
> When trying to push a repo using git gui to Github it opens a new
> window saying pushing branch and working....please wait...Push works
> if I do it by command line and I think the bug may be related to
> public/private keys? Git GUI never asks for a password for when I
> upload the repo. Am I doing something wrong? (When I click sign off in
> Git gui it shows the correct name). I'm using msysGit 1.5.5. Thanks.

git-gui doesn't offer a way to feed a password to SSH, so you
need to use an ssh agent to load your key and bypass the SSH
password prompt.

-- 
Shawn.
