From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: announce: git browser
Date: Mon, 5 Dec 2005 04:20:39 +0300
Message-ID: <40b2b7d90512041720i65f63ee1pcfe32d2c0c3c357b@mail.gmail.com>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
	 <20051205004238.GE22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 05 02:21:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej523-0007Bn-JL
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 02:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVLEBUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 20:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVLEBUk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 20:20:40 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:20512 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750718AbVLEBUk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 20:20:40 -0500
Received: by wproxy.gmail.com with SMTP id i3so1071683wra
        for <git@vger.kernel.org>; Sun, 04 Dec 2005 17:20:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FYxh5W64yjZTtvx0u8YbVb3umg12Jr3bG3tzC1c9oEgVHQ+ZvYjFiFfYvIzKqyHrSrkXlejEUX2qW+IejeA/OfHb+XFTUmor5+O+qcrv9t0snDVVlbz1grQ1+sL8MJwQI0C7ZxuoSVWnga61M6K4STUxs16q+Xw2DcoB9rDqkw4=
Received: by 10.64.183.2 with SMTP id g2mr2412532qbf;
        Sun, 04 Dec 2005 17:20:39 -0800 (PST)
Received: by 10.65.163.9 with HTTP; Sun, 4 Dec 2005 17:20:39 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051205004238.GE22159@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13209>

On 12/5/05, Petr Baudis <pasky@suse.cz> wrote:

> > See http://straytree.com/git-browser/GitBrowser.html?r=git
>
>   quite interesting! I always dreamt (not intensively enough to go
> myself and do it) about gitweb having gitk-like visualization, possibly
> this might help. ;-)
>
>   Couple of initial notes:
>
>   * I would find it much nicer if you wouldn't "squeeze" all the day's
> (except merge) commits together, but left them separate. Possibly a
> switch to squeeze them, but I'm really not sure if it's even useful to
> have.

Well it's easy to do, but then, in Linus tree, a single day would not fit
on my screen :-) So 'squeezed' mode is helpful for me, at least,
 to get big picture at a glance - in git tree, for example, I can see
the 0.99.5 release branch to  begin and end on a single screen.


>   * The line graphics etc. might be more colourful and prettier. ;-)

And the question is: the colours are assigned to what:
branches ? authors ? committers ? repositories ?


>   * Then it could have a "gitk mode" where the time flows vertically and
> author+title+time is shown in each line. It turns out that this might
> not be the prettiest, but it's really the most informative and useful
> view, IMHO.

But in this view, you can have only the number-of-lines-on-the-screen
commits visible. And with graphics done in javascript, scrolling is
painfully slow, at least in mozilla. And I think that implementing
quick search in a diagram will provide much more information
than one can get by 'visual grep' :-). So I don't know, need to think
a bit more .

>   * When I click on the little black box, the commit window disappears
> before I manage to click on anything inside; I would intuitively expect
> the reverse behaviour - that this happens when I don't click on the box.
> Or that clicking on the box does not matter. *shrug* The web interface
> with those windows popping up admitelly makes my mind somewhat
> uncomfortable, but it's hard to pin-point down why.

Yep, the boxes intentionally are not clickable, I think it makes navigation
easier, perhaps it could be made as a preference..


>   * Possibly, the commit information could be shown in a dedicated
> screen area altogether. It also wouldn't obscure the view of the actual
> diagram, and it would be more visible that it cutely highlights the
> appropriate box based on the current commit you have your cursor on.

Yes I also think about it. Initially the boxes were semi-transparent so
you could track the highlihgt under the box, it looked very nice,
but that was too slow to be usable on my computer, and opera
does not have that 'opacity' thing..

>   * It looks too much like Feynman diagrams when the merge arrow
> points slightly backwards; perhaps you could try to avoid that.

If I find a way to do it without further complicating placement algorightm,
maybe..

>   * It doesn't seem to handle the UTF8 characters properly


>   Quite nice for starters, though! The diff viewer looks pretty slick,
> too.

Thanks! Btw, I took the diff viewer pretty much unmodified from gitweb.

Artem.
