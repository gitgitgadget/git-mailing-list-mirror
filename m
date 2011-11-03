From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 2 Nov 2011 19:14:26 -0700
Message-ID: <CAJo=hJsXvSyB65KBp8sfciT=h5uZSqSUdxkpWtZJRtr4hXAh5A@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com> <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Thu Nov 03 03:14:56 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLmpT-0004wV-FZ
	for lnx-linux-ide@lo.gmane.org; Thu, 03 Nov 2011 03:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062Ab1KCCOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Wed, 2 Nov 2011 22:14:52 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60028 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049Ab1KCCOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2011 22:14:50 -0400
Received: by ggnb2 with SMTP id b2so804441ggn.19
        for <multiple recipients>; Wed, 02 Nov 2011 19:14:49 -0700 (PDT)
Received: by 10.147.154.20 with SMTP id g20mr1692253yao.15.1320286489671; Wed,
 02 Nov 2011 19:14:49 -0700 (PDT)
Received: by 10.147.167.9 with HTTP; Wed, 2 Nov 2011 19:14:26 -0700 (PDT)
In-Reply-To: <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184693>

On Wed, Nov 2, 2011 at 18:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Nov 2, 2011 at 6:19 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'm not saying that you shouldn't use them - go ahead and use the
>> feature if you like it. But please spare me your excuses for stupid
>> workarounds that come from the fact that they aren't a good match fo=
r
>> sane workflows.

We often disagree. :-)

> Btw, having now done odd things with signed tags (because we've used
> them as a side-band verification mechanism), I can certainly also say
> that the signed tags have their set of problems too.
=2E..
> But practically, all of these issues should be pretty easily solvable=
=2E
> So it should be quite easy to make
>
> =A0 =A0git pull <repo> <tag-name>
>
> just do the right thing - including verifying the tag, and adding the
> information in the tag into the merge commit message.

Uhm, sure.

Quoting you 2 days ago:

On Mon, Oct 31, 2011 at 15:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Oct 31, 2011 at 3:44 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>
>> So nobody is worried about this (quoting from my earlier message)?
>
> No, because you haven't been reading what we write.
>
> The tag is useless.
>
> The information *in* the tag is not. But it shouldn't be saved in the
> tag (or note, or whatever). Because that's just an annoying place for
> it to be, with no upside.
>
> Save it in the commit we generate. BAM! Useful, readable, permanent,
> and independently verifiable.

So you propose we put the tag contents into the merge commit message
so it can be verified after the fact? So merges are now going to be
something much more horrific to read, because it will end with Git
object tag cruft, the tag message, and the PGP signature spew that no
human can decode in the head?

Oh, right, tags are almost good enough. Elsewhere in this thread you
also stated we have to redo the way tags are signed so that the tag
message body itself is not part of the signature, allowing you to fix
spelin errors so you are not stuck with them in your commit history.
But I assume we will have to keep the more typical headers of object /
type / tag / tagger fields, as that is the key information the
signature needs to be over to be of any value. So now there will be
two different ways in which a Git annotated tag object will have its
signature created, as certainly you don't mean to remove the tag
message body from the PGP signature content for release tags.

I fail to see how shoving Git object data fields and a complete PGP
signature block into a merge commit message body, which will show by
default in all git log type tools, and exist in cherry-picks or
rebases that might make that data less valuable, is somehow better
than the gpgsig header that neatly tucks it away until requested. I
also fail to see how scraping the message body for the proper fields
in order to implement automated verification of the signature (because
no human can do it themselves and copy-paste sucks) is a good idea.
Everywhere else in Git that we have machine readable formats its very
well structured so that no guessing is required.

> So signed tags are not mis-designed from a conceptual standpoint -
> they just work really really awkwardly right now for what the kernel
> would like to do with them.
>
> With a few UI fixes, I think the signed tag thing would "just work".

Well, UI fixes, protocol changes, improvements to manage a large
reference space which we have previously said is an insane and stupid
workflow, etc. One reason you picked up all of those extra tags was
the include-tag capability kicking on and picking up older tag
history. We now have to disable it in certain cases.

Its not just a few UI fixes. And there is a lot more work to write a
verify for the tag contents+signature that appears in the body of a
merge commit message. Not to mention we now have to do that verify
logic twice, once in the signed pull request tag like but not quite a
tag but uses a tag thing you are advocating, and again for the merge
commit message body that contains the tag object data that we don't
normally show to an end user, but will now be in every merge commit
you make.

Go ahead and call me stupid, but this already is a bigger amount of
surgery to the git-core code, not to mention worse user experience for
the average `git log` reading human, than having a hidden by default
gpgsig header that might ask a contributor to take 2 extra seconds
before making a commit to consider the useful lifespan of that commit.
Or $DEITY forbid, write a new empty commit to record the equivalent of
their Signed-off-by.

Oh, and while I am on that subject...


<rant>
I have never grasped why sometimes a Signed-off-by is added to a
patch, and why sometimes its not. It seems to be this weird function
of "If the commit SHA-1 is already stable DON'T FUCKING TOUCH IT BY
ADDING SIGNED-OFF-BY IT RUINS THE HISTORY", but if you are too far
down the food chain to be fortunate enough for your commit SHA-1 to
remain frozen, the Signed-off-by has to be added to assert that the
code can be contributed. It sounds like the workflow developed around
where it wasn't acceptable to force history rewriting, you suffer by
not having the SOB, but whenever possible you force a history rewrite
on the contributor just so you can add a SOB and feel good about the
fact that the SOB is added to the commit message.

Get over it. Add the fucking empty commit to show the flow of a
change. Stop forcing every fucking contributor to rebase/rewrite his
commits just so someone higher up in the food chain can wank with
their SOB line.

Everyone I talk to that contributes code to the kernel who isn't Linus
or Ted Tso complains about this, and then asks me to fucking fix it.
They want stable SHA-1s so they know their change arrived into Linus'
tree unmolested. Unfortunately, despite their volume of changes, they
aren't high enough in the food chain to be this lucky. Nope, someone
has to wank their SOB in first. And maybe fix a spelin error.
</rant>
