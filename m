From: Junio C Hamano <gitster@pobox.com>
Subject: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 02:40:03 -0800
Message-ID: <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 11:40:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoeT-0002ZY-4V
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151AbYARKkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 05:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759963AbYARKkN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:40:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759525AbYARKkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2008 05:40:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0D3678D;
	Fri, 18 Jan 2008 05:40:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B4680678C;
	Fri, 18 Jan 2008 05:40:05 -0500 (EST)
In-Reply-To: <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 18 Jan 2008 01:41:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70993>

Here is an update to the list I sent earlier.  Topics that I
thought may deserve attention, discussion and eventual inclusion
but are not 1.5.4 material.

I think some of them actually have a slight chance of being
1.5.4 material, if interested parties present good enough
arguments that they are actually good and safe bugfixes.

 * compress/decompress abstraction (Marco)

 * crlf (Steffen Prohaska and Dmitry Potapov)

 * whitespace error: "cr at eol is ok" (me)

 * moving archive related helpers to libgit.a (Lars Hjemli)

 * marking output from "diff --{no,src,dst}-prefix" as a non-git
   diff (me)

 * submodule subcommand parser fix for "git submodule add init
   update" (Imran M Yousuf and me)

 * submodule recursive wrapper (Imran M Yousuf)

 * 'origin' is not so special after "clone -o frotz" (Mark Levedahl)

 * "submodule summary" (Ping Yin)

 * unconfigured ident safety (Stephen Sinclair)

 * gitweb feed from commit to commitdiff (Florian La Rouche --
   Jakub seems to be on top of this so I am not worried about it
   too much).

 * color.ui (Matthias Kestenholz)

 * test scripts to use valgrind (Jeff King)

 * various lstat(2) reduction changes (me).

 * "rebase -i" UI -- should it be simplified to do commit --amend
   itself? (Dscho)

 * "cherry-pick/revert" error message fix (Bj=C3=B6rn Steinbrink and me=
)

 * pathname safety on filesystems whose readdir(3) thinks it
   knows better than users (Linus, Robin Rosenberg, me and
   others).

Again, I am hoping that authors will resend the ones they really
care about after 1.5.4, as I do not want to take patches early.
