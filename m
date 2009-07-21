From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Getting untracked files
Date: Tue, 21 Jul 2009 08:46:21 -0700
Message-ID: <20090721154621.GR11191@spearce.org>
References: <20090721152458.GH24439@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: Daniel Trstenjak <trsten@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:47:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHYT-0002SQ-Ju
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbZGUPqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZGUPqV
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:46:21 -0400
Received: from george.spearce.org ([209.20.77.23]:43658 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbZGUPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:46:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 98FA4381FD; Tue, 21 Jul 2009 15:46:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090721152458.GH24439@bug.science-computing.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123671>

Daniel Trstenjak <trsten@science-computing.de> wrote:
> 
> is there a nicer way to get the untracked files then
> with grepping the output of 'git status'?
> 
> Is there a plumbing command?

git ls-files --others --exclude-standard

-- 
Shawn.
