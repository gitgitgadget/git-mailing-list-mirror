From: Jeff King <peff@peff.net>
Subject: Git + SFC Status Update
Date: Mon, 13 Apr 2015 13:56:14 +0200
Message-ID: <20150413115613.GA4589@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 13:56:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhcyW-0000DJ-0t
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 13:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbbDML4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 07:56:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:44876 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753307AbbDML4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 07:56:17 -0400
Received: (qmail 29943 invoked by uid 102); 13 Apr 2015 11:56:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Apr 2015 06:56:16 -0500
Received: (qmail 30755 invoked by uid 107); 13 Apr 2015 11:56:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Apr 2015 07:56:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2015 13:56:14 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267077>

Here are the slides from my talk at Git Merge, along with the speaker
notes and a few tidbits from the discussion that came afterwards. The
talk was not recorded, so if you were there, please feel free to fill in
details I've missed from the ensuing discussion.

I'm sending the source format, since it has the notes and is easy to
package in an email. If anybody really wants the rendered result, I can
try to stick it somewhere (or finally get around to publishing my nasty
rendering scripts).

-- >8 --
# Git + Software Freedom Conservancy Overview

Jeff King<br>
Git Merge<br>
April 8th, 2015

---

# Background

 - Software Freedom Conservancy is a not-for-profit organization to
   promote and help FLOSS projects.

 - Git joined as a member project in 2010 ("The Git Project")

 - Primary motivation: legally handle GSoC money

---

# Background (continued)

 - Conservancy is as close as Git gets to being a legal entity (e.g.,
   holding monetary assets)

 - Conservancy does _not_ hold copyrights or have any control over the
   code

 - decisions are made by agreement of committee (Junio Hamano, Jeff
   King, Shawn Pearce)

---

# Activities so far

 - money handling (GSoC and beyond)

 - holding domain names (git-scm.com, git-scm.org)

 - we own a Mac!

 - "Git" trademark

// Actually, we don't technically have control over git-scm.com yet.
// Scott Chacon has several times agreed to transfer it to us, but we
// have not gone through with the actual transfer. We should probably do
// that, as well as move the Heroku hosting for the site over to the
// project, just to address any potential continuity issues (people
// being hit by buses, etc).
//
// The Mac was purchased with money that was donated by GitHub, and is
// held by Tim Harper, who uses it to make the OS X packages that are
// linked from git-scm.com. Technically we own it and can ask for it
// when we like.

---

# Trademark

 - Written policy: https://git-scm.com/trademark

 - Informal goals:

   - avoid people pretending to be (or endorsed by) official git

   - avoid calling non-interoperable things git

 - Many names are OK or grandfathered (e.g., JGit, libgit2, Gitolite,
   Gitorious)

// We have trademark both on the name Git and on the diamond logo.
// GitHub is also a trademark, held by (surprise!) GitHub. We have an
// agreement that both are OK, not confusing, and neither side will
// annoy the other by claiming trademark infringement.

---

# Money: How much do we have?

 - $19,059.25 (USD)

// Disclaimer: this is not necessarily up-to-the-minute, as
// SFC's reports to us sometimes lag a bit. And also because
// I am fairly inexperienced using the `ledger` program, so
// it's possible I've misinterpreted the results. However, we
// shouldn't have any serious outstanding expenses, so this
// is close to correct.

---

# Money: Where does it come from?

 - 10% of everything we take in goes to Conservancy general fund; these
   numbers are actual inputs to Git account

 - Donations ($6577); we do not actively solicit, but people want to
   give us money

 - GSoC ($7236); this includes travel reimbursement money which flows
   through the project account; I believe $5500 is mentor stipend

 - Amazon affiliate links ($4255)

 - Packt Publishing royalties ($1724)

// Disclaimer: these numbers were generated from a number of queries
// that I performed manually against the ledger file. It's entirely
// possible that I ended up missing some sources or double-counting
// others. So please take the numbers as approximations, and if
// somebody really wants to carefully audit the numbers, I can share
// the source data.

---

# Money: Where does it go?

 - Travel ($3692); all to GSoC mentor summit + GitTogether

 - Stickers ($135)

 - Trademark fees ($875); note that these are USPTO fees. The legal
   labor is provided by Conservancy.

// Similar disclaimer on accuracy.
//
// The stickers were printed by me and handed out at a GSoC Mentor
// Summit in 2011.

---
center

# Now what?

That's the current state. Where do we want to go from here?

---

# Governance (1/3)

 - Are we happy with the leadership structure?

   - Control of the project is held by committee, including power to
     remove or add people to committee.

   - Internal structure is up to us, not Conservancy.

   - Solicited opinions in 2010, and this is what we got.

     - Democracy is a hassle?

     - Still happy?

// Keep in mind again that this is just The Git Project, holding
// the money and any other assets. Not copyright on code, and with
// no power over the day-to-day of the technical sides of the project.
//
// The current structure is essentially benevolent-committee-for-life.
// We ended up with that because it was the simplest thing, and it
// did not really seem to matter to anybody to do anything different.
// I'm of the opinion that this is still the case, but I want to make it
// clear that we are free to discuss alternatives without resorting to
// violent revolution.

---

# Governance (2/3)

 - More official positions?

   - Webmaster, Newsletters, Dog-Catcher?

   - My opinion: no. Keep everything as decentralized as possible. The
     only power is holding the assets / purse strings, and those
     resources can be allocated without official structure.

   - Note that the main tasks, writing code and being the maintainer,
     area logically separate from The Git Project.

---

# Governance (3/3)

 - More transparency?

   - Not much to report so far.

   - Privacy concerns?

 - Other suggestions?

// The committee has not done a good job of communicating activities,
// mostly because there weren't interesting activities to report. The
// trademark stuff is the first interesting thing that's happened, IMHO.
//
// We could be more transparent about who gets travel money, but there's
// actually been very little rewarded (and it's generally people who are
// going to the mentor summit, where it's really Google money flowing
// through us). But we could be more public about it, with the possible
// caveat that it may infringe on the privacy of anybody who asks for
// need-based aid. I'm open to suggestions.

---

# Spending the Money

 - Money accrued over several years with little spending. Sustainable
   annual "budget" is probably $4K.

 - If you have an idea that needs money, works out the details and
   budget and ask!

 - Restrictions:

   - Ideas must support FLOSS aspects of the project (Conservancy rule)

   - Ideas should be discussed on the list. Ultimately approval comes
     from the committee, but we would like to represent the will of the
     community.

---

# Half Baked Ideas I Came up With

   - Outreach Program for Women; like GSoC, except we get to pay the
     stipend!

   - Give some money to Conservancy

     - Trademark labor

     - GPL enforcement

   - Give some money to somebody else (gcc, curl, FSF, etc)

// The OPW site is here: https://www.gnome.org/opw/
// It runs twice a year (once around GSoC, and once near
// southern-hemisphere summer). I don't think the deadline for Fall
// participation has been published, but if we are interested, we
// probably need to do paperwork starting in August or so. It would need
// a volunteer to spearhead the effort.
//
// Regarding money to Conservancy, they have been very helpful to us and
// charge us very little money (in fact, none at all; the 10% we give
// them is a voluntary donation). All of the lawyer labor for the
// trademark stuff is done for free by Conservancy's lawyer.
//
// Obviously holding onto the money is another option. Stickers or
// t-shirts are another option, though we should figure out the
// mechanism for distributing them (mailing stickers to anybody who asks
// is going to mean they go very fast, and we will incur a lot of
// mailing costs). So I think we're open to ideas like this, but
// hopefully they will be thought through more than "we should give
// everybody t-shirts!"

---

# Questions / Discussion

// After the talk, most of the discussion centered around the idea of
// providing a venue for companies to donate money to the project, which
// would then get doled out to developers. This seems like a reasonable
// idea in principle, but there are a lot of details to be worked out:
//
// 1. Is this legal from Conservancy's perspective (remember that they
//    are bound by non-profit rules in NY, USA)?
//
// 2. How would we take in money? Would we solicit donations? Just let
//    it be known that this is an option? How much of a budget would we
//    shoot for?
//
// 3. How would the money be distributed? Who is eligible to request
//    funds? What is the application process? Who reviews the
//    applications?
//
// I'm going to start by asking Conservancy about point (1), as that is
// obviously a prerequisite. They might have some guidance on the other
// points, if they have helped other projects do something similar
// before.
