From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Mon, 12 Aug 2013 00:58:11 -0700
Message-ID: <7vd2pj1gto.fsf@alter.siamese.dyndns.org>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
	<1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
	<20130809200101.GX14690@google.com>
	<7vr4e230g8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8n1I-0001OV-P4
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab3HLH6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 03:58:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589Ab3HLH6Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 03:58:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDDA93336D;
	Mon, 12 Aug 2013 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LnTHi/Hlw7Co
	zEOL+jg4OtY4m0g=; b=cSgxLr5dh3w3t9zkSySc1YUZQ9rDN0k05nleIKH3w7IF
	Ez9krxN1ptrz+IZmMl7KSnJWwZ4iIfw29BME3AANEV4i98dpPx/Gs/bKen2/z9+E
	Ntoh7iNJemXRNZEHMIF5/E0anQ+TBBGf12XGbddc71Dt6IsAqux7HLSQ81sfjuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IalpG4
	bvKWNzpkNiCB9HZolqL0DKgTE+I8b2F4zMl80UqqdexZ7jNGzfVPkiHG+tRaKy1f
	J9bf8dhLKU2L1OrsJ8Q36zsJ2OXl87/FD7ptX1xVm2EeJkxH289rbBHkCUUt5h5U
	wvGWSaxRd2/jmcXs63lKwVOW93nfoWlrtcsak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C02013336C;
	Mon, 12 Aug 2013 07:58:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D174033367;
	Mon, 12 Aug 2013 07:58:22 +0000 (UTC)
In-Reply-To: <7vr4e230g8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Aug 2013 16:32:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5CAE5E8-0324-11E3-9AC4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232172>

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
