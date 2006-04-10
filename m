From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: git-svnimport on OSX?
Date: Tue, 11 Apr 2006 01:00:16 +0200
Organization: M38c
Message-ID: <20060410230016.GA28078@nospam.com>
References: <86fyku2ltk.fsf@blue.stonehenge.com> <46a038f90604031911y415dd795nc1c8814f80a02ad7@mail.gmail.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 01:00:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT5Mu-0002dV-Le
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 01:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWDJXAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 19:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWDJXAV
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 19:00:21 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:16603 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932163AbWDJXAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 19:00:20 -0400
Received: from wingding.demon.nl ([82.161.27.36]:36144)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FT5Mn-000853-5l; Mon, 10 Apr 2006 23:00:17 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FT5Mm-0008Pp-Iu; Tue, 11 Apr 2006 01:00:16 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90604031911y415dd795nc1c8814f80a02ad7@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18594>

On Tue, Apr 04, 2006 at 02:11:02PM +1200, Martin Langhoff wrote:
> On 03 Apr 2006 18:04:07 -0700, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >
> > Working for anyone?  Not working for me, and just wondered if it was me or a
> > known thing.  Maybe I'm just holding my mouth wrong, and yes, I have SVN::Core
> > installed.  If anyone wants details, I can provide.
> 
> I think I tried and gave up on it a month or two ago, but can't
> remember the details. Fink's SVN::Core is too old, and having all the
> SVN toolchain is a pain. What is the problem?
> 
> BTW, getting git-svnimport to work normally takes me quite a few tries
> with different options, so OSX may be perfectly innocent this time...

Could you try http://www.wingding.demon.nl/git-svnconvert.rb on
MacOSX? This one doesn't need SVN::Core, and I'm curious on what to
change for MacOSX.

By default it imports all branches it can find (see in file itself):

...
$branch_dirs = %q{
  /branches/*
  /trunk
}
...

If your layout is different (for example, like
http://svn.perl.org/perl6 where every subdir is a collection of
branches itself), use something like:

...
$branch_dirs = %q{
  */branches/*
  */trunk
}
...



-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
