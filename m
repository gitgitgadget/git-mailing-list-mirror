From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Mon, 4 Jun 2007 13:20:00 +0200
Message-ID: <e5bfff550706040420j22852e4btc41a88c79bffc49f@mail.gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com>
	 <200706040921.55861.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 13:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvAbe-0005Af-07
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 13:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbXFDLUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 07:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbXFDLUE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 07:20:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:63477 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbXFDLUB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 07:20:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1747639wah
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 04:20:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cHYI3fEXkw+TiMvHRMdr9nGCWKAnpwD7UtPUdmYt8ZvjioNn8fQkXUTlFbMeENRQnHMO5i6GogDSEdFutebmKmcIeQMlLajQgNlvXHhX9VO8DHMZTYOi7I9M76A+iUP7Vj5i/o8x1V3SFzcwLa/bHEyayE7VBv1K3X0j+jR3QWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YDnqf0rTwjREEHowJTOehd/U5gWx9WPRdd/qqnni81D30/UnzruZbPVwOiDemxc+ZWIj1rN62KfbQXdKETL4dDjrhq2CVfYVv23ZywnFEi6kMRSkVjysk/0vr7W+HeyOCZYWMYecKWYV3OHo4y7Bu06ki/ta/LO6OXhDyJks4Rs=
Received: by 10.114.167.2 with SMTP id p2mr4722037wae.1180956000776;
        Mon, 04 Jun 2007 04:20:00 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 4 Jun 2007 04:20:00 -0700 (PDT)
In-Reply-To: <200706040921.55861.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49092>

On 6/4/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Sunday 2007 June 03, Marco Costalba wrote:
>
> > Care has been taken to allow the wheel browsing experience to be as
> > natural as possible, in particular a way to avoid to switch when user
> > just wants to scroll has been implemented. Also, getting a responsive
> > scroll and switch command avoiding false positives was not immediate.
>
> I'm really sorry to say it Marco, but it's really disturbing.  You've
> obviously made great efforts to make it useable, but it just isn't.  The
> scroll wheel behaviour being inconsistent is just annoying.  Sometimes
> scrolling works, sometimes it doesn't, sometimes it switches content,
> sometimes it doesn't.  It's obviously based on timeouts for the different
> functions, but that just means that I have no idea what a particular
> operation will do at any given time.
>

Thanks for your comment. I will try to do the following:

- Allow to remove this possibility by unchecking a proper flag in
settings dialog.

- Change the color of the arrows, as example highlighting, when the
switch behavior became active, i.e. at the top and bottom of scroll
bar. So the user will know what a scroll action will do.

> I'm not sure I like the labels with arrows either; and the fonts changing size
> and visibility is inconsistent and discomfiting.
>

Ok I can use same font for both labels, not a biggie. Regarding the
arrows, any other idea to tell to the user something will happen when
scrolling is welcomed.

> On the plus side - I do like the idea of being able to perform these
> operations; jumping from revision to revision, or from log to patch is nice.
> However, I think it is unwise to invent a new graphical metaphor for an
> operation that already exists - the tabbed widget.

The tabbed widget is here to stay. I do not plan to remove it. But the
tabbed widget is also slower then a well behaved scroll swicth or link
clicking.

>  Similarly, the up and
> down are obvious candidates for toolbar buttons - an already established
> visual.
>

This could be added, but it seems not needed to me given that for the
suer is faster to click on the previous/next revision in the revision
list then reaching the toolbar.

> So - I think that the non-standard methods should be dropped (sorry); and be
> replaced with tabs for the patch/log switch and toolbar buttons for the
> up/down.  Also, the scroll-to-switch, while an interesting idea, gives
> unpredictable behaviour and so is uncomfortable to use.
>
> Sorry for being so negative; it's a shame after your obvious hard work.
>

Thanks for your comments. They are much more valuable and useful then
a 'yes...it seems more or less nice'.

Thanks
Marco


P.S: Scrolling is not based on timeouts. The rule is: if user starts a
scroll action while not at the extremes of the content then only a
scroll will occur. If the user starts a scroll action from one extreme
of the view (top or bottom) and the scroll direction goes toward out
of the screen then a switch will occur.
