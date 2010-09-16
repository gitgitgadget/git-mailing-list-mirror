From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Thu, 16 Sep 2010 18:48:03 +0200
Message-ID: <20100916184803.39576fd2@jk.gs>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de>
 <20100916125751.163d8691@jk.gs>
 <4C9204BE.800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	avarab@gmail.com, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 18:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwHdB-0003Js-M9
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 18:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab0IPQsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 12:48:10 -0400
Received: from zoidberg.org ([88.198.6.61]:51742 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab0IPQsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 12:48:09 -0400
Received: from jk.gs (xdsl-89-0-18-135.netcologne.de [::ffff:89.0.18.135])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 16 Sep 2010 18:48:06 +0200
  id 004001DB.4C924A46.00000F8C
In-Reply-To: <4C9204BE.800@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156342>

Michael J Gruber <git@drmicha.warpmail.net> wrote:

> > Translating these terms into German does not change anything about
> > that. All terms still need to be explained.
>=20
> Absolutely true, and absolutely irrelevant for the decision whether t=
o
> translate these, since they need to be explained in any case.

The argument for translating them in the first place was that that
makes it easier to understand the text. My argument was that the
translated terms are not more understandable because they still need to
be explained. How is that irrelevant? I consider the original argument
refuted, and unless you have a different argument for translating them,
I will continue to translate terms only if I find a reasonable
equivalent in German.

> The aim of a good translation is to reproduce the concept, not the
> word. I assume we're talking about a (mostly) non-English speaking
> target audience here, and for them associating meaning with terms in
> their native language is certainly easier.

I have not seen a whole lot of good translations, though. Most of them
don't represent the original concept nearly as well as the original
word. Most of the time the metaphorical expressiveness is worlds apart.

> >> I'd go for "Zweig". It's even on the wikipedia page and it
> >> perfectly represents the concept.
> >=20
> > My main reason for not translating this one is that we have a
> > command called "branch" and since people need to learn what it
> > means anyway, and we're certainly not going to change the command
> > names in different languages, translating the term in other uses
> > just means that German users have to remember two different words
> > for the same thing. Similar reasoning applies to some other terms.
>=20
> I really have to oppose this reasoning. Are you seriously suggesting
> we should not translate the following words as a matter of principle?

I would indeed keep quite a few of them as they are. But you're
right, the fact that they would likely be kept as command names just
makes me feel better about keeping them untranslated; the main reason
is that I can't find good translations. Let's step through them one
by one, against my better judgement.

> add

This one is straightforward enough, I have to admit. "Hinzuf=C3=BCgen" =
is
exactly the concept we're looking for here.

> am (OK, I'm kidding here)

"pa" f=C3=BCr "Postfach anwenden"? ;)

> apply

I believe that "anwenden" is indeed frequently used in this context.

> archive

There exists an exactly equivalent word in German, so that's wonderful.

> bisect

This will be translated to "halbieren" over my cold, dead body.

> blame

Can't think of anything right now, but my intuition says that this can
be translated gracefully; perhaps not in one word, but who cares.

> branch

I actually think that "Zweig" is not a perfect translation here.
"Zweig" is commonly used in the context of describing trees. The git
history is not in tree form, though. Instead, I think the concept of a
branch in the road is a better fit; it's natural for a road to branch
off and later rejoin whatever road it branched off of. A translation of
that might be "Abzweig", but I would prefer a word that doesn't
currently sound stilted.

> bundle

I'd argue that the word "Bundle" is already used in German technical
lingo.

> cat (...)

Those (and some others in your list) tend to be plumbing commands. I
don't think we need to think about them quite as hard as about
porcelain.

> checkout

There is no good equivalent in German (that I know of). Actually the
original term is not very good in the first place. It seems to be using
borrowing "checkout" in the sense as used in, for example, a library.

(Actually, "auschecken" exists (listed in my dictionary of choice, at
least) and is probably close enough...)

> cherry(-pick)

This is a tricky one. "Pfl=C3=BCcken" is certainly not an ideal transla=
tion;
"herauspicken" is closer but a bit awkward to integrate into a sentence=
=2E

> clean

Straightforward translation: "aufr=C3=A4umen".

> clone

German equivalent exists: "klonen/Klon".

> commit

This is about the most complicated term there is. This word unites so
many meanings it's not even funny. The most relevant ones which I
see reflected in git are:

- commit to memory
- commit to a decision
- commit someone to a mental institution (and aren't there enough
  commits where you feel a bit like that?)
- commit a crime

Note that I'm just using these as examples of what "commit" can mean,
and I see all of these meanings reflected in git's usage in one way or
another.

Now try and find a German word that has the same kind of overall
meaning. I'll wait.

Another important reason why I really wouldn't change this one
("Commit/committen") is that it's widely used like that in German
already. By introducing new users to some kind of Germanized metaphor,
you end up creating a communication barrier between existing experts
and new users. I think that should be avoided at all costs.

This is also the reason why I oppose the argument that a translation
should exclusively cater to new users who don't speak English. I
believe that the meaning of translation should at least be easily
apparent to existing German users. The example "Bereitstellung (zum
Eintragen)" that I already gave from git-gui shows how not to do that.
It took me at least a minute to figure out what that meant.

People who don't share my point of view have not responded to this
argument so far, but I believe that it's crucially important.

> config
> count
> describe

Straightforward.

> daemon

I wouldn't translate this one. It's a crafted word; there's no reason
to replace it with a non-crafted word in German. Also it's commonly
used by German UNIX experts anyway.

> diff

The whole point of this word is to be short. It's close enough to the
German "Differenz" that I would keep it, even as a verb ("diffen").
Again, this form is crafted anyway.

(No, it's not okay to call it "differenzieren". You'll drive math folks
to homicide if you do that. ;))

> fetch

I already translated this one.

> filter

The German word is the same.

> format

Again, this is difficult. In prose I would just call it "Patch
erstellen".

> grep

Another crafted word. I'd keep it. Any UNIX user will know it anyway.

> gui

Nobody ever translates this acronym.

> hash

"Hash" is a widely used technical term in German.

> help
> index
> init

Straightforward.

> log

"Protokoll" seems a bit cumbersome but is close enough to the original
concept.

> lost

I'm beginning to figure out how you generated this list...

> merge

Again, there is no real equivalent in German. I would be all in favour
of going with a more elaborate translation if that wouldn't make
certain things extremely convoluted ("Zusammenf=C3=BChrungscommit"?).

> name

Did you even read this part of your mail? ;)

> notes

Straightforward.

> pack

Less so. Used as a noun, most straightforward translations will clash
with "archive" or "repository" or whatever. "Paket" clashes with its
usual meaning of "packet", especially in contexts like "receive pack".

I would really like to translate this one (it seems like it shouldn't
be too hard), but I don't have any decent ideas.

> patch

Customarily used in German.

> pull

Another tricky one. I haven't quite decided yet whether "ziehen" is an
accurate translation. I'd probably try to cheat by rephrasing sentences
that use this word.

> push

Same thing.

> rebase

Tricky. This is another crafted word. I believe the best chance of
doing it justice would be in crafting a word with a German base that's
very similar to this. Lacking of a good solution, I'd keep the original
word.

> reflog

Another crafted one. Developers tend to know the term "log", so I'd
keep this one, especially since it'll be hard to find something else
that can be shortened this much.

> remote

I haven't translated this one yet. I guess it would map nicely to
"extern", though then we'd lose the noun meaning of the original.

> reset

Straightforward, though "reset" doesn't really describe very well what
it does in the first place.

> revert

Literally translating this one out of the dictionary will end up being
incorrect. "Zur=C3=BCcknehmen" would be closer.

> rev

Christian's "Versionsangabe" seems like a good fit.

> show

Straightforward.

> stage

I translated this to "vormerken".

> stash

Tricky. Since some of the original git lingo is fairly casual, though,
I might go with "bunkern". And if anyone complains about connotations
of war, I'll scream.

> status

Used in German.

> submodule

I certainly don't have any good idea here.

> We simply need a principle we can follow, which produces readable
> text, and which helps those in need of a translation. Those with a
> reasonable passive understanding of English don't need a translation
> at all. Some suggestions to follow:
>=20
> - Identify term categories which are already in use in the English
> version, such as "combinatorial graphs".

We usually use only a very small part of each taxonomy (see, for
example, the word "branch" which is *not* used by us as it is in graph
theory), so this doesn't help as much as it might seem. I agree that
reusing well-established translated taxonomies is a good thing, though.

> - Translate concepts, not words. If there are several choices, favour
> the one which is linguistically close to the English Git glossary.

I agree with this too, as long as it's done *well*. That includes
setting a "maximum distance" between the original and the translations.
A rough fit (e.g. commit <-> eintragen, stage <-> bereitstellen and
many others) should be rejected as not really making things better.

> > I believe that the English "tag" is a much better metaphor than the
> > German "Markierung". One use of "tag" refers to a small label that
> > is attached to, for example, baggage. This is exactly the concept
> > we have in git. "Markierung" doesn't come close at all to
> > describing the same concept. Conflicts markers are "Markierungen";
> > tags are not.
>=20
> That's exactly why I suggested "Marke", see my earlier reply also for
> the other terms. It conveys the same multiple metaphorical
> associations.

I disagree. Arguably, the strongest association is
"Briefmarke" (postage stamp), probably followed by
"Erkennungsmarke/Markenzeichen" (trademark) and perhaps
"Plakette" (insignia). None of these reflect what a "tag" is about:
(more or less) loosely attaching an identifier to a revision, as in the
case of a baggage tag or a dog tag. What's more, the word "Tag" is
already widely used in German version control lingo. For example, the
German translation of the SVN red book uses it.

> You know, there's a reason why translating is a profession. You need
> to be proficient in both languages, as well as creative. In fact, I
> don't think the majority of people are proficient enough for that
> even in their native language (as a translation target), but every
> native speaker thinks he or she is, of course. (This is a general
> remark not aimed at anyone specifically.)

The whole profession argument has never sat well with me. I know
hobbyists who have ten times the skills of some professionals. I agree
that translating is a nontrivial task, though... and I, personally,
will not be involved in anything less than a very good translation. I
have outlined what I perceive as shortcomings in a number of
suggestions made here. I'll be glad to look at alternative suggestions,
but so far, for a number of terms, I haven't seen a satisfactory
alternative to adopting the English ones.

(FWIW, I've bounced some of the more controversial of my translations
off a couple of git users, but also off a graduate of German language
and literature studies who uses neither git nor English. I'm just
mentioning that due to your totally-not-aimed-at-anyone remark, though;
I don't think it should actually make any difference.)

At any rate, I will stop working on translating git as long as this
discussion goes on. And, of course, should you guys end up insisting on
bad translations, I'll leave you to writing it that way. Under
protest. :)

-Jan
