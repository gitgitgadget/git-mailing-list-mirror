From: Brad Roberts <braddr@puremagic.com>
Subject: Re: [3/5] Add http-pull
Date: Wed, 20 Apr 2005 20:27:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504202026180.2625-100000@bellevue.puremagic.com>
References: <20050417195900.GH1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 05:23:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOSHk-0002ic-B2
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVDUD1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVDUD1d
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:27:33 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:45760 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261196AbVDUD1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 23:27:31 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3L3RIEi017069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 20 Apr 2005 20:27:18 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3L3RHYl017065;
	Wed, 20 Apr 2005 20:27:17 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417195900.GH1461@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Date: Sun, 17 Apr 2005 21:59:00 +0200
> From: Petr Baudis <pasky@ucw.cz>
> To: Daniel Barkalow <barkalow@iabervon.org>
> Cc: git@vger.kernel.org
> Subject: Re: [3/5] Add http-pull
>
> Dear diary, on Sun, Apr 17, 2005 at 09:24:27PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > On Sun, 17 Apr 2005, Petr Baudis wrote:
> >
> > > Dear diary, on Sun, Apr 17, 2005 at 08:49:11PM CEST, I got a letter
> > > where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > > > There's some trickiness for the history of commits thing for stopping at
> > > > the point where you have everything, but also behaving appropriately if
> > > > you try once, fail partway through, and then try again. It's on my queue
> > > > of things to think about.
> > >
> > > Can't you just stop the recursion when you hit a commit you already
> > > have?
> >
> > The problem is that, if you've fetched the final commit already, and then
> > the server dies, and you try again later, you already have the last one,
> > and so you think you've got everything.
>
> Hmm, some kind of journaling? ;-)

How about fetching in the inverse order.  Ie, deepest parents up towards
current.  With that method the repository is always self consistent, even
if not yet current.

Later,
Brad

