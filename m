From: Junio C Hamano <gitster@pobox.com>
Subject: What's not in 'master', and likely not to be in, until 1.5.4
Date: Sun, 20 Jan 2008 18:37:38 -0800
Message-ID: <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 03:39:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGmYv-0005ob-5n
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 03:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbYAUCiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 21:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYAUCiI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 21:38:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50912 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280AbYAUCiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2008 21:38:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A2A793821;
	Sun, 20 Jan 2008 21:38:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1AFC3820;
	Sun, 20 Jan 2008 21:38:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71210>

Here is an update to the list I sent earlier.

Topics that I thought may deserve attention, discussion and
eventual inclusion but are not 1.5.4 material.

I think these two could be part of 1.5.4, but I left them out of
1.5.4-rc4 (IOW, I do not think they should be on this list):

 * marking output from "diff --{no,src,dst}-prefix" as a non-git
   diff (me)

   Linus had an objection but I think I made a reasonable
   argument against that.  Haven't heard back since then, so
   this is in limbo.

 * submodule subcommand parser fix for "git submodule add init
   update" (Imran M Yousuf and me)

   As Jakub noticed, this is meant to be a bugfix but as I do
   not use submodule heavily myself, backing it with real-world
   success stories would be needed.

Now these two out of our way, here is the list.

 * various lstat(2) reduction changes (me, Linus and Dscho).

   This will be queued in 'pu'; it appears this introduces a
   timing related breakages in t75?? tests.

 * compress/decompress abstraction (Marco)

 * crlf (Steffen Prohaska and Dmitry Potapov)

 * whitespace error: "cr at eol is ok" (me)

 * submodule recursive wrapper (Imran M Yousuf)

 * 'origin' is not so special after "clone -o frotz" (Mark Levedahl)

 * "submodule summary" (Ping Yin)

 * unconfigured ident safety (Stephen Sinclair)

 * gitweb feed from commit to commitdiff (Florian La Rouche --
   Jakub seems to be on top of this so I am not worried about it
   too much).

 * color.ui (Matthias Kestenholz)

 * test scripts to use valgrind (Jeff King)

 * "rebase -i" UI -- should it be simplified to do commit --amend
   itself? (Dscho)

 * "cherry-pick/revert" error message fix (Bj=C3=B6rn Steinbrink and me=
)

 * pathname safety on filesystems whose readdir(3) thinks it
   knows better than users (Linus, Robin Rosenberg, me and
   others).

   I tend to prefer a much simpler approach Linus suggested, to
   wrap readdir(3) on systems that are known to mangle files,
   but I have a slight suspicion it would not work well enough
   for cross platform projects.

Again, I am hoping that authors will resend the ones they really
care about after 1.5.4, as I do not want to take patches early.

The previous version of this list did not include the some that
were discussed and landed in 'pu' (or 'offcuts').  The ones that
we may want to polish that are in 'pu' are:

 * omit cc recipients from send-email (David Brown)

 * sha1 lookup optimization (me)

 * rewrite cherry-pick/revert in order to improve its D/F
   conflict resolution (me)

 * allow native protocol to tell exactly which branch HEAD
   points at (me)

There is also 1.6.0 material queued already, way before the rc
cycle:

 * Moving "git-foo" out of users' $PATH (Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy)

I suspect it might be a good idea to make an early declaration
that 1.5.5 is to resolve the above listed issues plus the ones
already in 'pu' (and nothing else), and have a fairly short
cycle after 1.5.4.
