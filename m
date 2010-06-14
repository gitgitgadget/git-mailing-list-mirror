From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH v2] Group the default git help message by topic
Date: Mon, 14 Jun 2010 08:31:55 -0700
Message-ID: <AANLkTimFUGkYeZaXA7BqX8ghsHX_gGYRK69ScHMXbw2l@mail.gmail.com>
References: <AANLkTiloErvcWS1hW80cIV9SiWu_7CBdNSx_iAppcGOd@mail.gmail.com>
	<7vbpbeazy5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 17:32:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOBdy-0004Ky-El
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 17:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab0FNPcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 11:32:04 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44580 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0FNPb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 11:31:57 -0400
Received: by wyb40 with SMTP id 40so3968473wyb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u2+QzZoaYXobo8ORC9i/qNJmYI0La2YQCOowVkcWkfw=;
        b=RX7McW1LkpDS7KmFSq81zmciTlNRKApXC9cG+hjcL+gbv4O3snqA458Xo236clJ5e5
         MVHlkloziIFwJbuLPhLKe+P9XXOGFnLtAfY/dp/W9VCX8xvqsMM+72F2cOvAo342EMSs
         eFJnwcV4lFzbpizRHiKgkGtRf1UR/eM94Ia+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PM0qtiSmU8RvOm+vr3uMvI4D76fxxbjAzgwF7OuzUBNBUq5HPvYvtrfHDuXfM0sdxg
         nv+4uBZ8tlIX7pH0cUGt4R4IE34DupM5/cFe4jrxjQO23Nm/zQXQdFawE+KZlgxKVKJC
         DK48wsfyUHscN9WC3S1YFzXW4XmmRunul9Mdc=
Received: by 10.216.88.21 with SMTP id z21mr2452240wee.100.1276529515912; Mon, 
	14 Jun 2010 08:31:55 -0700 (PDT)
Received: by 10.216.23.71 with HTTP; Mon, 14 Jun 2010 08:31:55 -0700 (PDT)
In-Reply-To: <7vbpbeazy5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149100>

Hey,

On Sun, Jun 13, 2010 at 11:30 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> I am lazy, and I loathe having to maintain another hardcoded table (l=
et
> alone sequence of print_command() calls, like this patch does, yuck).
>

Sorry, but it seemed to me this would have to be separately maintained
anyhow, plus it doesn't change much.  How often are basic commands
going to be added or removed?  Also, it may not be that pretty, but
it's undeniably clear.

> The two words, "21" and "group", in your proposed commit log message =
have
> been nagging me for a while, and I finally figured out why this patch=
 made
> me feel very disturbed. =C2=A0We already have a perfect source to gen=
erate the
> necessary most commonly used command list with a good grouping hint, =
but
> the patch does not make use of it.

The only issue I would have with this statement is the word 'perfect'.

To disambiguate what we're talking about here, this is the output that
is generated from this new patch:

Some commonly used git commands per developer roles are:
 * Individual Developer (Standalone)
   init          Create an empty git repository or reinitialize an exis=
ting one
   show-branch   Show branches and their commits
   log           Show commit logs
   checkout      Checkout a branch or paths to the working tree
   add           Add file contents to the index
   diff          Show changes between commits, commit and working tree,=
 etc
   commit        Record changes to the repository
   reset         Reset current HEAD to the specified state
   merge         Join two or more development histories together
   rebase        Forward-port local commits to the updated upstream hea=
d
   tag           Create, list, delete or verify a tag object signed wit=
h GPG
 * Individual Developer (Participant)
   clone         Clone a repository into a new directory
   pull          Fetch from and merge with another repository or a loca=
l branch
   push          Update remote refs along with associated objects
   format-patch  Prepare patches for e-mail submission
 * Integrator
   am            Apply a series of patches from a mailbox
   revert        Revert an existing commit
 * Repository Administration
   daemon        A really simple server for git repositories
   shell         Restricted login shell for GIT-only SSH access

Though the implementation of the solution is undeniably more elegant,
I have some serious issues with the output.  As you mention next,
'show-branches' is second in the list, which is an issue, but there
are several more.  'am', 'revert', 'daemon', 'shell', 'rebase' - none
of these are appropriate for someone running 'git' and trying to see
where to start.  If we put those aside, all we have is a big list of
commands again which adds almost no value to what we had before.

> If readers notice that there are some commands that are out of fashio=
n
> (e.g. I don't think many people use show-branch anymore in the presen=
ce of
> "log --oneline --graph" and friends) listed in the "git help" output,=
 that
> is a _good thing_. =C2=A0It will give us an incentive to keep the Eve=
ryday
> document up to date, and with the effort spent for that, "git help" w=
ill
> automatically be kept up to date as well for free ;-)

That's a fine goal, but I feel like it shouldn't be an "everyday"
document that generates that output, it should be a "beginner"
document or a "how to start using Git" document that isn't really in
the Git source.  I mean, I suppose we could write one with the goal of
using it to generate the help output, but given how much people
disagreed with even the basic grouping of the first patch I sent, I
can't see how we're going to agree on a new help doc.  Perhaps we
should decide on what we would ultimately like the basic help output
to look like and then I can craft a document that would produce it
given this patch and then the list can rip it apart until it's
basically acceptable.

Thoughts?

Scott
