From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: [PYRITE] Update on the status of pyrite.
Date: Tue, 18 Mar 2008 00:59:12 -0500
Message-ID: <5d46db230803172259m4ca25a6cu9df606a4774e32e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 07:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbUrx-0001AB-6j
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 07:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYCRF7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 01:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbYCRF7P
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 01:59:15 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:51653 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbYCRF7O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 01:59:14 -0400
Received: by wx-out-0506.google.com with SMTP id h31so6118229wxd.4
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 22:59:13 -0700 (PDT)
Received: by 10.151.145.5 with SMTP id x5mr739013ybn.12.1205819952782;
        Mon, 17 Mar 2008 22:59:12 -0700 (PDT)
Received: by 10.150.156.18 with HTTP; Mon, 17 Mar 2008 22:59:12 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 499d9d692be97c3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77491>

Here is the latest info on Pyrite.  The blog entry can be found here

http://pyrite.sophiasuchtig.com/2008/03/pyrite-gui.html

along with some screenshots of where the GUI part is headed.  The body of the
post is as follows....


---
It has been a while since I have posted anything on here. Here is something to
make sure people know about the current status of pyrite. I have been working
toward getting pyrite able to handle the day to day activities of
being a git wrapper.
That is, it is a pass-through porcelain on top of git. The current
TODO list looks
something like this.

    * Get basic commands to run on the command line. (this one is mostly done,
      I just have to do some of the more interesting things like
rebase, cherry-pick
      etc)
    * Add support for styles and templates. Think pretty-print or
styles/templates
      under Hg. ( I can probably tag v0.1 at this point)
    * GUI (see below, should be v0.2)
    * Built-in HTTP server. This will be similar to hg serve and use a similar
     framework. The hg serve is very nice and one of the things that prompted me
     to start this. (v0.3)
    * Convert direct shell commands to c extensions that do the shell commands.
      This doesn't make much sense by itself, but is very nice for the
next step...(v0.5)
    * Convert to libgit where libgit is currently implemented. Only
part of git functions as
       a c library, so much will still have to be done in
sub-processes. This will probably
       take a while (v0.9)
    * Squeeze out bugs and I can call it v1.0.

After that we will see where things go. I expect that much of my work
will go into
converting the places where I am forced to run sub-processes to
library functions in git.

Now on to the fun part, the GUI.

Long ago, I was temted to create a GUI for git that ran on Windows and
was written in
C#. This was called Widgit. I did some work on it, but I could not convince my
co-workers to be interested in git, and without someone to use what I
was writting, it
seemed kind of pointless. Fast forward a few months and I started
working on Pyrite.
Since this was more geared to the Linux crowd, I felt I could use
python and GTK+ to
make the GUI, but I liked several of the Ideas that I had for Widgit
and I thought I could
reuse them. Here is what the basic view looked like...

http://bp2.blogger.com/_UFT2vGj15mM/R99T5sePnfI/AAAAAAAAAAU/UQwzPlwk3pU/
s320/Screenshot-Widgit.png


There was a status pane also...

http://bp2.blogger.com/_UFT2vGj15mM/R99UVsePngI/AAAAAAAAAAc/vRnHrlW3VCs/
s320/Screenshot-status-tree.png

I was also fairly proud of the commit view filter, which I thought was handy...

http://bp2.blogger.com/_UFT2vGj15mM/R99VAsePnhI/AAAAAAAAAAk/8TJkbWnuzKg/
s320/Screenshot-CommitFilter.png

And I plan to have all of these elements in Pyrite. Also, I really
like some of the things
I have seen in other GUIs that I want to borrow. For instance the graphical tree
structure of Giggle is very nice and done using Cairo. Also, it shows
the diffs a la gitk.

http://bp1.blogger.com/_UFT2vGj15mM/R99VhcePniI/AAAAAAAAAAs/7iK79-42OK0/
s1600-h/Screenshot--Giggle.png

So all these things are nice. I have done a little bit of work on the
GUI, but its just
getting started. Here you can see what the current status of it is...

http://bp1.blogger.com/_UFT2vGj15mM/R99V5cePnjI/AAAAAAAAAA0/RkbQlqdNl-o/
s1600-h/Screenshot-Pyrite.png

If anyone has any suggestions, I will be glad to hear them.

-Govind
