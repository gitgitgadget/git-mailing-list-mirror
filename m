From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Wed, 12 Dec 2007 00:13:03 -0500
Message-ID: <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
	 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
	 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
	 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
	 <20071212041002.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David <davvid@gmail.com>, "Marco Costalba" <mcostalba@gmail.com>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:13:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2JuQ-0003zX-Td
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 06:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbXLLFNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 00:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbXLLFNH
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 00:13:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:19783 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbXLLFNF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 00:13:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so156351wah.23
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 21:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EyY87x0b5Rhqvq0Z8jQwcgKsBWx5LuIfq+m9PFneaOE=;
        b=WMRc6QJozDzpKh61znuKUQ2emWljdaMqS7gvlkjF4qnj4BKhKK17m1hepfOEQI2Pq4pBO+2oYyIsCdrLrBkvzbaUrvbLJM2JL+8ymkILb04N4itUp7O2bnEFonHPZRgfsYSi6ZyiqI5qg0mOqmEmQUmY4ZhFVaaoWvXyTr1Qtrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N174kqfFJdo6jEdujLDbs33SLo5Cr9LmHoRGWUM1iFh0RcLkPnAUBym3bvi/3idESrFlLKGFmG2RlXAFxgh5attG39/aiOUoiAjxrm+wsT+bBJLCaLb06+A+HBrD7xCcsDX6o+YaC+KB42DXfoWi05VHhWLK9+VfcZeTwhNKTxU=
Received: by 10.114.176.1 with SMTP id y1mr295727wae.86.1197436383660;
        Tue, 11 Dec 2007 21:13:03 -0800 (PST)
Received: by 10.115.18.14 with HTTP; Tue, 11 Dec 2007 21:13:03 -0800 (PST)
In-Reply-To: <20071212041002.GN14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67993>

On Dec 11, 2007 11:10 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jason Sewall <jasonsewall@gmail.com> wrote:
> > Anyway, ugit is very good for a first draft; its text display beats
> > whats in git-gui in a big way (and I would *hope* qt4 would beat
> > Tcl/Tk at that at least).
>
> Are you just using the wrong fonts under git-gui?  I mean both
> Tk and qt4 are drawing text through your windowing system, from
> the same pool of font files... if qt4 can draw nice text then
> so can Tk, right?

I don't know much about graphical toolkits and the like, but I think
that the more modern ones have fancy features like antialiasing and
subpixel rendering, which makes a big difference when you're working
on a laptop with a tiny screen.

Take a look for yourself:
http://img441.imageshack.us/img441/492/comparejd6.png

They are obviously using different fonts there (because I can't figure
out what font ugit is using) but there is a difference in rendering
quality to be sure.

The qt stuff fits better with the rest of my system better too (even
though I'm using gnome) - it's entirely the result of Tk being
lightweight and a million years old, when UI conventions were
different (like every menu being detachable, and antique scrollbars).
I'm not here to start a toolkit flame war (we had a toolkit dogpile on
the list last week, I think) I'm just pointing out that Tk is from a
different era.

I use git-gui and gitk for my git graphical needs because they rock
and at the end of the day, the fonts and antialiasing aren't that big
of a deal, especially since I'm usually doing quick scans and searches
over the information those tools display, not reading novels in them.

Jason
