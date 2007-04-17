From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 20:12:27 +0100
Message-ID: <200704172012.31280.andyparkins@gmail.com>
References: <200704171041.46176.andyparkins@gmail.com> <200704171803.58940.andyparkins@gmail.com> <Pine.LNX.4.64.0704171107510.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 21:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdt6i-00065m-Tg
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 21:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030856AbXDQTMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030866AbXDQTMt
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 15:12:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:41065 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030856AbXDQTMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 15:12:48 -0400
Received: by ug-out-1314.google.com with SMTP id 44so248312uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 12:12:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U74W56PTs/KKqxwgNb5GUetuocfECXOycRHhhg601xacfTlu6emRbXHycDrOj3DnvAUiLI/BU6EFHcLaixZgFklngH6pOPhcwNTEEbaIBpe+VbrD80RdZeVs5/s8CwBsY5BFjWxWbTr9SskWhvjbX8KzDXKZTHGGbJY++tv4H/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=p5WgP6v0vR0K8efQYGHnXCjvdUbjp75gEa4ZfX3AIfRVXbGElqZ4w1uQSpWD+K94+8shGqVG9kKZTTJi4ZNcqbgEaZ8EifqvF2pWACXeex05I07wOqdnff2foBrc8WmXuJ5I5gAdKt1IwJaClHcvHzyAHpfEjFmzptcQPCmtZto=
Received: by 10.67.93.6 with SMTP id v6mr699400ugl.1176837166379;
        Tue, 17 Apr 2007 12:12:46 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 24sm1548161ugf.2007.04.17.12.12.43;
        Tue, 17 Apr 2007 12:12:44 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704171107510.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44810>

On Tuesday 2007, April 17, Linus Torvalds wrote:

> So you will never work with anybody outside of git?

For my projects - correct; I don't care about the rest of the world.  
For projects that do - don't enable keywords, it's an option, all I 
want is to have that option.

> What about tar-files when you export the tree? Should they have the
> expanded version?

If I have to pick one then: no.  I think out-of-tree keywords are too 
much trouble for exactly the reasons you say; however, I wouldn't like 
to presume what other people think is too much trouble so I suppose it 
would have to be an option.

> > You keep saying these sweepingly general things.  It can be made to
> > work.
>
> No, it CANNOT.
>
> Trust me. There's NO WAY IN HELL it will "work" in any other sense
> than "limp along and not be usable".

Well I'm making progress, "limp along" is a significant step up from 
impossible.  :-)

Look, my primary objection to this is the SHOUTING about how impossible 
it is even though I've tried to address every problem you've thrown at 
me - I'm finding it really difficult to figure out why you're trying so 
hard to dissuade me from even _trying_.  If it all goes wrong (as I 
fully accept it might), so be it, I can live with that; I'll even be 
happy to tell you you're right and I'm wrong.  Why is this such a 
problem?

Keywords are so hated by everyone that I doubt they would ever be 
accepted into git - it's an intellectual exercise for me at this stage 
really. 

> Yes, you can make it "work" if you:
>
>  - make sure that you never _ever_ leave the git environment

As it happens, _I_ never ever leave the git environment.  Can I use 
keywords then?

You don't seem to have such a problem with git's extended diffs for 
renames or subprojects - "make sure that you never _ever_ leave the git 
environment".

>    But why do you want keyword expansion then? The whole point is if
> you have other tools than the git tools that look at a file. Even
> your svg example was literally about having non-git tools work with
> the data. What if you ever email the file to somebody else?

If by "tools" you mean other version control systems, then I don't 
intend them to work.  If by "tools" you mean gcc, inkscape, gv, bash, 
web browsers or any other fileformat that allows comments in the file 
then I expect it to be fine.  If I publish a web page, it'd be nice to 
show the ID on the page - that's all just "nice" not "necessary" 
or "I'm throwing git away if I don't get it".

Emailing to others isn't a problem either: let's say I email them my SVG 
(with keywords expanded), they make some edits and send it me back - 
worse, they send me a diff back.  I'm going to apply that diff using 
git-apply; which will collapse the keywords and apply the diff.

>  - you make all git tools explicitly always strip them.

Well, not "all", so far I've added one call to convert_to_git() in 
builtin-apply.c - it was a one line addition.  It needed doing anyway 
to deal with the CRLF correctly.  I can't see there being that many 
places that this needs doing.  I may well be wrong, if I end up 
scattering calls to convert_to_git() everywhere I'll give up.

>    Again, what's the point again? You add keyword expansion, and then
> the only tools that you really allow to touch it (except your "print
> it out" example) will have to remove the keyword expansion just to
> work.

(I don't see why my tiny "print it out" example isn't enough - it 
matters to me)

However, most tools don't care about the keywords, it's only non-git 
diff and non-git patch that are affected.  As long as the file format 
supports comments, then keyword expansion will be just fine.

> That's not "work". That's just stupid. Yes, you can make your "print
> it out" example work, but as alreadyt mentioned, you could have done
> that some other way, with a simple makefile rule, quite independently
> (and much better) than the SCM ever did.

That's just being obtuse - no other tool cares in the slightest about 
the keywords, there are more "tools" in the world than just the VCS.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
