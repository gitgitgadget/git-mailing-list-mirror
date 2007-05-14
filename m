From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 06/10] user-manual: move howto/make-dist.txt into user manual
Date: Mon, 14 May 2007 17:39:16 -0400
Message-ID: <20070514213916.GF23090@fieldses.org>
References: <alpine.LFD.0.98.0705141043080.6739@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 14 23:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HniGK-0002wB-NU
	for gcvg-git@gmane.org; Mon, 14 May 2007 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358AbXENVjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 17:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbXENVjT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 17:39:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36772 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358AbXENVjS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 17:39:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HniGC-0002Pj-7l; Mon, 14 May 2007 17:39:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705141043080.6739@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47295>

On Mon, May 14, 2007 at 10:44:26AM -0700, Linus Torvalds wrote:
> Actually, these days it looks more like
> 
> 	#!/bin/sh
> 	stable="$1"
> 	last="$2"
> 	new="$3"
> 	echo "# git tag v$new"
> 	echo "git archive --prefix=linux-$new/ v$new | gzip -9 > ../linux-$new.tar.gz"
> 	echo "git diff v$stable v$new | gzip -9 > ../patch-$new.gz"
> 	echo "git log --no-merges v$new ^v$last > ../ChangeLog-$new"
> 	echo "git shortlog --no-merges v$new ^v$last > ../ShortLog"
> 	echo "git diff --stat --summary -M v$last v$new > ../diffstat-$new"
> 
> ie I'm using more modern versions of the git tools ;)

Oh, good.  I'll update that.

--b.
