From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: ghost refs
Date: Thu, 8 Apr 2010 18:14:13 -0400
Message-ID: <p2w32541b131004081514s5a9e36b5uff79453c2f6b359e@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com> 
	<89030B4A18ECCD45978A3A6B639D1F24032A0750BE@FL01EXMB01.trad.tradestation.com> 
	<k2p32541b131004071503g4ce66e5bjac8270b10790a2af@mail.gmail.com> 
	<89030B4A18ECCD45978A3A6B639D1F24032A0750CC@FL01EXMB01.trad.tradestation.com> 
	<k2x32541b131004071511i9bbe883az504547d6133aef@mail.gmail.com> 
	<20100408043059.GA28768@coredump.intra.peff.net> <89030B4A18ECCD45978A3A6B639D1F24032A075390@FL01EXMB01.trad.tradestation.com> 
	<7vwrwh6fz8.fsf@alter.siamese.dyndns.org> <20100408194908.GB4222@sigill.intra.peff.net> 
	<7vbpdt65ie.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@tradestation.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 00:14:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzzzk-0004rJ-EI
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 00:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759028Ab0DHWOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 18:14:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37226 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286Ab0DHWOe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 18:14:34 -0400
Received: by gwb19 with SMTP id 19so1417569gwb.19
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=H1kug1z3mNqrj/fzqnb6gfyRBDOMsP/bh0JKbIniBmI=;
        b=fs7sKZm9MmH2jVSIdXFWLVwDIx46qKyuyJsYimSpWrd8yZK+oyM3r/73nPrlNQpZhq
         dcoSp0EPT7TOJ8/C/9jFQr65a3OoiY3qGC7N3WLTm2Tx53Essfo/2ykBbwFuU/lczlMo
         2r/9URf4lYM5vVHmtQnt3F0sj2Tt/nYoPGWSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z3Dqh7wbuHFzDHqRjIn16iqw6whpnIJM1OgYJ+tc5lfEuL5Xg462yu21btrSKVz+Pl
         vUTSKw0Fsh8y0OJ8w0l+pUjrjcBwMp9qxA99KN6Rkqg5iC2iytdY077aoqaoB7u86kCp
         bdRXqGfq7LVcBqQTmC0oSIwIkXPFl6gfl+6+o=
Received: by 10.150.150.20 with HTTP; Thu, 8 Apr 2010 15:14:13 -0700 (PDT)
In-Reply-To: <7vbpdt65ie.fsf@alter.siamese.dyndns.org>
Received: by 10.150.183.15 with SMTP id g15mr799443ybf.210.1270764873197; Thu, 
	08 Apr 2010 15:14:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144385>

On Thu, Apr 8, 2010 at 4:42 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> That certainly is an improvement, but I've been wondering if it makes
> sense to also have a section in each commands the configuration varia=
bles
> that affects the behaviour of the command. =A0core.logallrefupdates s=
urely
> is not the only variable that affects how "git branch" behaves.

I agree that you bring up a good point here.  I just hope you don't
lose Jeff's (useful and improving) patch during the ensuing discussion
:)

> We might want to have a general concensus on what we want to have in =
the
> documentation. =A0As you noted, some have too sparse SYNOPSIS, while =
others
> have full list of options. =A0Some mention configuration variables, w=
hile
> others don't. =A0Some have extensive examples, while others lack any.

The length of the synopsis section doesn't affect me much.  Mentioning
the equivalent config variable next to a command-line option, where
one exists, would probably be nice.

It might be okay to not actually describe in each manpage how the
relevant config options work; just referring people to git-config is
probably okay.  Having them all in git-config is useful in itself.

As for examples, well, people seem to really love examples.  So if
someone sends a patch to add more examples, I'm hoping there's no
reason to turn them down. :)

> SYNOPSIS::
>
> I prefer to have (almost) complete set of options in SYNOPSIS, rather=
 than
> "command [<options>] <args>..." which is next to useless. =A0This is
> especially true for commands whose one set of options is incompatible=
 with
> other set of options and arguments (e.g. there is no place for "-b" t=
o
> "checkout" that checks out paths out of the index or a tree-ish).

I almost agree with you, except that nowadays there are *so* many
options that it doesn't really help much to have them all listed up
there.  It might be better to list only the most common ones.

When the same command has multiple modes, I agree that it makes sense
to list multiple synopses.

> I also prefer not to list "purely for backward compatibility" options=
 in
> SYNOPSIS section.

Sure.

> OPTIONS::
>
> List of full options. =A0Some existing pages list them alphabetically=
, while
> others list them in functional groups. =A0I prefer the latter which t=
ends to
> make the page more concise, and is more suited for people who got use=
d to
> the system (and remember, nobody stays to be a newbie forever, and pe=
ople
> who stay to be newbies forever are not our primary audience).

I actually get mildly annoyed when man pages don't list the options in
alphabetical order, because I naturally start looking for them in that
order.  But I can just as easily do a search for the option, so that's
probably just me being pointless.  In contrast, my pager can't help me
sort out the options by functional group, so that's probably a more
useful way to do it.

That said, I don't think consistency here is much benefit.  It's okay
if for some pages, functional groups aren't needed so alphabetical
order is used as a fallback.

> Detailed discussion of concepts::
>
> Some manual pages need to have discussion of basic concepts that woul=
d not
> be a good fit for the DESCRIPTION section (e.g. "Detached HEAD" secti=
on in
> "checkout" manual). =A0I am not sure if this kind of material is bett=
er
> given in OPTIONS section close to the functional group (e.g. "History
> Siimplification" heading in "log" manual).

I think some pages have a DISCUSSION section right at the bottom,
after the description, options, and examples.  This seems like a good
way to do it.  man pages should have concise stuff so you can find the
information quickly, but there's nothing wrong with having detailed
stuff further down.

> EXAMPLES::
>
> I prefer to make it mandatory for Porcelain command manual pages to h=
ave a
> list of often used patterns that a reasonably intelligent person can =
guess
> how to tweak to match the particular situation s/he is in.

To be honest, I've often wished that the plumbing pages would also
have such detailed examples. :)

Which reminds me, it would be really great if somehow each command's
manual would describe a) whether it's plumbing or porcelain, and b)
the alternative to look for if what you *need* is plumbing or
porcelain and the command is the wrong one.  But I don't know what a
good format for this information would be.

> AUTHOR/DOCUMENTAITON::
>
> These sections in most pages are not kept up to date, and I prefer to
> remove them altogether. =A0They do not help end users who never clone
> git.git, and those who clone git.git will have shortlog to give them =
more
> accurate information.

I might be just being silly, but I really like seeing the Author
sections, even though I know they're usually obsolete and/or wrong.
It just makes git seem more human somehow, like real people were
involved in writing it.  I'm sure it results in Linus getting a bit
more credit than he deserves (it seems like the vast majority of man
pages name Linus as the/an author) but it's pleasant and seemingly
harmless.

Have fun,

Avery
