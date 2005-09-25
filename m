From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 21:19:29 +0200
Message-ID: <200509252119.29306.Josef.Weidendorfer@gmx.de>
References: <20050925055259.50066.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 25 21:20:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJc2n-0003k2-Kv
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 21:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVIYTUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 15:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVIYTUK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 15:20:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:35808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932273AbVIYTUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 15:20:09 -0400
Received: (qmail invoked by alias); 25 Sep 2005 19:20:07 -0000
Received: from p5496A955.dip0.t-ipconnect.de (EHLO linux) [84.150.169.85]
  by mail.gmx.net (mp021) with SMTP; 25 Sep 2005 21:20:07 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20050925055259.50066.qmail@web26302.mail.ukl.yahoo.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9278>

Hi,

On Sunday 25 September 2005 07:52, Marco Costalba wrote:
> >* The commit time is relative to now, which makes no sense to me. Also,
> >it is in the second column instead of the last one like in gitk, which
> >seems better to me. At least, the column is too narrow and then it
> >blends together with the commit title.

I vote for absolute time, and the date column at the end, too.
Relative has no meaning when searching for an old commit.
Besides, QT allows to reorder the columns with the mouse (the order should be
saved in a config file at end to be persistant over program runs).

> >* Getting to the diff view was non-obvious for me. It'd be nice to have
> >some [diff] button as well somewhere. Or you could also show the diff in
> >the bottom part of screen in the commit view, I think gitk solved this
> >nicely.
>
> I have tought a lot how to pass to the user the information that to see a
> diff you have to double click on the commit:

I like the gitk solution better. 
What about making the commit list a QDockWindow, which can be docked to either 
side of the window (default: top as currently), but also made a floating 
window, so that the commit diff gets the whole main window?

> commit changes as does the file revision content: "pin file" checkbox
> simply avoids the file viewer content to change, only main view is updated.

The "pin" action is really not-obvious. Why not open new windows for different
file annotations? Or one window with tabs for each file?
Perhaps make the main window contain commit diffs and file annotations in 
tabs?

> Diagonal line could be nicer but doesn't leave you play some tricks to
> greatly speed up graph drawing. I really like those tricks ;-)

I think that diagonal lines as in gitk make it way easier to get an overview.
What makes drawing of diagonal lines slow?
It should be quite fast to subclass QListViewItem for commit entries and
overwrite QListViewItem::paintCell to use your own drawing; paintCell is 
called for visible entries only.

Another wish: The tag/head markers in gitk are really good. In qgit, I only 
get another background color, and miss the name.
You can do the same drawing as in gitk via paintCell, too.

> >Nice work otherwise. :-)

Yes, really nice.

Josef
