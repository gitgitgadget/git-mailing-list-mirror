From: Junio C Hamano <gitster@pobox.com>
Subject: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 01:41:43 -0800
Message-ID: <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	=?utf-8?Q?Gr=C3=A9goire?= Barbier <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 10:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFnk3-0008F8-3w
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 10:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbYARJl5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 04:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbYARJl4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 04:41:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755762AbYARJlz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2008 04:41:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E721E5B92;
	Fri, 18 Jan 2008 04:41:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DB245B8F;
	Fri, 18 Jan 2008 04:41:50 -0500 (EST)
In-Reply-To: <7vir1xmazm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Jan 2008 17:50:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70983>

Junio C Hamano <gitster@pobox.com> writes:

> Currently the ones I looked at and consider possible 1.5.4
> material are http-push fixes from Gr=C3=A9goire Barbier and
> parse_commit_buffer() tightening from Martin Koegler.

It seems that for the past few days, people were having too much
fun bashing how broken MacOS X is, and the real work has stalled
in the meantime.  Well, not really stalled but they certainly
made the patches and discussions harder to find in the list
archive.

But that's Ok.  You cannot win every battle.

Now the lack of unsetenv can be autodetected, and coloring
breakage of --color-words has been fixed.  We have also managed
to catch a real breakage in fast-import, but somebody seems to
have managed to bash OS X even in that thread ;-)

But there are still unapplied patches that deserve attention.
The one that I am most worried about is Gr=C3=A9goire Barbier's
http-push changes:

  $gmane/70406 <1200250979-19604-1-git-send-email-gb@gbarbier.org>
  $gmane/70407 <1200250979-19604-2-git-send-email-gb@gbarbier.org>
  $gmane/70405 <1200250979-19604-3-git-send-email-gb@gbarbier.org>

They look sensible on paper. I do not, however, use http-push
myself, and I'd really like an independent success (or failure)
reports on them.  I can also threaten to apply them and see if
it breaks for anybody, which I may end up doing.

Martin Koegler's parse_commit_buffer() tightening is much easier:

  $gname/70478 <12003456313661-git-send-email-mkoegler@auto.tuwien.ac.a=
t>

It needs a proper commit message; the patch itself is good.  I
could write one myself but I'd rather want description from the
real contributor.

  gmane =3D http://news.gmane.org/gmane.comp.version-control.git
