From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: visualizing Git's Git repo
Date: Mon, 26 May 2008 19:46:22 -0400
Message-ID: <20080526234622.GG30245@spearce.org>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org> <87ve104qoz.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Hanchrow <offby1@blarg.net>
X-From: git-owner@vger.kernel.org Tue May 27 01:47:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0mPN-0007Ix-8Z
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYEZXq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755561AbYEZXq0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:46:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37076 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbYEZXqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:46:25 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0mOL-0000Ed-OC; Mon, 26 May 2008 19:46:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A7A6A20FBAE; Mon, 26 May 2008 19:46:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87ve104qoz.fsf@offby1.atm01.sea.blarg.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82978>

Eric Hanchrow <offby1@blarg.net> wrote:
> You might not know -- I didn't until five minutes ago -- that you can
> omit entire branches, like this:
> 
>         $ gitk --all  ^refs/remotes/origin/man ^refs/remotes/origin/html
> 

And if you do this a lot you can remember it as a shorthand:

	$ git config alias.seeall '! gitk --all  ^refs/remotes/origin/man ^refs/remotes/origin/html'
	$ git seeall

-- 
Shawn.
