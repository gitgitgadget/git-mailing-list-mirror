From: Jeff King <peff@peff.net>
Subject: Re: [git wiki PATCH] Teaching "--3way" to "git apply"
Date: Mon, 5 Mar 2012 05:02:37 -0500
Message-ID: <20120305100236.GA29061@sigill.intra.peff.net>
References: <20120302091114.GA3984@sigill.intra.peff.net>
 <7vbooc6isi.fsf@alter.siamese.dyndns.org>
 <20120305053343.GA25373@sigill.intra.peff.net>
 <87vcmjxyjh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 05 11:02:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Uki-0001Jz-Ba
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 11:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab2CEKCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 05:02:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37602
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab2CEKCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 05:02:42 -0500
Received: (qmail 28061 invoked by uid 107); 5 Mar 2012 10:02:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Mar 2012 05:02:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2012 05:02:37 -0500
Content-Disposition: inline
In-Reply-To: <87vcmjxyjh.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192219>

On Mon, Mar 05, 2012 at 09:05:54AM +0100, Thomas Rast wrote:

> > I actually think it may be a little bit too small for a whole summer
> > project. But I pushed it to the wiki for the reasons above; this is just
> > an ideas page, not a solid list of proposals.
> 
> Perhaps we should spell this out in the leading text?  I was going to
> send a patch, but got stuck rewording at
> 
>   Note that these are ideas, not project proposals.  As stated, they may
>   not be of the right difficulty or size to be solved within one Summer
>   of Code.
> 
> Maybe you can find a nicer way to write the "as stated" (I want it to
> say "in the form they currently have") and put that before the first
> title.

I think the whole intro text is pretty bad. I just pushed the patch
below, but I'm open to suggestions.

-- >8 --
ideas: give a better introduction

The original text was just pulled from the ideas page of
previous years. Let's rework it to address our two audiences
(people adding ideas, and students reading the page)
directly. And especially let's encourage students to realize
that these ideas are just starting points, and try to get
them to engage the community before writing a proposal (or
worse, just submitting a proposal that is simply a
cut-and-paste of one of the ideas).

Signed-off-by: Jeff King <peff@peff.net>
---
 SoC-2012-Ideas.md |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index aeaacb1..0bd938a 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -1,9 +1,24 @@
 This page contains project ideas for Google Summer of Code 2012 from the
-Git user and development community. You can get started by reading some
-project descriptions, and the mailing list thread(s) that spawned them.
-If you have another idea, add it to this page and start a discussion on
-the [[git mailing
-list|https://git.wiki.kernel.org/articles/g/i/t/GitCommunity_c4e3.html#Mailing_List]].
+Git user and development community.
+
+If you're active in the git community and have an idea that you would
+feel comfortable mentoring, feel free to add it. If you have an idea but
+need to find a suitable mentor, please bring it up on the [git mailing
+list]; others can help you develop the idea and may volunteer to mentor.
+
+If you're a prospective GSoC student, read through the ideas and see if
+any interest you. But note that these are ideas, not project proposals;
+they may need details filled in or expanded to make a good project.
+Find an area that interests you and start a discussion on the [git
+mailing list], even if it's just by asking more about the topic. A good
+proposal will be clear about the problem to be solved, the history of
+work in that area, and the specifics of the approach that the GSoC
+project will take. You can find some of those answers by reading the
+code and searching the list archives, but discussing the idea with
+interested developers is a great way for both the student and mentor to
+reach an understanding of exactly what is to be accomplished.
+
+[git mailing list]: https://git.wiki.kernel.org/articles/g/i/t/GitCommunity_c4e3.html#Mailing_List
 
 Better git log --follow support
 -------------------------------
-- 
1.7.9.1.11.g9d81f
