From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Wed, 30 May 2007 21:18:21 +0300
Message-ID: <e5bfff550705301118k4ca8720bna260e171f0eb83ca@mail.gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
	 <200705261034.53723.andyparkins@gmail.com>
	 <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
	 <200705301408.37929.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pavel Roskin" <proski@gnu.org>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 20:18:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtSkj-0007YL-SX
	for gcvg-git@gmane.org; Wed, 30 May 2007 20:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXE3SSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 14:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbXE3SSY
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 14:18:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:26382 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbXE3SSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 14:18:22 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1625211nzf
        for <git@vger.kernel.org>; Wed, 30 May 2007 11:18:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+NzkP52AylAw1PwNZjEsKMQsZgPt1o7yOEz45jLkaqnbPi66btpGDve5qQd6qrZIa17U9tvr/mAH8UlaySjjA2KCz8huL5qu7/rPyelc4iZ8UqDYLteMQ3PTfO6Yxl+5JM35UXCkrvfZzGlHL/894Sk02xt7ud9+hqTzNgAnI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rk/lWldQtJiA8izxmkuyg7RKSg/0HOpv6L98rz9FzlR8az6CHal8/UwQ/R9AS68wi/LI6RQWsDe4WjFvKHgNKk9vPXp1/iKo9EUwsJ9bJj4u2qvFU920ZoaNS0jGDm2p3yF5TVjVlH+qRT03R+Pz7U9XePtNVxQGl9AbOJr/zOk=
Received: by 10.115.54.1 with SMTP id g1mr509938wak.1180549101597;
        Wed, 30 May 2007 11:18:21 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Wed, 30 May 2007 11:18:21 -0700 (PDT)
In-Reply-To: <200705301408.37929.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48777>

On 5/30/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Saturday 2007 May 26, Marco Costalba wrote:
>
> I've been using the latest qgit for a couple of days.  Thought I'd comment on
> the changes.
>

Thanks!


>
> > Now user can toggle between revision commit message and patch content
> > with the menu entry 'View->toggle message/diff', or with shortcut 'm'
> > or also with mouse clicking on top right links 'Diff->' and 'Log->'.
>
> I like the principle; but I'm not sure about the floating "Diff->"
> and "Log->"; it seems to me that the GUI metaphor for exactly this sort of
> thing is well established - the tabbed display.  Why invent yet another way
> of switching a window between different views?
>

This 'Diff->' and "Log"thing are going to change a lot this week-end!

My (crazy) idea is:

- Let switch from message to diff content scrolling down after the end
of message.

- Let switch from diff to message content scrolling up before the
start of diff content

- Let browse from one revision to the previous one (going down by one)
scrolling down after the end of diff content.

- Let browse from  one revision to the next one (going up by one)
scrolling up before the start of message content.


So I imagine two labels for each content type:

- for message content a top right label called "Up" and one in bottom
right position called "Diff"

- for diff content a top right label called "Log" and one in bottom
right position called "Down"


I plan also to change the labels in something more intuitive with
scroll action, as example adding an up and down direction little
arrows next to them.


But that's not the end of the story: my mind went really mad while
thinking about this!

Because I normally browse new patches going from the oldest to the
earliest (going up), and for each patch I look before the message and
then (optionally) the content I 've wondered a nightmare like this:

Revision message pane:
-Up right position: one link label called "Up"
-Down right position: two links called "Diff"and (in small font) "Down"

Diff content pane:
-Up right position: two links called "Log"and (in small font) "Up"
-Down right position: two links called "Up"and (in small font) "Down"

Scrolling action defaults to bigger font label for either scroll direction.

It is possible to quickly switch each label couple: the big font label
became the smallest so to change scroll action in case of changing
repository browsing direction.

Directly clicking on each label of course produces the correspondent effect.


To much smoke??


>
> You don't mention it here, but the change I'm not keen on is the scroll-down
> to switch feature.  Often, I over-scroll to be sure that I have hit the
> bottom of a scroll box.  When I do that with the scroll-to-switch feature,
> suddenly the view changes.  I'm finding it quite disconcerting.
>

That's a problem of finding a suitable filter. There is already one
implemented that let you switch only once, you can keep scrolling but
the content will not change a second time, you need to stop scrolling
for a while to "rearm" the scroll action.


> While we're on wishes, here's a couple:
>  - It's hard to spot the boundaries between files in the the patch viewer.
>   It would be great if the
>    diff --git a/vserver/Makefile b/vserver/Makefile
>    index 2581254..17d8934 100644
>   lines had a different coloured background.

Yes. I agree. Thanks.

>  - The margin at the front of the log message lines puts the header block and
>   log text at different horizontal positions on the screen.  I think it would
>   be nicer if they were at the same position.
>

Yes.

> Maybe I'll scratch those itches myself; but thought I'd mention them in case
> you get to them before me :-)
>
>

Please, fell free to go head, I will be involved in implementing this
crappy scrolling thing toy this week end :-)

Thanks
Marco

P.S: In case someone wonders what's the goal of this label madness. It
is to be able to browse a repo in either both sequential directions,
up or down, using only the mouse wheel.
