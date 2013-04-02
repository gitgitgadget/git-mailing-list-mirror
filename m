From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Tue, 2 Apr 2013 21:09:48 +0100
Message-ID: <20130402200948.GF2222@serenity.lan>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7XJ-0000yC-FS
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737Ab3DBUJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:09:59 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:43420 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932743Ab3DBUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:09:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 43951161E4D0;
	Tue,  2 Apr 2013 21:09:58 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHJe3nwFcUD9; Tue,  2 Apr 2013 21:09:57 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 9C0A7161E2EE;
	Tue,  2 Apr 2013 21:09:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219875>

On Tue, Apr 02, 2013 at 01:02:49PM -0600, Felipe Contreras wrote:
> Here is the next round of patches for remote-hg, some which have been
> contributed through github.
> 
> Fortunately it seems to be working for the most part, but there are some
> considerable issues while pushing branches and tags.

How does this compare to the current state of gitifyhg[1]?  That's built
on top of this git-remote-hg script but seems to have been more actively
developed recently.

[1] https://github.com/buchuki/gitifyhg

> Dusty Phillips (1):
>   remote-hg: add missing config variable in doc
> 
> Felipe Contreras (11):
>   remote-hg: trivial cleanups
>   remote-hg: properly report errors on bookmark pushes
>   remote-hg: make sure fake bookmarks are updated
>   remote-hg: trivial test cleanups
>   remote-hg: redirect buggy mercurial output
>   remote-hg: split bookmark handling
>   remote-hg: refactor export
>   remote-hg: update remote bookmarks
>   remote-hg: force remote push
>   remote-hg: don't update bookmarks unnecessarily
>   remote-hg: update tags globally
> 
> Peter van Zetten (1):
>   remote-hg: fix for files with spaces
> 
>  contrib/remote-helpers/git-remote-hg     | 73 ++++++++++++++++++++++++--------
>  contrib/remote-helpers/test-hg-bidi.sh   |  6 +--
>  contrib/remote-helpers/test-hg-hg-git.sh |  4 +-
>  3 files changed, 61 insertions(+), 22 deletions(-)
> 
> -- 
> 1.8.2
