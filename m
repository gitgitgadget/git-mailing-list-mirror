From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 18:32:18 -0400
Message-ID: <AANLkTimSoe9iqu4cJCH1d4rVsWHpFn3+8pbrCxsnVM1D@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B0E9.1090300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:32:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcQnP-0001Ez-73
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab0GWWcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 18:32:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58013 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab0GWWck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 18:32:40 -0400
Received: by wyf19 with SMTP id 19so686541wyf.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MIjIMP6JKx0WG3BNhm++Bt5Oa6dLZfocZIDcZKsOPqQ=;
        b=KfUsPZiKBV5drStJ5fFLR2QrDQannWCFNe6NiCjR9UFsM3Pi/9Yg0ySXf11v6XJJ+g
         cJMz5hr7m8sWBcXyt8DfVsxGenJkyw7xMpqUkab5qfufV8eOSadCO/6Iu9Ftq2Ly+x2Z
         ETE9r6TC9PMJV4g7U81jcLS17cyPdXi25JhBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vdPvnU3H7uP5bflKlEdLRzVsy0QTFxvTqkUNq/sO+urV+Ehu9/VFSbafLOxayY6hSL
         TyQ3OHsbropadZVwhcJglBaYNm5i2GhgUcCP113chzo0KM18ulPxXCh8LdLNNnmKf0sA
         gAm5TCM7eeVagPYmDAH26sxQtWKJWkmzREq5M=
Received: by 10.216.187.143 with SMTP id y15mr4148740wem.74.1279924359027; 
	Fri, 23 Jul 2010 15:32:39 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Fri, 23 Jul 2010 15:32:18 -0700 (PDT)
In-Reply-To: <4C49B0E9.1090300@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151579>

On Fri, Jul 23, 2010 at 11:10 AM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
> You forgot what we do as best practice at work:
>
> [3] Fork the gem repos on github (or another server reachable by your
> =A0 =A0co-workers) and use those, so you don't have to change the URL
> =A0 =A0later:
>
> =A0 =A0git://github.com/apenwarrrubygems/gem[1..n]
>
> Your problems go away, setup has to be done only once on project
> start and not for every developer, you can use your own branchnames
> and you have a staging repo from where you can push patches upstream
> if necessary.

Now all your fellow developers have to push their submodule code to a
single upstream repo?  That's rather centralized and un-git-like.

=46or the rest, Brian Larsen answered this one well, and I agree with h=
im.

>> Surely including *repository URLs* inside the *repository content* i=
s
>> at least as bad as including branch names. =A0If we're going to do o=
ne,
>> we might as well do the other. =A0But it won't help, because the sto=
red
>> branch name will probably be 'master', and my personal hacked-up cop=
y
>> of gem13 shouldn't be on a branch named master anyway.
>
> You sure are aware that having a branch name associated with a
> submodule checkout is a request repeatedly made?

Of course it is; I requested it myself.  Then, two years later after
thinking about the problem a lot and writing git-subtree out of
frustration, I realized that even if this feature existed, it wouldn't
help at all.

If you use git-submodule, you must push your submodule commits
separately or the supermodule is broken for everybody but you.  To
push a submodule, you need a) an upstream to push to and b) a branch
name.  It's easy to forget to create a branch name, so of course
people request that feature.

However, the real problem is "you must push your submodule commits
separately."  Fix that, and I can guarantee that the request for
submodule branch naming will disappear.

> That is just one example. Another one is code shared between
> different repos (think: libraries) where you want to make sure that
> a bugfix in the library made in project A will make it to the shared
> code repo and thus doesn't have to be fixed again by projects B to X.
> This was one of the reasons we preferred submodules over subtrees
> in our evaluation, because there is no incentive to push fixes inside
> the subtree back to its own repo like there is when using submodules.

I think you'd like svn; it's pretty cool.  All changes made to a
project need to get pushed to a central upstream repo so you never
forget to share them.

>>> rebase and merge needs separate =A0 =A0| rebase and merge works nor=
mally
>>> work in submodule currently =A0 =A0 =A0 =A0|
>>
>> True.
>
> Nope, there is a patch in pu doing
> that when it is a simple fast forward
> and giving you advice when both sides
> are already merged inside the submodule
> (CCed Heiko, because he is the author
> of that feature)

=46ast forwards are not merges, and pu is not now.

> It is the /commits/ that have to be
> done twice, once in the submodule and
> then in the superproject. (But that is
> not necessarily bad, imagine having git
> gui as a submodule: you would be
> automagically reminded that stuff for
> git gui should be sent somewhere else
> than to Junio).

Yup, I agree that requiring a separate commit to the submodule repo is
not a bad idea.  I always do this anyway even when using git-subtree,
because I'm thinking ahead to the day when I'll push my submodule
changes upstream and I want my commit message to make sense.  But
that's because I think ahead like that.  Having the tool force me to
do it would be harmless and help people avoid mistakes.

The syntax for it ought to be nice though.  I should be able to do:

    git commit -- path/to/submodule

And have it commit everything in the submodule tree as a new commit in
the submodule.  I don't want to have to think about cd'ing to
path/to/submodule just so I can commit the files I changed in there.

Have fun,

Avery
