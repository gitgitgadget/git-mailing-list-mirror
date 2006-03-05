From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What's in git.git
Date: Sun, 5 Mar 2006 22:21:46 +1300
Message-ID: <46a038f90603050121u6bccbb71ve78de69ae45b96ad@mail.gmail.com>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 10:22:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFpRJ-00006o-BO
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 10:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbWCEJVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 04:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbWCEJVs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 04:21:48 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:7853 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752146AbWCEJVr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 04:21:47 -0500
Received: by wproxy.gmail.com with SMTP id i30so942771wra
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 01:21:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o4jqxqlN3RIeYnlg4MvwXYwN5+xYVghVD/ypCejtRQo6UIHk6u4idxrdpxNOIQcyIRw3h0iT7QqzBmla9Aikuh5xoQWHe0lklmAw5ts5KFEairVxl6m+qk5EGTib7QLvfM8QiMnZkPfJeUfoZzrnj9icUpktoL5j3TcUR56FN0Q=
Received: by 10.54.152.13 with SMTP id z13mr840523wrd;
        Sun, 05 Mar 2006 01:21:46 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Sun, 5 Mar 2006 01:21:46 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17209>

On 3/5/06, Junio C Hamano <junkio@cox.net> wrote:
>  - Emacs interface (Alexandre Julliard)
>    contrib/emacs: Add an Emacs VC backend.
>    git.el: Added customize support for all parameters.
>    git.el: Added support for Signed-off-by.
>    git.el: Automatically update .gitignore status.
>    git.el: Portability fixes for XEmacs and Emacs CVS.
>    git.el: Set default directory before running the status mode setup hooks.

I'm somewhat confused by the fact that there are two emacs modes, both
by Alexandre. Which one should I use? Also -- the killer app for
emacs+git would be to leverage the great patch-editing mode in emacs.

Can we get a new merge conflict mode that generates .rej files? Emacs
is superb at dealing with conflicts formatted that way. OTOH, it may
be able to deal smartly with diff3-style conflicts if it knows how to
talk with the VC backend -- I think the cvs mode can do that.

Linus has mentioned several times that it is more important to have
well oiled tools to deal with conflicts when they happen -- easy
visualization of what the different versions were, commit msgs,
highlight characters that don't match in a line that looks the same at
first glance, etc -- than to try and magically resolve conflicts. I'm
in violent agreement, and keen on seeing the emacs vc stuff fill that
gap.

(of course, if xxdiff and others can help, that'd be cool too, but
currently they seem strangely unable to deal with files with diff3
conflict markers.)

>  - git-cvsserver updates (Martin Langhoff)

Wohoo! This needs testers -- give it a whirl, please! BTW, the
workarounds for Eclipse mentioned in the doco are no longer needed.
Still, you do want to give Documentation/git-cvsserver.txt a quick
read.

cheers,


martin
