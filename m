From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: More qgit defects
Date: Sun, 30 Apr 2006 12:13:22 +0200
Message-ID: <e5bfff550604300313n5ebe84f7nf42c88789efe1@mail.gmail.com>
References: <1145484284.22097.10.camel@dv>
	 <e5bfff550604220416v592128fcj25185bbda3b4e493@mail.gmail.com>
	 <1146115210.30763.40.camel@dv>
	 <e5bfff550604270026q68ba8a4clfaf1b274a5b312cf@mail.gmail.com>
	 <1146163863.5133.37.camel@dv>
	 <e5bfff550604281021k60e0c0ebk7a89eb0c9c569c2a@mail.gmail.com>
	 <1146383451.12323.41.camel@dv>
	 <e5bfff550604300111n6db883d5w98c863efaab15b00@mail.gmail.com>
	 <1146389204.12323.90.camel@dv> <1146390144.13634.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: ydirson@altern.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 12:13:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa8vq-00007N-NY
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 12:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWD3KNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 06:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWD3KNX
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 06:13:23 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:60231 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750921AbWD3KNX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 06:13:23 -0400
Received: by wproxy.gmail.com with SMTP id 58so399217wri
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 03:13:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CHUSuuVGo8EYd60Wo41iWntAsA+wHB93IVFIhhch7KCfO0PyEFJB5qXitTncd7EYvPcLEix64EXCsILpy583r+tlhZpqIb07feTIlTbidnFaJgESqP9xIh0d8zWYJOsoC4uNBhpKsdhiA10OmQXVd4s9kqdm++Zjxucpp48TL8Y=
Received: by 10.65.23.20 with SMTP id a20mr1285475qbj;
        Sun, 30 Apr 2006 03:13:22 -0700 (PDT)
Received: by 10.65.163.11 with HTTP; Sun, 30 Apr 2006 03:13:22 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1146390144.13634.9.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19333>

On 4/30/06, Pavel Roskin <proski@gnu.org> wrote:
> On Sun, 2006-04-30 at 05:26 -0400, Pavel Roskin wrote:
> > No, something still feels wrong.  I think even the gurus of GUI cannot
> > decide what to do if many frames need to be on screen.  Do you know that
> > many graphic designers hate GIMP for the overuse of dockable toplevel
> > windows?  Krita prefers dockable frames.  Photoshop uses non-dockable
> > child windows, I believe.
> >
> > The difference for qgit is that is generally wants bigger windows.
> > Whether the revision tree or the patch, having more space allows the
> > frame to present a better picture to the users.
>
> Replying to myself, sorry.  How about tabs?
>
> One tab for the main view.  Basically what we have now.
>
> Then tabs for revisions.  We can have more than one revision open, with
> the comment and with the patch, and and with affected files.  They will
> have the GUI centered on the change made by the revision.  StGIT commits
> would have an editable comment.
>
> Then tabs for files.  Again, possibly more than one.  Each tab about a
> specific file.  The file history, annotations, maybe even an editor for
> the file.
>
> The idea was inspired by Azureus.
>

Throwing in the tabs is a *very* big change, but, just to discuss....I
agree on the note that in qgit we have three different approaches:
fixed frames (revisions, file tree, affected files), detachable frames
(patch) and separate windows (annotations).

This is a bit strange and could give an odd GUI feeling.

I like the tab idea because it's clear and simple and fixes the 'many
approaches' problem. What I would suggest is, at least at first step,
do not change the main view and have only three tabs:

Tab1: Main view with revisions, file tree (hide able), affected files.
Tab2: Patch view with patch stat and diffs
Tab3: File history + file content/annotation view

In other words just put the frames/windows as are now in browse able
tabs. In this way main view still gives a good amount of information
without requiring changing the tab and the tabs are reserved for 'big
space' needed infos only.


   Marco
