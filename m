From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2012 application process
Date: Mon, 05 Mar 2012 15:42:23 +0100
Message-ID: <vpq8vjfgldc.fsf@bauges.imag.fr>
References: <20120302091114.GA3984@sigill.intra.peff.net>
	<vpqipijjhh5.fsf@bauges.imag.fr>
	<20120305135835.GB17189@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 15:42:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Z7X-0000Ux-6X
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385Ab2CEOme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:42:34 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44276 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348Ab2CEOmd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:42:33 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q25EcnDY015005
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Mar 2012 15:38:49 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S4Z7I-0003lA-A1; Mon, 05 Mar 2012 15:42:24 +0100
In-Reply-To: <20120305135835.GB17189@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 5 Mar 2012 08:58:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 05 Mar 2012 15:38:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q25EcnDY015005
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331563131.1154@NIQi7A5KmghcHk+gdD/Itg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192249>

Jeff King <peff@peff.net> writes:

>>   https://git.wiki.kernel.org/articles/s/m/a/SmallProjectsIdeas_00e5.html
[...]
>> I can either add a link to this page on the ideas list, or convert this
>> page to markdown syntax to add it to the wiki.
>
> I'd rather have them on a separate page. Which brings up the question of
> whether they should be moved at all.

Right now, they don't need to, but having them as static pages with
strange name (I had to guess the 00e5 part of the URL to find the
page ...) is not optimal when it comes to editing ;-). Nothing urgent
though. Scott said he had plans to host a wiki on git-scm.com, it can
probably wait until that.

I think it makes sense to add a link, so that more generally than the
SoC context, pages containing ideas link to each other. How about this:

>From c7ab11696f777e70e6bc254424f54bc884e52758 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 5 Mar 2012 15:37:06 +0100
Subject: [PATCH] Add links to other sources of inspiration

---
 SoC-2012-Ideas.md |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 0bd938a..6f543f6 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -291,3 +291,13 @@ am -3" simpler.
 Programming language: C89
 Suggested by: Junio C Hamano
 Possible mentors: ???
+
+Other sources of inspiration
+----------------------------
+
+* Previous year's SoC ideas:
+[SoC2011Ideas](https://git.wiki.kernel.org/articles/s/o/c/SoC2011Ideas_49fd.html),
+[SoC2010Ideas](https://git.wiki.kernel.org/articles/s/o/c/SoC2010Ideas_ccd4.html)
+* [Git users survey](http://permalink.gmane.org/gmane.comp.version-control.git/183242)
+* [Small project ideas](https://git.wiki.kernel.org/articles/s/m/a/SmallProjectsIdeas_00e5.html)
+(probably too small for a SoC)
-- 
1.7.9.111.gf3fb0.dirty



-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
