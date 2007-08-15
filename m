From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 02:04:53 +0200
Message-ID: <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>
	 <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
	 <Pine.LNX.4.64.0708081810130.14781@racer.site>
	 <75EB313E-807D-44FB-A186-A151F182B47B@zib.de>
	 <Pine.LNX.4.64.0708082228520.21857@racer.site>
	 <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de>
	 <e7bda7770708092307g49fa9976l5f9972592129fc8e@mail.gmail.com>
	 <2383328F-300E-459C-A299-90242DA230F7@zib.de>
	 <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com>
	 <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 02:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL6O0-0007Ag-11
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 02:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760371AbXHOAFD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 20:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757368AbXHOAE6
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 20:04:58 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:41518 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482AbXHOAEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 20:04:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2338432wah
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 17:04:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P2kl0Dj0wntvnRnzMmbwoZa6VVyv83o5SUfC2twbcHzpylDJ7tTbZLSGp1gVcDqVvS2nGofG7nhvJYcFFdlqW2+8gnl+vfaKXrZwd8IeJ+5TmiRs6iOqmNkrUTIW6NbyX37sxn6xOgitmCF/OtPdcAtib67mnlnfUkB22QSLCiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lZIxzoAVDWWG7wBvF6m6DLSItgqEsnwlMS5YI/79NQbjvejeeZ4D/cH4appN7PZB16xDMu01BfHZH8k808Wb6ogo0iA9JOd4P7OuSRSH8PcsoIhjGjOq4Y2x+8RXOeOiO66KX4M5rIPPq4EcbXW5xOpzAhEdDE73R3nz5IIMJr4=
Received: by 10.114.198.1 with SMTP id v1mr4822630waf.1187136293808;
        Tue, 14 Aug 2007 17:04:53 -0700 (PDT)
Received: by 10.114.180.20 with HTTP; Tue, 14 Aug 2007 17:04:53 -0700 (PDT)
In-Reply-To: <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55865>

On 8/11/07, Steffen Prohaska <prohaska@zib.de> wrote:

> >>  [..list of tools and links]
> >
> > Thank you for the information!  i'll check those up.
>
>
> I hope to have an improved list on monday, sorted by priority of
> the developers I'm working with.
>
> I thought I do some coding, to find out a bit more about the
> stability of msysgit. So I started and added support for kdiff3
> on Windows (see patches in separate mail).

neat.The hardest part for me was to find out that I didn't have to
configure anything or add a command line option to get kdiff3 running.
(I cheated looking in the source, I think we should add #ifdef
__MINGW32__ / #endif around the registry reading part.

Good job!




> I'm impressed. Pretty much everything I tried today worked for
> me. After I got git gui running, and learned how to avoid pitfalls
> of git submodule, development went smoothly. I pushed and pulled a
> bit from linux and mac and did some coding. Thanks for the vim
> setup!
>
> I think you (and more people I don't yet know) did a great job
> with msysgit. I'd recommend it over cygwin's git, which caused
> some trouble for me.

Thanks. I'm as fresh as you in msysgit development but it is quite
straightforward. I've fiddled around with cygwin/msys before but now I
think we're on to something useful.


> > What do you include in the "make windist" installer and the "Windows
> > support" ?  Are you talking porcelain or plumbing?
>
> Hard to say. I believe now, from what I learned today, that the msysgit
> approach is quite reasonable: Grouping all needed unix tools around a
> submodule containing git. But the submodule should be git.git. I think
> this is what I'd expect. I like the idea of bringing everything needed
> along, and keeping it separate from the rest of the system. This avoids
> conflicts with, for example, cygwin.


> I don't think I would expect much more for a basic setup. All tests
> should run, maybe some msysgit tests would be needed to test the
> pitfalls

I'm lacking several things. Many usability-glitches, some bugs, easy
access to documentation. Also we want to integrate the mingw git parts
into git.git so people can follow the official repo. etc..

> I didn't like the submodule problems I ran into and I still didn't find
> out how to push to the git mob branch.

This is weird. I haven't had such problems with this (dirty submodule
in working dir), but that probably is because the supermodule doesn't
depend on files in the submodule [submodule "make install" copies
files to the supermodule]. Otherwise we should be more dependent on a
clean submodule state.  I would though expect a "git reset --hard" to
fix up the submodule for me.


> [ many proposals for future work with msysgit]

Yeah. there's plenty of stuff to do. You could add this stuff to the
issue tracker Dimitry has initiated.

//Torgil
