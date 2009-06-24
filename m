From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 19:59:40 +0200
Message-ID: <20090624175940.GC7576@elte.hu>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu> <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com> <4A3FB479.2090902@lsrfire.ath.cx> <7vhby64i8f.fsf@alter.siamese.dyndns.org> <20090624081819.GA10436@elte.hu> <alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de> <7vws71wquf.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906241835240.7946@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761110AbZFXR77@vger.kernel.org Wed Jun 24 20:00:48 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761110AbZFXR77@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJWm7-0000MX-Rp
	for glk-linux-kernel-3@gmane.org; Wed, 24 Jun 2009 20:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761110AbZFXR77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Jun 2009 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbZFXR7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Jun 2009 13:59:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55208 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925AbZFXR7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Jun 2009 13:59:51 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1MJWl7-0003gW-1b
	from <mingo@elte.hu>; Wed, 24 Jun 2009 19:59:50 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 6294D3E22B7; Wed, 24 Jun 2009 19:59:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0906241835240.7946@intel-tinevez-2-302>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122152>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122152>


* Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Okay, a script similar to what you propose shows this:

thanks Johannes! I've queued up the commit below, with the names=20
added to a new CREDITS file (sorted alphabetically).

	Ingo

-------------->
=46rom 1b173f77dd0d5fd4f0ff18034aaa79e30da068b9 Mon Sep 17 00:00:00 200=
1
=46rom: Ingo Molnar <mingo@elte.hu>
Date: Wed, 24 Jun 2009 19:54:29 +0200
Subject: [PATCH] perf_counter tools: Add CREDITS file for Git contribut=
ors

Much of perf's libraries comes from the Git project. I noticed
that the files (in tools/perf/util/*.[ch] and elsewhere) are
quite spartan wrt. credits, so lets add a CREDITS file that
includes an (incomplete!) list of main contributors.

Thanks guys, these libraries are really useful. Special thanks
go to Johannes Schindelin and Junio C Hamano for coming up with
this list.

List-Composed-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 tools/perf/CREDITS |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/tools/perf/CREDITS b/tools/perf/CREDITS
new file mode 100644
index 0000000..c2ddcb3
--- /dev/null
+++ b/tools/perf/CREDITS
@@ -0,0 +1,30 @@
+Most of the infrastructure that 'perf' uses here has been reused
+from the Git project, as of version:
+
+    66996ec: Sync with 1.6.2.4
+
+Here is an (incomplete!) list of main contributors to those files
+in util/* and elsewhere:
+
+ Alex Riesen
+ Christian Couder
+ Dmitry Potapov
+ Jeff King
+ Johannes Schindelin
+ Johannes Sixt
+ Junio C Hamano
+ Linus Torvalds
+ Matthias Kestenholz
+ Michal Ostrowski
+ Miklos Vajna
+ Petr Baudis
+ Pierre Habouzit
+ Ren=E9 Scharfe
+ Samuel Tardieu
+ Shawn O. Pearce
+ Steffen Prohaska
+ Steve Haslam
+
+Thanks guys!
+
+The full history of the files can be found in the upstream Git commits=
=2E
