From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Mon, 12 Aug 2013 00:44:09 -0700
Message-ID: <7viozb1hh2.fsf@alter.siamese.dyndns.org>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
	<1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
	<20130809200101.GX14690@google.com>
	<7vr4e230g8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:44:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mnc-0006tu-B8
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab3HLHoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 03:44:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab3HLHoP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 03:44:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40CDF34D31;
	Mon, 12 Aug 2013 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LnTHi/Hlw7Co
	zEOL+jg4OtY4m0g=; b=IRbRTtppTOw+v6phzyr25TbINZy4KqLxkmc2uknVsFWG
	kJ7sh3HKNzNQ8yaqVDtgDmcHLfIplB2o2Q4PR77RRLhqPjxxo3lPzZ4pUkaT2JHP
	RwbAGli/9qnOBeX6cX4Df/tgtDKWr8MtwcrHf6Td3yWzclHQokJCZULTJzr8JgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MKQdWQ
	Z/HPCfImA0Nf7QCSdMRqP/8LB8J/JWo/qtuimkoEkUaOQG2d9IHzuovOZct12GcO
	dmEPyyvzYQDf2ig3SrZulTbZM4RnXGZXUD9gFO//f1czm1EUtiaFSxrw23Bj7EEH
	tvxCu1vQLBI1NAkCUiC1ROw1E5g2c3FYLfJ5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3641934D2E;
	Mon, 12 Aug 2013 07:44:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CF9834D2A;
	Mon, 12 Aug 2013 07:44:11 +0000 (UTC)
In-Reply-To: <7vr4e230g8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Aug 2013 16:32:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA59BAC8-0322-11E3-AE98-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232168>

Junio C Hamano <gitster@pobox.com> writes:

> I'd suggest using the lavabit address unless we hear the preferred
> address from her, as the lavabit address was used in 5bf46841
> (git-gui: update Japanese translation, 2010-02-02), while the last
> use of the bluebottle address was in 6762079a (Cloning from a repo
> without "current branch", 2007-06-16).

So with the above, and the four responses from long-lost friends,
here is what I came up with.

-- >8 --
Subject: .mailmap: update long-lost friends with multiple defunct addre=
sses

A handful of past contributors are recorded with multiple e-mail
addresses, all of which are undeliberable.  With a lot of help from
Jonathan, we located all of them except for one.  Update the found
ones with their currently preferred address, and use the last known
address to consolidate contributions by the lost person under a
single entry.

Helped-by: Stefan Beller <stefanbeller@googlemail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .mailmap | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index f7cc21e..7a5d0a6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -18,6 +18,8 @@ Alexey Shumkin <alex.crezoff@gmail.com> <Alex.Crezoff=
@gmail.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@ksplice.com>
 Anders Kaseorg <andersk@MIT.EDU> <andersk@mit.edu>
 Aneesh Kumar K.V <aneesh.kumar@gmail.com>
+Amos Waterland <apw@debian.org> <apw@rossby.metr.ou.edu>
+Amos Waterland <apw@debian.org> <apw@us.ibm.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
@@ -34,6 +36,8 @@ Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
 Daniel Barkalow <barkalow@iabervon.org>
+Daniel Trstenjak <daniel.trstenjak@gmail.com> <daniel.trstenjak@online=
=2Ede>
+Daniel Trstenjak <daniel.trstenjak@gmail.com> <trsten@science-computin=
g.de>
 David Brown <git@davidb.org> <davidb@quicinc.com>
 David D. Kilzer <ddkilzer@kilzer.net>
 David K=C3=A5gedal <davidk@lysator.liu.se>
@@ -68,11 +72,17 @@ J. Bruce Fields <bfields@citi.umich.edu> <bfields@p=
ig.linuxdev.us.dell.com>
 J. Bruce Fields <bfields@citi.umich.edu> <bfields@puzzle.fieldses.org>
 Jakub Nar=C4=99bski <jnareb@gmail.com>
 James Y Knight <jknight@itasoftware.com> <foom@fuhm.net>
+# The 2 following authors are probably the same person,
+# but both emails bounce.
+Jason McMullan <jason.mcmullan@timesys.com>
+Jason McMullan <mcmullan@netapp.com>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@EECS.Berkeley.EDU>
 Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
 Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
 Jeff King <peff@peff.net> <peff@github.com>
 Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
+Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
+Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Johannes Schindelin <Johannes.Schindelin@gmx.de> <johannes.schindelin@=
gmx.de>
@@ -144,7 +154,7 @@ Michele Ballabio <barra_cuda@katamail.com>
 Miklos Vajna <vmiklos@frugalware.org> <vmiklos@suse.cz>
 Namhyung Kim <namhyung@gmail.com> <namhyung.kim@lge.com>
 Namhyung Kim <namhyung@gmail.com> <namhyung@kernel.org>
-Nanako Shiraishi <nanako3@bluebottle.com>
+Nanako Shiraishi <nanako3@lavabit.com> <nanako3@bluebottle.com>
 Nanako Shiraishi <nanako3@lavabit.com>
 Nelson Elhage <nelhage@mit.edu> <nelhage@MIT.EDU>
 Nelson Elhage <nelhage@mit.edu> <nelhage@ksplice.com>
@@ -177,6 +187,8 @@ Robert Fitzsimons <robfitz@273k.net>
 Robert Shearman <robertshearman@gmail.com> <rob@codeweavers.com>
 Robert Zeh <robert.a.zeh@gmail.com>
 Robin Rosenberg <robin.rosenberg@dewire.com> <robin.rosenberg.lists@de=
wire.com>
+Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <rutger@nospam.com>
+Rutger Nijlunsing <rutger.nijlunsing@gmail.com> <git@tux.tmfweb.nl>
 Ryan Anderson <ryan@michonline.com> <rda@google.com>
 Salikh Zakirov <salikh.zakirov@gmail.com> <Salikh.Zakirov@Intel.com>
 Sam Vilain <sam@vilain.net> <sam.vilain@catalyst.net.nz>
