From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [FYI PATCH] git wrapper: DWIM mistyped commands
Date: Tue, 22 Jul 2008 22:37:30 +0200
Message-ID: <20080722203730.GC5113@blimp.local>
References: <alpine.DEB.1.00.0807222100150.8986@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOd2-0001HA-K8
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbYGVUhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYGVUhd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:37:33 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:34782 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYGVUhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:37:32 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (klopstock mo48) (RZmta 16.47)
	with ESMTP id R0320dk6MK6Sgh ; Tue, 22 Jul 2008 22:37:30 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 94322277BD;
	Tue, 22 Jul 2008 22:37:30 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 9189B36D17; Tue, 22 Jul 2008 22:37:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222100150.8986@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89525>

Johannes Schindelin, Tue, Jul 22, 2008 22:01:29 +0200:
> As a convenience, if there is only one candidate, Git continues under
> the assumption that the user mistyped it.  Example:
> 
> 	$ git reabse
> 	WARNING: You called a Git program named 'reabse', which does
> 	not exist.
> 	Continuing under the assumption that you meant 'rebase'
> 	[...]

Oh, that would make me suspicios (and I hit Ctrl-C fast when I get
suspicios about what happens to my precious data). Could it be
configurable? For example, BASH's cdspell is configurable and even off
by default.

P.S. I'm still using your first patch and am forced to like it every day :)
