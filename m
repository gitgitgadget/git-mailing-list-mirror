From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig - text-mode interface for git
Date: Wed, 17 May 2006 17:53:10 +0200
Message-ID: <20060517155310.GA12985@diku.dk>
References: <20060517120733.GA14041@diku.dk> <20060517165305.07b682b2.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 17:53:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgOL5-00012N-U2
	for gcvg-git@gmane.org; Wed, 17 May 2006 17:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWEQPxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWEQPxO
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 11:53:14 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:45548 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750734AbWEQPxN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 11:53:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 30AF477003C;
	Wed, 17 May 2006 17:53:12 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08998-07; Wed, 17 May 2006 17:53:10 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id F1228770036;
	Wed, 17 May 2006 17:53:10 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0EE8A6DF89F; Wed, 17 May 2006 17:50:18 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id AF4FE6242D; Wed, 17 May 2006 17:53:10 +0200 (CEST)
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060517165305.07b682b2.tihirvon@gmail.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20210>

Timo Hirvonen <tihirvon@gmail.com> wrote Wed, May 17, 2006:
> Jonas Fonseca <fonseca@diku.dk> wrote:
> 
> > Hello,
> > 
> > I am pleased to announce tig, a simple git repository browser written
> > using ncurses. Basically, it just acts as a front-end for git-log and
> > git-show/git-diff. Additionally, you can also use it as a pager for git
> > commands.
> > 
> > Currently, it just provides a minimum support for looking through
> > changes. I hope to slowly extend it to also be usable as a front-end for
> > git-blame and for tree browsing. Also, it doesn't do any fancy revision
> > graph rendering, but I want to at least give it a shot at some point. :)
> 
> Thanks.  This makes browsing repositories much easier.  It would be
> great if the colors were customizable.

I am open to providing a better default color scheme, since my fondness
of green might be too dominating. For now you will have to edit the
colors defined under LINE_INFO, but sure. I think supporting something
similar to CG_COLORS will suffice.

-- 
Jonas Fonseca
