From: James Purser <purserj@ksit.dynalias.com>
Subject: Re: Cogito Tutorial If It Helps
Date: Wed, 27 Apr 2005 07:36:43 +1000
Message-ID: <1114551403.3083.3.camel@kryten>
References: <1114548747.3083.1.camel@kryten>
	 <20050426211834.GO13224@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 23:31:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQXd9-0003pV-4m
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 23:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVDZVfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVDZVfA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 17:35:00 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:25216 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261800AbVDZVe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 17:34:56 -0400
Received: from localhost.localdomain (kryten [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id j3QLamdR003224;
	Wed, 27 Apr 2005 07:36:48 +1000
Received: (from purserj@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j3QLah7U003223;
	Wed, 27 Apr 2005 07:36:43 +1000
X-Authentication-Warning: localhost.localdomain: purserj set sender to purserj@ksit.dynalias.com using -f
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050426211834.GO13224@pasky.ji.cz>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-27 at 07:18, Petr Baudis wrote:
> Dear diary, on Tue, Apr 26, 2005 at 10:52:27PM CEST, I got a letter
> where James Purser <purserj@ksit.dynalias.com> told me that...
> > I reworked the previous tutorial to take in the changes in the scripts.
> > Will make this a series of tutorials to cover all aspects. Any
> > suggestions or hints or spelling corrections would be most welcome.
> > 
> > http://ksit.dynalias.com/articles.php?s_id=46&art_id=41
> 
> Thanks for writing that! :-)
> 
> I'd vote for describing the cg-update right near cg-pull, or perhaps
> even before cg-update, as the primary method; I think it's commonly what
> people really want to do when they do cg-pull anyway.
> 
> cg-merge is _not_ like doing cg-diff | cg-patch - that's a dangerous
> thought, and not true at all. cg-diff | cg-patch will just apply the
> given diff to your working directory, but it won't record any merging
> metadata, will often get it very wrong, and you will get to all sorts of
> other troubles. Just always use cg-merge. And probably pass it -b only
> when you know what are you doing.
> 
> Thanks,

Thanks for that, I've changed it a little to point out that cg-patch
should really only be used for small single file patches.
-- 
James Purser
http://ksit.dynalias.com

