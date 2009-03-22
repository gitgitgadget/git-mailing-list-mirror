From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Disallow amending published commits?
Date: Sun, 22 Mar 2009 16:15:08 +0100
Message-ID: <20090322151508.GA13577@vidovic>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com> <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com> <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com> <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com> <885649360903212109v316f441fvea3f498e91c0059e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>,
	Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 16:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlPPs-0008Mq-C5
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 16:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZCVPPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 11:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754723AbZCVPPS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 11:15:18 -0400
Received: from out4.laposte.net ([193.251.214.121]:50340 "EHLO
	out3.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754365AbZCVPPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 11:15:18 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8314.laposte.net (SMTP Server) with ESMTP id 100107000098;
	Sun, 22 Mar 2009 16:15:10 +0100 (CET)
Received: from ? (91-165-135-230.rev.libertysurf.net [91.165.135.230])
	by mwinf8314.laposte.net (SMTP Server) with ESMTP id 5A1417000094;
	Sun, 22 Mar 2009 16:15:09 +0100 (CET)
X-ME-UUID: 20090322151509369.5A1417000094@mwinf8314.laposte.net
Content-Disposition: inline
In-Reply-To: <885649360903212109v316f441fvea3f498e91c0059e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (-150)(0000)gggruggvucftvghtrhhoucdtuddrvdekuddrfeduucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvtddmneesvcftvggtihhpihgvnhhtshculddquddttddmneculddquddttddmnehnohcuhhhoshhtuchurhhlucdlfedtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114146>


On Sat, Mar 21, 2009 at 09:09:43PM -0700, James Pickens wrote:

> I think you understood the question perfectly, and your comments all make
> sense.  Perhaps I'm just being paranoid and this won't be a problem at all.

I guess it's most depending of your proposed general workflow. So, it
makes sense.

> A bit of background might help explain my paranoia: I'm about to pilot Git
> on a fairly large project, where none of the users have Git experience, and
> many of them don't have much experience with any other version control
> system either.

As I understand, a part of your workflow is based on automatic testing
stages. It could be a good thing but I think you have to fit this into a
more general "human based worflow". I mean that parallel developments
should have one or more "official maintainers". Maintainers would have
to care of the history integrity, assume the responsability of passing
the tests, etc.

IMHO, good maintainers you can trust is much better than any "more
automatic restrictive testing suites".

Here is a link talking about that kind of issues that you (and your
maintainers) may be interested in:
http://kerneltrap.org/Linux/Git_Management

-- 
Nicolas Sebrecht
