From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Conflict editing
Date: Mon, 5 Mar 2007 17:48:32 +1300
Message-ID: <46a038f90703042048m42ec07f6yab41c2a2de410ac9@mail.gmail.com>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070304181044.GC8560@thunk.org>
	 <46a038f90703041359w3cf5ff14n85445396c0ffc422@mail.gmail.com>
	 <20070305040406.GB26781@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 05 05:48:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO57m-0001ed-QV
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 05:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbXCEEsf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 23:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXCEEsf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 23:48:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:47266 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbXCEEse (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 23:48:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1139326uga
        for <git@vger.kernel.org>; Sun, 04 Mar 2007 20:48:33 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h6bNsf3uWOaY077rlON9+dCYJ0w704hxM6+fi6RxxIJqJilqqPxHoAOgk9+WShZsdMEfNCaIiu3oJEHVooK4gudgTt1c+YAq98aZoVqE0FNdgXOW0lT+sGxmVkU/PrV5IF1sjE9EFNw4mN+aM5kPa5H5K3440ilru54vSLcm9W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q0/Of8UYBWKfuYuIJ5JauM34mU+1K2raCMDRQOrdOdxlkxKrOoXX0pnFzTutJOHG+J6CEm1By2OVYd58QDdw1livU+oJ7muGgONgn6q/WjqJzllmpDHkFCeZFhUZ9wF5/2ofkgYQah8KSVARXaDQYtD2fFeRxBdAXbRvRY6N/3I=
Received: by 10.66.232.9 with SMTP id e9mr9741139ugh.1173070112989;
        Sun, 04 Mar 2007 20:48:32 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Sun, 4 Mar 2007 20:48:32 -0800 (PST)
In-Reply-To: <20070305040406.GB26781@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41400>

On 3/5/07, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Mar 05, 2007 at 10:59:33AM +1300, Martin Langhoff wrote:
> > I find xxdiff much better than meld, tkdiff and kdiff -- but maybe I
> > just don't know how to use them, or they have gotten better in the
> > last few months.
>
> I wasn't familiar with xxdiff until just now, but having played with
> it, kdiff3 is much easier for a beginner to use.  The toolbar makes it
> a lot easier to select from one or the other, I find the keyboard
> accellerators to be much more intuitive (although I suppose if you are
> a vi or nethack fan the H, J, K keys will make sense to you :-).

No, I hate that navigation. But arrow keys and pageup/down work great
for me. Mouse navigation is superb too.

> In addition, with xxdiff it gives the user way too many options about
> whether you want to save the left, right, or center, or merged
> windows.

I can understand that. But it also does in-the-line diff colouring
that I haven't seen the others do. Where the lines don't match on
something small, you can see the offending characters in a slightly
different tone (I'm colourblind, so I'm unsure of the exact colour,
but it does work).

I find xxdiff to be an order of magnitude faster than meld and kdiff3.
And at least kdiff3 spews garbage about trying to start the whole of
KDE infrastructure hairball so it messes up my terminal where I had
interesting messages from the just-executed git-pull.

So at least for now xxdiff is my well-behaved, flexible and fast tool ;-)

And I can see at a glance that single quotes got replaced with double
quotes or a trailing space got added or trimmed and _that_'s why the
thing didn't merge cleanly.

> > One thing I _don't_ want as a user is to see the graphical mergers
> > starting by default. Most merges are trivial, and I can just edit them
> > in emacs or vi.
>
> Well, git will handle most merges automatially for you anyway.  You
> would only use git mergetool to handle the merge conflicts.

Sorry -- I meant to say most conflicts are trivial. Someone mentioned
auto-running gui tools on any conflict, and don't think I want that.

cheers,


martin
