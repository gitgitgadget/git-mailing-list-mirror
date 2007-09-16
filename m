From: David Soria <sn_@gmx.net>
Subject: Re: RFC: German translation vocabulary
Date: Sun, 16 Sep 2007 15:01:04 +0000 (UTC)
Message-ID: <fcjgfg$56m$1@sea.gmane.org>
References: <200709161438.37733.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 17:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWvdT-0002zY-8y
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 17:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbXIPPCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 11:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbXIPPCG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 11:02:06 -0400
Received: from main.gmane.org ([80.91.229.2]:48284 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbXIPPCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 11:02:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IWvcd-00042s-Dv
	for git@vger.kernel.org; Sun, 16 Sep 2007 17:01:19 +0200
Received: from p54965ee9.dip.t-dialin.net ([84.150.94.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 17:01:19 +0200
Received: from sn_ by p54965ee9.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 17:01:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54965ee9.dip.t-dialin.net
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58316>

Am Sun, 16 Sep 2007 14:38:37 +0200 schrieb Christian Stimming:



Hi Christian,

thank you for bringing up the topic, it's really worth discussing it.

> [commit] message - Meldung (Nachricht?; Source Safe: Kommentar)
I prefer "Kommentar" here. It describes better what the commit message =
is
about. "Meldung" has some co-notations that don't fit (like e.g.
"Meldung" often involes other people, like you "meldest" something to
somebody).
=20
> I'm still rather unsure what to do about them. One problem here is th=
at
> both words are used in several different meanings all at once. For
> example, the "commit [noun]" is used interchangeably with "revision".
> I'm actually inclined to translate it with "Version" for exactly that
> reason. And then "checkout": The noun is probably used interchangeabl=
y
> with "working copy". Hence, it could be translated as such. OTOH the
> verb means "to update the working copy", and it could be translated a=
s
> such instead of one single word. This would leave only "commit [verb]=
"
> as the last tricky issue for which a single-word translation must be
> found. "=C3=BCbertragen" is my current favorite but I'm absolutely op=
en for
> further proposals here.
>=20
> As you can see in the glossary file, I'm still unhappy with the
> translations for those, but anyway here's the current status (not tak=
ing
> into account the discussion of the previous paragraph so far):
>=20
Really hard. I would prefer some larger explanations if they fit into t=
he
application and make sense on every label in the gui.


> msgid "commit [noun]"
> msgstr "=C3=9Cbertragung (Sendung?, =C3=9Cbergabe?, Einspielung?, Abl=
agevorgang?)"
=C3=9Cbertragung fits well, but for me it has a co-notation that someth=
ing is
transfered from one point to another (e.g. using an internet connection=
)
So this translation would fit perfectly for centralized versioning
systems, where the changeset is really "transfered" to somewhere. I wou=
ld
prefer the term "Einspielung" as I think it reflects better, that the
commit is locally.

David
