From: Jeff King <peff@peff.net>
Subject: git as an sfc member project
Date: Fri, 22 Oct 2010 14:30:28 -0400
Message-ID: <20101022183027.GA12124@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 20:31:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9MOQ-00069W-0o
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 20:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872Ab0JVS3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 14:29:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33061 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743Ab0JVS3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 14:29:44 -0400
Received: (qmail 21382 invoked by uid 111); 22 Oct 2010 18:29:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 18:29:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 14:30:28 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159722>

It's been a while since I last sent an update; the reason is that
nothing was happening. :) The SFC didn't have a board meeting to vote on
new projects until September, and then spent a few weeks getting
paperwork together. But now we have official word: git has been accepted
as a member project.

Basically, the utility of this is that the Software Freedom Conservancy
will handle any money that goes to the project, especially with respect
to tax implications (the SFC is a registered non-profit and has actual
accountants and such). In the past, the only money has ever been Summer
of Code money, and some unlucky soul had to handle the money (and tax
implications) each year by themselves. Joining the SFC will also make it
easier for people to give tax-deductible donations to the project. Of
course I have no idea what we would spend such money on, but that is a
problem we can perhaps deal with later.

There is one slight caveat, which is that JGit was not accepted, due to
the complexity of their ties with the Eclipse Foundation. In practice, I
don't think this will matter much at all. The only way that Git operates
in any legal capacity as a group is when we do Summer of Code. This
could impact us, e.g., if were to have a JGit-specific SoC project.
Probably the money that goes to the organization for such a project
should _not_ go through the SFC, and would have to be handled
separately. Which is no worse than JGit has it today; they just can't
receive the SFC services as regular git can.

Note that we're not officially a member project yet, as nothing has been
signed. So if people have objections, it's not too late to say
something. If we do want to go ahead, we need to fill in some details
that will go in the agreement.

The draft agreement is here:

  http://peff.net/git-sponsorship-agreement.pdf

Apologies for not simply attaching it, but it is larger than vger's 100K
message limit.

Bradley Kuhn also provided a some discussion of the various points in
the agreement, including deciphering the legalese and explaining the
motivation for each paragraph. I'll include it at the end of this email.

Basically what we need to decide on before signing is:

  1. Who should sign? These people are basically speaking for git as a
     community. Related to (2) below.

  2. What is the leadership structure of git as a legal entity? In other
     words, if we get some money that goes to the SFC (from SoC or from
     donations), who should have authority to tell the SFC to do
     something with it?

     The obvious choices (to me) are:

       a. Junio as benevolent dictator^W maintainer.

       b. Somebody else as benevolent SFC liaison.

       c. Some committee of core people (I'd say no more than 3-5) who
          would all need to agree (or perhaps some majority).

     For (b) and (c), we would need to figure out who the somebody or
     somebodies would be, and perhaps more importantly, the process for
     selecting them. As time goes on, core people may leave, and new
     core people may replace them.

     We could go as complicated as having elections, or as simple as
     "liaison appoints successor".

     Personally, I favor a small group which can approve new people to
     join, and which can leave at will. Having more than one person
     avoids hit-by-bus problems (or even just dropped-off-net problems).
     There is little enough power in such a position that I'm not too
     worried about some crazed egomaniac becoming the Git-SFC liaison.

  3. How much money should we give to the SFC?

     A big chunk of their budget comes from taking a percentage of
     member project money. As a project, we set the percentage we give
     them. So we can give them nothing if we want. But they do provide
     useful services, and even without direct benefit to git, the SFC is
     promoting free software. So probably it makes sense to choose some
     non-zero number.

More details are in the agreement linked above, or in Bradley's
explanation below.

-Peff

-- >8 --
I'm glad that you are considering joining the Conservancy and I am
pleased to extend an invitation to Git.  Attached is a draft of the
fiscal sponsorship agreement that representatives of Git will need to
sign in order to join the Conservancy.  (Both LaTeX source and PDF are
included.) Please read this agreement and share and discuss it with all
of the key people involved in Git.

As mentioned in my previous email, generally, we leave it for the Git
community to decide how you'd like to discuss the document, as signing
such an agreement is a big step for the project and you should consider
the agreement in whatever forum is most appropriate for your community.
I'm happy to answer questions from the community as you consider the
document, and you should feel comfortable cc'ing me on any threads you
think I should comment on.  (However, before doing so, please make sure
I can post back to any lists included in the Cc without being formally
subscribed.)  Meanwhile, you are also welcome to batch questions into
one group as well and email them to me directly, and just repost my
responses.  Basically, whatever works well for you works fine for me.

I strongly suggest that you share the agreement draft as wide as
possible throughout the community, and make sure anyone who has ever
been a serious contributor to the project in the past or currently is
made aware of your plans to join Conservancy.  We very much rely on you
to make sure that your entire community is in agreement with joining
Conservancy, so please make efforts to be sure everyone has had their
say.


Regarding the agreement, some of the more complex provisions of the
agreement reflect the special considerations necessary to support the
Conservancy's tax exempt status.  However, on the whole, I believe that
this agreement fairly and clearly sets out an advantageous relationship
for the Conservancy's member projects.  As some of the paragraphs
specifically indicate, the agreement can be tailored to reflect Git's
particular needs.  To help you in your review, below is a
section-by-section walk through, giving an explanation of the
significance of each provision.  If there are any sections that seem
confusing or that you feel should be changed to reflect Git's needs,
please let me know and we can discuss them.


Introductory Paragraph

This paragraph identifies the parties to the contract.  It's more
thoroughly explained in paragraph 6, but the point of this paragraph is
to name the people who sign the agreement.

Recitals (the "WHEREAS" section)

These paragraphs set forth the basic understandings of the parties.
Similar to the "preamble" found in the GPL and other Free Software
licenses, these are *not* operative provisions of the document.
Instead, they give the context of the agreement.

In this specific case, the key points of understanding are that the
purpose of Git is to forward Free, Libre and Open Source Software
(FLOSS) and that both the Conservancy and Git want Git to join the
Conservancy.  The Conservancy's mission (and charitable purpose) is to
advance only FLOSS development, documentation, and usage, so it is
important that this context be stated clearly.

Paragraph 1 - Term of Agreement

This paragraph says that Git is part of the Conservancy as of the
signing date of the agreement.  It cross references the terminations
provisions in paragraph 7 (which is explained in greater detail below).
Note, though, that Git can choose to leave the Conservancy at any time.

Paragraph 2 - Project Management and Activities

a) Both parties agree that Git will be FLOSS.  As noted above, this is
   the fundamental goal and charitable purpose of the Conservancy.  The
   Conservancy will not and cannot sponsor proprietary projects.

b) This clearly sets out the limits of the Conservancy's management over
   Git.  Due to requirements connected to Conservancy's tax exempt
   status, the ultimate legal control of the projects must be with the
   Conservancy.  From the IRS's perspective, the projects are part of
   the Conservancy, and the purpose of its tax exemption is to forward
   the FLOSS mission of those projects.

   However, the Conservancy does not want to interfere with the
   successful software development, documentation and advocacy work
   already underway in member projects; such activity should continue
   after the agreement without interruption or interference.  This
   paragraph delegates some of Conservancy's legal authority back to the
   developers, so that Git can run itself in day-to-day matters.

   The only limitations that we must place are to prevent Git from
   producing non-free software (as per Conservancy's charitable purpose)
   and from spending money or conducting activities that would
   jeopardize the Conservancy's tax exempt status.  All the ordinary
   activities of FLOSS projects come well within these limitations.
   Some specific activities that are restricted include lobbying
   activities and spending money in ways other than consistent with the
   charitable purposes of the Conservancy (i.e., forwarding FOSS).

   Note that developers of Git in their capacity as individuals (when
   not representing Git still may engage in for-profit service
   businesses related to their FLOSS work.  The work of Git itself must
   fit the guidelines, but individuals are free to act in their own
   capacity in other endeavors, as long as they clearly state that they
   are not acting on behalf of the project when they do so.

   If you are ever concerned that a particular activity -- be it one
   carried out for Git or one that an individual developer engaged in
   independently -- might be a problem, you can always ask the
   Conservancy for clarification.

c) As discussed above in (b), this section describes the corporate
   relationship of the project and the Conservancy.  For clarity, it
   refers to section (b), which delegates the actual management of Git
   to the relevant developers.  Conservancy, when acting as a fiscal
   sponsor, must have the legal authority to manage Git even though
   section (b) delegates the day-to-day operations to the developers.

d) This section clarifies that Git can't represent the Conservancy
   without getting written authorization first.  If you'd like to
   represent the Conservancy at a conference or other such event, you
   can always talk to us about it.

Paragraph 3 - No Fees

It's just as it sounds.  The Conservancy provides services to projects
to benefit the FLOSS community and does demand member projects to bear
the overhead costs.  Projects are encouraged to make donations to the
Conservancy as a percentage of their funds to assist the Conservancy
with its operating expenses.  Please note, though, that Conservancy is
only able to provide its services to member projects because there is a
reasonably healthy general fund available.  Donations from our member
projects are not the only source of general fund revenue, but it is a
substantial component in Conservancy' sustainability plan.

Therefore, if you choose to do so, this section provides suggested
wording in brackets for donating a percentage of the Project's income to
be used towards keeping the Conservancy up and running (10% is a very
common rate that many umbrella organizations require for their fiscal
sponsorship services).

Paragraph 4 - Project Fund/Variance Power

This sets out the financial structure in connection with the
relationship described above in paragraph 2. Conservancy will separately
account for Git's revenue (and Git will have its own bank account at the
Conservancy once its balance reaches $3,500).  For tax purposes,
Conservancy will report all of the income to Git in its IRS and state
filings.  Git therefore will not need to file any separate tax documents
with the IRS.  Conservancy will keep the financial books for Git,
sending periodic reports to the project's developers.

The developers will direct the Conservancy to spend the money on behalf
of Git within the limitations imposed by the tax laws and Conservancy's
501(c)(3) mission.  Conservancy will receive any checks on behalf of
Git, and it will also write checks on behalf of Git.

Paragraph 5 - Project Fund Management/Performance of Charitable Purposes

This paragraph clarifies that all assets will be devoted to the
project's purposes, as those purposes are a subset of the Conservancy's
purposes.  Assets cannot be used in connection with activities that
would jeopardize the Conservancy's tax exempt status.  As discussed
above, in practice, most typical expenses of FLOSS projects will come
well within these limitations.  Activities that are restricted include
lobbying activities and spending money in ways other than consistent
with the charitable purposes of Conservancy (i.e., forwarding FLOSS).

Paragraph 6 - Representation of the Project in the Conservancy

As the note in this section indicates, we understand that each project
will have its own management structure that it has developed to reflect
its size and community.  This paragraph requires that certain
representatives be named as the individuals that can officially
communicate decisions on behalf of Git.  This can be a single
maintainer, a committee of developers or a few specified
representatives.

To the extent that it makes sense for Git to have a committee of
representatives, we should indicate how decisions can be made by that
committee.  For example, should all decisions be communicated to the
Conservancy by all members of the committee or would a simple majority
suffice?  Can any one representative communicate official decisions on
behalf of all?  Git should also consider adding a mechanism here for
adding and removing representatives over time.  We're happy to discuss
methods that have worked for other projects with you to help you select
the solution that is right for you.

We generally find this is the most difficult provisions for projects to
work out, as it does require that your project consider the form and
type of leadership structure it wants to have, and that structure will
be legally formalized in this document for perpetuity.

Paragraph 7 - Outstanding Liabilities

In this section, Git confirms that it has told the Conservancy about any
liabilities that might be outstanding prior to joining the Conservancy.
This gives the Conservancy some assurance that its due diligence process
has been complete and that the Conservancy's Board received all of the
information it needed to properly evaluate the project.  Liabilities
include, for example, financial obligations, such as any debts or
outstanding bills, or any legal claims that could be outstanding against
Git.

If you believe some liabilities exist, or that something may be a
liability and aren't sure, please err on the side of letting Conservancy
know about it.

Paragraph 8 - Termination

Projects can leave Conservancy at will.  This section sets out the
mechanisms for termination to make sure that when a project leaves the
Conservancy it does so without jeopardizing the tax exempt status of the
Conservancy (and, consequently, the status of all of the other projects
in the Conservancy).

There is a 60 day notice requirement so that a new tax exempt non-profit
can be found for Git to join.  If there isn't another fiscal sponsor or
other tax exempt non-profit to take over Git, Git can incorporate as a
separate entity and apply for tax exemption recognition.  If there is no
separate entity -- for example if a project loses momentum and has been
abandoned by its developers -- the Conservancy must be left with the
assets for use by the Conservancy for other FLOSS-related charitable
work.

These restrictions would also apply to any separate tax exempt entity,
so if Git were to incorporate and achieve tax exemption outside of
Conservancy, it would have to deal with the same considerations upon any
wind-up or distribution of assets.  Members of the Conservancy's board
are familiar with non-profit wind-down situations, and can assist in the
unlikely event that this unfortunate outcome occurs.

Paragraph 9 - Miscellaneous

These provisions are standard agreement boilerplate - they clarify the
enforceability of separate provisions, specify that the contract be
governed by New York Law and state that any amendments to this agreement
need to be agreed to in writing by all of the parties.

Paragraph 10 - Counterparts/Facsimile

Although it's good to have original signatures in the corporate records,
this allows you to simply scan a copy for the contract to take effect.


We hope this explanation document has made it clear why the agreement is
structured in this way.  If any provisions seem problematic to you, let
us know and we'll work with you to try to build an agreement that works
for both of us.  We look forward to Git joining the Conservancy!
