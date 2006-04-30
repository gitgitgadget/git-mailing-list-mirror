From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Fwd: More qgit defects 1/2
Date: Sun, 30 Apr 2006 10:19:17 +0200
Message-ID: <e5bfff550604300119o6cff2634r421f11c1c32eee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Apr 30 10:19:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa79G-0001EI-Jm
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 10:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWD3ITT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 04:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWD3ITT
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 04:19:19 -0400
Received: from wproxy.gmail.com ([64.233.184.238]:45586 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751051AbWD3ITS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 04:19:18 -0400
Received: by wproxy.gmail.com with SMTP id 58so393026wri
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 01:19:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EzI37WcYtGFRqYzi61QGt5glNhlcyYnqPo+VmFDjKB3BzneNEfaYjND45odGbWYya6VDpMsXKg8YYEHUeE8kx/86gO69SwOWfySyw6JFiNZdHLdZEgqmTzxnagj/nrH6L/kqFbtYHm4cmnhK4Vb+0soz69+i2d2GNM9gPIntVIQ=
Received: by 10.64.10.13 with SMTP id 13mr2019077qbj;
        Sun, 30 Apr 2006 01:19:18 -0700 (PDT)
Received: by 10.65.163.11 with HTTP; Sun, 30 Apr 2006 01:19:17 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19330>

I would like to forward this thread to the list in case someone find
it interesting and/or suggests improvements.

---------- Forwarded message ----------
From: Pavel Roskin <proski@gnu.org>
Date: Apr 30, 2006 9:50 AM
Subject: Re: More qgit defects
To: Marco Costalba <mcostalba@gmail.com>
Cc: ydirson@altern.org


Hello, Marco!

On Fri, 2006-04-28 at 19:21 +0200, Marco Costalba wrote:
>   I have just pushed some patches according to your suggestions.

Thank you very much.

> If we don't find any issue/annoyance I would like to release 1.2 in
> the next couple of days, so to have a broader test base, and also
> because currently released 1.2rc2 has a bad crash bug.

I think it's good for the 1.2 release.

> So if you have any concerns or you would like to see something more
> added please let me know.

I think the list items in the file window need a pop-up menu.  Without
it, the users would not be able to discover what e.g. the double click
would do.

More generally, I feel that something is wrong with the user interface.
I think gitk is doing it better with a single pane that has the comments
and the diff.  Splitting the window horizontally in three panes seems to
be too much, especially when one of the panes is used for diffs.

Actually, qgit may be better for serious work, such as comparing the
description with the actual text.  But still, the panes are too small in
vertical direction, and if I tear off the diff, it will obscure
something.

The jumpiness of qgit has been largely fixed, but there are still cases
when mere selecting an item affect another window.

Is it really necessary to have a separate file window?  How different is
it from the main window with the "filter by tree" option on?  Can we
switch between diff and annotation?  More generally, what are the things
that the users are not normally viewing at the same time?

I'm not asking to fix anything, but qgit still feels odd to me.  I know
I'm not qualified to ask you to rearrange everything, because I'm not a
GUI specialist, and I don't see how qgit should work.

Maybe you could ask in the git list how to improve qgit?  I cannot find
any suitable forum about HIG (human interface guidelines), but if you
ask in the git list, maybe somebody will give you an idea where to ask.

--
Regards,
Pavel Roskin
