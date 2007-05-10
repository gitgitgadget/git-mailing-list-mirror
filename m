From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Thu, 10 May 2007 13:20:02 +0200
Message-ID: <e5bfff550705100420x63b365f7x526c1d58d9d5c761@mail.gmail.com>
References: <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	 <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
	 <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
	 <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com>
	 <17985.19926.347089.878721@cargo.ozlabs.ibm.com>
	 <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
	 <20070509182844.GA2982@efreet.light.src>
	 <4c8ef70705091409g30674cb6p6d3af42eb47ffc08@mail.gmail.com>
	 <20070509213610.GA9144@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Fredrik Kuivinen" <frekui@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu May 10 13:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm6gt-00008o-7U
	for gcvg-git@gmane.org; Thu, 10 May 2007 13:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbXEJLUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 07:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbXEJLUF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 07:20:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:49309 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385AbXEJLUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 07:20:03 -0400
Received: by wr-out-0506.google.com with SMTP id 76so588348wra
        for <git@vger.kernel.org>; Thu, 10 May 2007 04:20:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dZvEK0aj8p1F+orD/8FT0s9wluFxBPTbn2kn487IaAULUP0GFcm2zFpfrvIGLnMhThnnhPtiyFkfEnrvyzUwfXcKpV2GixoHNLm4Y9Qrl8aoYs3e9cAmkO5/5o4lfDvLJBF+ges6xf0UxwwyqSRkD81S0CH/g1yAxA8sbLm+qxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XUTQsl8OwJyQqsK4tTBC90g8dS2FMEj1SSWVFbJgypunjpgTAuXDL2DYfnODvNkpyVMNUYD4AR8Z6PPCdu7eJpubPupXt5A802WTsmW+KIB2l6+ZPLtQ/1zQAD2rxW8QZzNGjWn5/2+N0O/Y94/XrEWIX8J4HvmmubFvGIAhIaI=
Received: by 10.114.167.2 with SMTP id p2mr483304wae.1178796002177;
        Thu, 10 May 2007 04:20:02 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Thu, 10 May 2007 04:20:02 -0700 (PDT)
In-Reply-To: <20070509213610.GA9144@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46857>

On 5/9/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Wed, May 09, 2007 at 23:09:25 +0200, Fredrik Kuivinen wrote:
> > I have used PyQt for some smaller projects (notably Hgct, a no longer
> > developed
> > commit tool for git and Mercurial. See
> > http://repo.or.cz/w/hgct.git?a=tree). For me
> > PyQt has worked very well. The python interface to Qt is more or less a
> > direct
> > translation of the C++ interface, so the excellent documentation troll
> > tech provides
> > for Qt can be used when developing with PyQt as well.
> >
> > I have never seen the segfaulting you mention. Maybe my programs have been
> > too
> > small to trigger that bug...
>
> It's not about size of the programs. It's about having to be careful not to
> refer to widgets inside eg. dialog box from outside and close that dialog
> box.

In Qt all the classes that ineriths from QObject are memory managed,
to be more clear
you can say that one class is "child" of another class (always
ineritherd from QObject) that becames the parent.

When you delete the parent, all his children are deleted too, this is
a (big) feature to avoid
missing free() calls for resources created with mallocs() , (well, in
C++ we say 'delete' for resources created by 'new' but the concept is
more or less the same).

Note that this property can be nested: create a main window, inside a
window there is a tab form, inside the tab there is a list view,
inside the list view there are items (lines of list view).

So *when* you delete the main window all this stuff is automatically
deleted by Qt. It is diffrent from a garbage collector because there
is no delay in releasing memory and all the thing is strict
deterministic.

So coming to your problem, if you need to refer to a widget inside a
dialog *after* the dialog has been deleted you can simply reparent to
NULL the widget before closing the dialog so to remove your object
from the delete list of the dialog.

Another option, in case your obect is not a graphical widget, is to
avoid declaring your object "child" of the dialog in first instance
setting his parent to NULL. This is clearly better because documents
'in code' also the real relationship between the dialog and your
object.

  Marco
