From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: backup git repo on every commit
Date: Mon, 12 Oct 2009 11:37:54 -0700
Message-ID: <20091012183754.GP9261@spearce.org>
References: <194a2c240910120641sccf0e55xef4226269df78864@mail.gmail.com> <20091012141544.GF9261@spearce.org> <20091012183504.GA3872@mrslave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Israel Garcia <igalvarez@gmail.com>, git@vger.kernel.org
To: Christian Himpel <chressie@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPyZ-0007oN-Gq
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636AbZJLSic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757622AbZJLSic
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:38:32 -0400
Received: from george.spearce.org ([209.20.77.23]:54492 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757594AbZJLSia (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:38:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 42BF3381FE; Mon, 12 Oct 2009 18:37:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091012183504.GA3872@mrslave>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130051>

Christian Himpel <chressie@googlemail.com> wrote:
> Since this is meant as a backup, is there also a sane way to push the
> reflog entries as well?  Or is it okay just to copy .git/logs to the
> backup repository?

There isn't a way to transfer reflogs, but one could rsync them
over to the backup.  Some records might be missing their SHA-1 in
the backup if that particular object wasn't pushed there, but the
reflog code is generally tolerant of those garbage records.

-- 
Shawn.
