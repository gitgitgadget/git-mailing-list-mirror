From: David Aguilar <davvid@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary
Date: Fri, 5 Sep 2008 21:17:34 -0700
Message-ID: <20080906041733.GA18930@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <20080903144552.GA27682@spearce.org> <20080903172050.61d510d6@pc09.procura.nl> <94a0d4530809030925t33d4260bof169372d65717af4@mail.gmail.com> <402731c90809031943n181ad6fbw366f90e80aaca2a@mail.gmail.com> <20080905221731.GI15520@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Sep 06 06:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbpN4-0005cV-W8
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 06:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbYIFEYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 00:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbYIFEYy
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 00:24:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:54374 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYIFEYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 00:24:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so713068rvb.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tglULDdWwBGeZX99osJ9pgkf/7U3nx6drC18IZv9YV0=;
        b=xBCHdCZw+g+71We+EmeiKy5djYnhJulA0FAfSAfRY7VKuw6UcIK7Rcj5Uiw/LbEvuK
         0ZxMcQF8lB3VW1Zqrk1yETrT11MiGr6Nn8KrDSTgLSvuXO1Glvcr8bb3OS7ZnfaiELuK
         dTXn3ySa4g+kBBmdK0SXgRDn4FoQXQ+LZxB6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HjCr4s9yXQ/ylK+ffarmH54+O5jvcJV6+0ICxSXkszzPwAlXh+Q00oPdYV3fmPfmfa
         bVLFr5Ix1k/0/y9/zpN2M6SAYfuzuXXuIs2n6DszTCUB1Eo4zK6MrTudNA2ln5qJQ7kd
         Ae0yZlhPbhVTBR1czLj/qNMLPd4Dbf8oh8UCE=
Received: by 10.141.205.10 with SMTP id h10mr7139421rvq.54.1220675090196;
        Fri, 05 Sep 2008 21:24:50 -0700 (PDT)
Received: from gmail.com ( [208.106.56.2])
        by mx.google.com with ESMTPS id l31sm2036444rvb.2.2008.09.05.21.24.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 21:24:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080905221731.GI15520@efreet.light.src>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95058>

On  0, Jan Hudec <bulb@ucw.cz> wrote:
> > 
> > There's already a python git-gui:
> >     http://cola.tuxfamily.org/
> > 
> > PyQt is a very mature library, which is one of the primary reasons I
> > chose Python.
> 
> Sorry, but I disagree. Tried PyQt, been hugely disapointed. Boils down to any
> thing that can make Python (or, for that matter, any) interpreter segfault
> being totally broken.


That's curious, I've never seen a single segfault.
You don't happen to run suse or fedora, do you?
I've not experienced your pains once on debian.


> But as far as Qt goes, I would really just stick with C++. Python or Ruby
> have some advantage, but I am not sure it's that big to offset the fact, that
> a lot of code already exists in QGit.

I have no comment here -- for me it boils down to the fact
that I end up writing much less code in Python vs. C++.  GUIs
are not performance critical.  Most of the time is spent in
the event loop waiting for user input.  Ditto for Ruby, tcltk,
etc --the benefit is in writing less code that does more.  I
sure as hell wouldn't write something performance critical in
those languages, but for something simple like a GUI it makes
perfect sense.

git-cola and qgit actually do different things.  qgit has
an awesome history viewer.  git-cola is primarily for doing
stuff like splitting apart changes into separate commits, etc.
I tend to work things up into a working state and then commit
things separately.  For example, there might be one commit
that does some refactoring and a second commit that uses the
refactored code, etc.  git-cola started out with emulating
git-gui's featureset though it has surpassed it now, which is
why its focus is on the commit workflow.


> > Does Ruby have any good and mature UI libraries?  I know it's all the
> > rage for web stuff, but I haven't heard too much about people using it
> > for GUIs.
> 
> Qt? I believe Ruby Qt bindings are in better shape (properly handle Qt
> deleting objects under Ruby's hands).

Right -- if you got segfaults due to object deletion it's
because you let things go out of scope.  I do not doubt that
the ruby bindings handle this better, but I have not ever
seen the problems you describe so I wouldn't know.
RubyQt looks interesting but the differences are superficial
given that I've not run into any problems.  As far as suckage
goes, ruby and python both suck equally so the choice is
immaterial ;)

Anyways, this is getting off topic for the git list so I'll
stop here.  If you have some pyqt examples that demonstrate
segfaults then I'm sure phil (pyqt author) would be happy
to see them, but those details are probably left off-list or
on the pyqt devel list. 

ciao,

-- 

	David
