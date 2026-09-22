Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA849B466
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102690; cv=none; b=UDAbY4j6el4uCztcuCw9+DcAoeD9kzKkDeiVVPIFf4tb1A0ixFevB14+hyuKGoOL9ZjtSZ7CxBpPm0Gmel1lYUnPsRW98Z/FmIfx0+Id0YK03SXS1A0fI7/1L9YaFG1/1MzyQBO+gVx89nDzwY8QLKrfbMKRXZ/yAf1JUHmQAF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102690; c=relaxed/simple;
	bh=tZUQB23QTa8WjNUE35BoqVBk/nvh0oTTyTleJ0gNT2o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XnHxnMZXSqscIQkUD/7cfW8vdIOA2+EYets0GoSoIUWXLYa5kGJDREMxrZX68O3+h+orE5b5cqjYbcxJuIrftHMxPb7KT9LQV8jmK2xCxcaAmNsjweY8claFYC7P265sgTcpMkR60YWHJByUKFxpaS7nqbDNfHO+kRiSARVeYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fxgBMQI/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fxgBMQI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790102682; x=1790707482;
	i=johannes.schindelin@gmx.de;
	bh=SEiDXPrKIca4sXtGY1oKavpIDjz4BDec28FThuu625Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fxgBMQI/sFEII2u6ZIxjVc/HS42xpWVFDAH4g8AXa15rxHF947y+KywA/WHkf9le
	 GHEoqsJoWIJQZpJE4hSb4OROr60tftnJbH8RbadE6/Xe8hyo8QXQr2EeAWVhEePe5
	 mDuJs7baayde+Fz1EQwTcnrn/RIfC7vj6Chh+2Nu1nlNRPyfU0HaZevqBVAFEaxxu
	 1uegbvUkT05xZu8MDRJrSLz0aFL22FX+EOIFDZxETqiYL8yxMcMjCcXZpsj0a7BNU
	 kjlVUZ2vIC5ktgK0Z8WNZ1jIEySOP+PAnoaKMvWfPBkpk+37oRLSYdV1xF+9u2l4H
	 2NagVd6/vZ8UHGW8nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1wfmIF3Ma2-014k2b; Tue, 22
 Sep 2026 20:44:41 +0200
Date: Tue, 22 Sep 2026 20:44:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
In-Reply-To: <xmqq4ifhgzvx.fsf@gitster.g>
Message-ID: <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:lwKsnnIA7Worerm0SQDUZVoG7X7bx+fx4DbQy5l7eCQfYCnUFFy
 7urar7/Y5caxWZf/T2/Ib2h49KrLFDzSxQu9Y+0WboaIbQa/jzPz9vY4cMUth7cr40CHP/u
 p+MRfUs4CgZPO0hUa5FLledj+Pe1fGIQ42HKH1d+820i7+JL97fFcwjXOURxapebckH8v3H
 VUUGRigiD1tcT/oZp832A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VaoL704JQzk=;hFI9q39rlkgty8KkF+zYMPFiAyq
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 22 Sep 2026, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Mon, 21 Sep 2026, Junio C Hamano wrote:
> >
> >> Git 2.56-rc1 has been tagged.  We may merge last-minute fixes before
> >> the final Git 2.56 release, but otherwise I do not expect any new
> >> feature topics to be ready before the final, so most of the
> >> in-flight topics will stay cooking in 'next' until then.  As
> >> discussed at the Git Contributors' Summit, the version after the
> >> upcoming Git 2.56 will be Git 2.98, scheduled near the end of this
> >> year.
> >
> > Would you say that the following is an accurate characterization of th=
e
> > timeline, so that people who need to plan dependent projects can rely =
on
> > it?
>=20
> My outline was deliberately limited up to end of this year as I am
> hesitant to say beyond that point before the meeting notes are made
> public.

I originally wrote this summary of the Git Contributor Summit only for my
own records, but since you hinted at wanting some meeting notes, figured
it might be interesting to other people, too. So here goes my distillation
of the breakout-sessions from this year's Contributors' Summit. Many of
these ideas still need discussion on the list; proposals below are not
project-wide decisions.

Security mailing list and process

The security list is seeing a large influx of outside reports, apparently
often AI-assisted or generated. Duplicates and reports outside Git's
security model consume triage time, while some patches have waited for
months. Waiting for an empty queue is not a workable release criterion: we
need to release the fixes we have, rather than hold them indefinitely
while more reports arrive. No fixed release cadence or guaranteed response
time was settled.

Documenting Git's security model would save repeated explanations of what
does and does not constitute a vulnerability. (Personal note, not
discussed at the Summit: Stolee had tried to start a conversation about
Git's security boundary a long time ago, but nobody replied. Maybe the AI
onslaught will provide enough motivation to get that discussion going.)
Moving non-security bugs to the public list more readily was also
encouraged. A timeout after which public discussion would be presumed OK
was proposed, but not agreed.

More company staffing would help, without turning this into an obligation
for volunteers. Paying for dedicated help was discussed, with onboarding
costs a concern. Using AI for triage or fixes raises confidentiality and
DCO questions of its own. (Personal note: There seemed to be some
sentiment in the room that contradicted the earlier agreed-on finding on
the mailing list that using AI for triaging and for investigating wasn't a
copyright concern and should therefore be considered permissible.)

The release bottleneck is not really tag automation. Merging and
backporting fixes, preparing advisories, and handling CVEs take work, and
too much of that knowledge lives in people's heads. Peff volunteered to
start a public discussion of the process and dig up existing resources.
(Personal note: I have done that merging, backporting, etc plenty of
times, and I don't think that it is the bottleneck, and I was rather
surprised to hear that it is complicated. Sure, there are the expected
merge conflicts when merging `maint-*` branches, and running -- and
fixing! -- CI on all of the tags in a private repository should go without
saying, but that's all craft of the trade. Rather, the indecision and lack
of engagement on the git-security mailing list is what I see as the
blocker. I'd happily volunteer to juggle those branch thickets if that was
truly the make-or-break issue here.)

Microsoft's release process reportedly needs about seven weeks. There were
no objections in the room to proceeding without waiting for that schedule.
(Personal note: That release process was misrepresented, which is
surprising, as I coordinated two or three Git for Windows security bugfix
releases _on the git-security list_ since the most recent Git security
bugfix release, it's always the same thing: release on a second Tuesday of
the month, three weeks before that the patches need to have settled,
everybody goes home with a dependable timeline. It's not really that big
of a deal. Testing patches, constructive feedback, these are the things
that are missing and therefore blocking the process. I sensed a lot of
finger-pointing in this discussion. I mean, I don't blame anybody for
avoiding security work: it is stressful and intense. The responsibility
for getting things wrong is enormous. I know that because I've done my
share of that, probably more than most in the Git project, and I will do
even more in the future. But when I don't have the time, or the energy, I
am aware that I, myself, am the bottleneck; I don't need to blame others.)

Git v3.0

The proposed target is spring 2027: v2.56 in September 2026, v2.98 in
December, then v2.99 and v3.0 next spring. The jump in version numbers is
intended to signal the approaching breaking changes. March and April were
both mentioned; the precise timing is not settled.

There was agreement on releasing v2.99.1 and v3.0 together, differing only
in the BREAKING_CHANGES (v3.0 switches them on). That keeps the transition
separate from another round of feature development. Nobody in the room
objected to Rust becoming mandatory in v3.0. (Personal note: probably
because Randall wasn't there, to say that NonStop support would be a
blocker and that Git please wait.) A v2.x LTS remains an open question,
with Gentoo mentioned as an interested party. (Personal note: I am still
advocating for an in-tree Long Term Support branch, and since Junio
indicated that he's less than eager to take care of that, I would love for
Patrick Steinhardt to be the "LTS lieutenant", I vaguely remember that he
said he'd do it if asked, and I trust his judgement, so I'd ask.)

SHA-256 support across the ecosystem had been a blocker. GitHub reported
experimental support, with general availability expected around November.
GitLab already had public, non-experimental support, and libgit2 supports
it, too. JGit remains a gap; Google was not planning to fund that work.

The SHA-1/SHA-256 interoperability work, including historical tags, was
reported to be implemented but not yet sent to the list. (Personal note: I
think that the room seriously "mis-underestimated" the real-world impact
of this. The code is not even on the Git mailing list, and the
ramifications of not having a robust plan how to deal with partial clones
or submodules or even signed tags strikes me as a dealbreaker. I would not
be surprised if the decision to enforce SHA-256 as default would have to
be revisited before v3.0, and possibly overturned.)

Documentation

Julia's work highlights the gap between documentation written by people
who know Git inside out and users who do not yet know what objects, the
index, or upstream mean. We need approachable learning material as well as
reference documentation. Both need work; keeping manpages concise does not
mean they cannot have better explanations and examples. (Personal note: I
am beyond excited that Julia, whose work I have always admired, got
interested in improving Git's documentation, which is in dear need of
being improved, mainly because it does not cater to the majority of Git
users out there who are unlikely to wander onto the Git mailing list,
ever. I just hope that old-timers who really do not need the documentation
nor understand the need of those who do need it show enough appreciation
for the fresh views and for Julia's understanding of the target audience.)

Discoverability matters, too. The website (https://git-scm.com/) needs
clearer entry points for learning Git, and existing guides are harder to
find than manpages. Missing subsection links are another improvement we
could make incrementally. (Personal note: Judging by the history of that
site, I do wonder whether the core Git contributors are interested in
helping this effort at all. For example, there are a growing number of PRs
suggesting to add new UIs to the growing list, but I gave up reviewing
them because I was the only one doing so.)

There was support for replacing outdated material and for merging useful
improvements, then iterating, rather than trying to perfect everything
before it lands. Bringing user feedback to the list without flooding it
remains a challenge.

The current funding covers only 100 hours split between two people.
Additional project and company funding was encouraged; brian, Emily, and
Mark offered to explore company support. (Personal note: I had tried, back
when GitHub still funded my team, to start something like that, without
any success. To the contrary, even Git for Windows and Git Credential
Manager got defunded.)

On the tooling side, using only Asciidoctor instead of maintaining both
AsciiDoc and Asciidoctor support was proposed as a possible Git v3.0
change. Distribution support and rendering differences need checking, with
doc-diff suggested for comparing the outputs. Patrick filed an issue
during the discussion. (Personal note: AFAIU the AsciiDoc spec is now
maintained by Asciidoctor, and I am aware already of one change that was
made to the spec without adapting AsciiDoc accordingly. So the entire
discussion might be quite moot already.)

Other ideas included richer diagrams for HTML while retaining text
versions for manpages, and privacy-respecting traffic measurements to help
prioritize documentation work. No diagram format was chosen, and caching
and AI scraping complicate getting useful traffic data. Mermaid was
proposed, and even GraphViz. (Personal note: I added support for Mermaid
diagrams to https://git-scm.com/, but it turned out to be too limited, so
I added GraphViz support. The support code for this is a bit of a beast,
having a wasm version of GraphViz for development, pre-rendering the
diagrams as SVG and as PDF during deployment of the site; it was quite a
bit of fun to implement all that.)

Outreachy sponsoring

The goal is to support three interns in the round starting in early
December, at $10,000 each. The corporate sponsorship previously provided
by GitLab and GitHub has dried up, leaving Git itself to pay. There are
company contacts to follow up with; Emily offered to ask Google's OSPO,
without high expectations. No new sponsorship commitments were made.
(Personal note: I don't think that these internships provide enough
publicity to give companies much of an incentive to fund this. Which I
find a bit of a shame, Outreachy in particular does a lot of important,
good work, and if I wasn't so constantly overworked, I would want to
mentor again; I always found it rewarding, even if I hold myself to a
quite high bar which is quite draining.)

A related point for Git Merge 2027: announcing the location early would
help Outreachy and GSoC interns plan attendance. No location was selected.

Pluggable object database

Patrick's pluggable object database is working, but it is not complete:
commit-graph and multi-pack-index integration are still outstanding, and a
repository extension is planned. (Personal note: It might be interesting
to see whether implementing a storage backend is easier in core Git or in
another Git-compatible implementation. JGit should be a natural target,
having originated within BigTable-sized constraints, i.e. a different
storage system, but funding seems to have dried up, there's not even
SHA-256 support, so JGit might not be as hackable as it once was.)

Content-defined chunking prompted an important distinction between
changing how objects are stored and changing the logical object model.
Starting at the storage layer would let us preserve existing blob OIDs
rather than require ecosystem-wide changes. A new pack/index format could
provide another representation of the same object, much as deltas do
today. No particular representation was agreed. (Personal note: It is
curious to me why nobody tought about inventing a "meta blob", i.e. an
object much like a tree object, except that it stitches together a larger
blob. This would allow for the content-defined chunking that `rsync`
already championed, way before Git was born! It would have allowed a Git
native large file support worth writing home about, and could have
replaced Git LFS. Xet (https://huggingface.co/docs/hub/xet/index) would
not have had to be invented, and it would have allowed game development to
move to Git. I can only imagine that the time it would cost to get even
the first patches of this into core Git would be seen as prohibitive by
any company who may have considered the effort.)

There is also an API question: does a backend seeing only object content
have enough context to make good storage and delta choices, or should it
receive richer information? More searchable tree storage and a Git "commit
cloud" were other possibilities raised, not committed plans. (Personal
note: At a previous GitMerge, Facebook presented their work, see e.g.
https://github.com/facebook/sapling/blob/main/eden/mononoke/blobstore/pack=
blob/README.md,
which includes separating actual storage from transport. That is, already
at push time, derived metadata is computed in async jobs which provide
several potential deltas ready-to-go when a client clones or fetches. They
reported clones with regular Git clients that are twice as fast, just
because the server doesn't need to spend much compute on the data it
sends. So there is a lot to be learned out there already.)

AI

The current SubmittingPatches policy is rooted in DCO certification and
advice from SFC lawyers. The unresolved question is whether, and to what
extent, contributors can certify AI-generated code. There was substantial
disagreement about acceptable use, provenance and legal risks, community
trust, review burden, and whether the current caution excludes useful
tools. No policy change was agreed. (Personal note: You'd think that the
opinion of lawyers is taken at face value, but no, it seems that some core
Git contributors seem to disagree with the lawyers in favor of their own
opinion...)

Several participants found language and proofreading assistance useful. A
particular concern was submissions where the human does little more than
relay agent output, leaving reviewers to deal with the consequences. The
influx of poor GSoC contributions was one example. Attribution such as
Assisted-by was suggested to make tool use clearer, but attribution alone
does not answer the quality or DCO questions. (Personal note: my precedent
of "Assisted-by" was called out as helpful, and I do think it is. I make a
difference between AI-generated and AI-assisted. I'm not a fast typer, so
I benefit a lot from being able to tell an LLM to please refactor out
these four lines with the appropriate signature. There's not much
creativity in there. I also like to let AI present me the call graphs for
certain code locations, because due to the choice of C, which thanks to
the C preprocessor is not easy to analyze statically, there are no
competent tools other than LLMs that I can use for the task. I was highly
surprised, though, to see how much enmity against AI in general was
voiced, not by many, but many, many times, and how that contrasts with the
Linux project which I hitherto had not considered to be as particularly
open to modern practices.)

brian and Taylor agreed to put differing policy proposals on the list. The
suggested process is to have alternatives examined by SFC counsel, make
the risks clear, and then consider a vote. Emily volunteered to organize
the voting procedure. Eligibility and the details remain open; Junio's
authority as maintainer remains central. (Personal note: Since Taylor
works for OpenAI now, I was not surprised by his stance, but brian works
at GitHub, home of GitHub Copilot, and I am not sure how favorable their
employer would look at their semi-public utterings about AI...)

Protocol v2 for pushes

There are concrete use cases now: repositories with millions of refs,
including a reported 896 MB ref advertisement. Reftable improves ref
update throughput, but does not by itself solve the advertisement problem.
Nobody objected to push protocol v2, and the fetch-v2 infrastructure
already provides much of the foundation.

The discussion covered advertising fewer refs, letting clients identify
useful branches, and replacing large advertisements with a few rounds of
push negotiation. Negotiation results could also help optimize the
server's connectivity checks. Some improvements might be possible in the
existing protocol before introducing v2.

We need to measure the tradeoffs rather than assume fewer bytes means
faster pushes. One example involved a shallow push taking 35 seconds
instead of two because of work to minimize the transfer. Shallow
boundaries and unrelated histories complicate the proposed heuristics.

SHA-256 interoperability is another reason to want push v2: the current
push protocol requires using the server's primary hash algorithm.
Negotiation could make that more flexible.

Forge replication to thousands of mirrors would benefit from finding out
cheaply whether refs have changed, rather than downloading full
advertisements from every target. Checksums, ETag-like values, and
reftable generation numbers were discussed, with concurrent updates
complicating the picture.

Compact or compressed advertisements are also worth exploring and
benchmarking, possibly reusing reftable's format. That does not mean
sending the server's actual reftable, including hidden refs. There are
several promising directions here, but no final design yet.

Some breakout sessions were planned, but apparently had to be cut.

Personal notes: I wasn't present for all of the sessions, in the afternoon
I had other commitments; Therefore these notes (which AI assisted me in
distilling) came partially from what I dictated and partially from the
shared Google Document in which a few volunteers gracefully wrote notes. I
found it challenging to connect as a remote participant. The link to the
Google Meet, as well as control over the lobby thereof, seems to have been
restricted to at most a few people, which might have contributed to the
long waiting time before I was allowed in, and it definitely contributed
to my comments not reaching the discussion in time to have an impact. I
would have loved for Junio or the other two brave souls who also
participated remotedly to have had more "air time". I am still a fan of
the idea to have more frequent, smaller, virtual Contributor Summits,
organized by a rotating cast. (Maybe I can get Emily to host the next
one.) I was very happy that Junio was participating, as he _is_ the
project lead, and in past Contributor Summits decisions were taken without
him, which I found odd. Timing was really challenging for him, though, it
was way past midnight for him. I'm all the more grateful that he
did participate.

Final remark: This summary is obviously biased. I lightly edited it to
separate better between my personal views and a hopefully unbiased account
of what was discussed, and how, and by who. Nevertheless, I am but human.
As a consequence, I would be delighted if other participants would share
their summaries, so that my bias can be balanced out.

Ciao,
Johannes
