From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 25 Nov 2007 21:36:14 +0100
Organization: At home
Message-ID: <ficmbr$s87$1@ger.gmane.org>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 21:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwODb-0007jF-IM
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbXKYUgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756353AbXKYUgZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:36:25 -0500
Received: from main.gmane.org ([80.91.229.2]:48219 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756335AbXKYUgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:36:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IwODD-000681-K7
	for git@vger.kernel.org; Sun, 25 Nov 2007 20:36:19 +0000
Received: from abvz27.neoplus.adsl.tpnet.pl ([83.8.223.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 20:36:19 +0000
Received: from jnareb by abvz27.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 20:36:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvz27.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65990>

Junio C Hamano wrote:

> [Actively cooking]
>=20
> * jc/spht (Sat Nov 24 11:57:41 2007 -0800) 6 commits
> =A0+ core.whitespace: documentation updates.
> =A0+ builtin-apply: teach whitespace_rules
> =A0+ builtin-apply: rename "whitespace" variables and fix styles
> =A0+ core.whitespace: add test for diff whitespace error highlighting
> =A0+ git-diff: complain about >=3D8 consecutive spaces in initial ind=
ent
> =A0+ War on whitespace: first, a bit of retreat.
>=20
> Now apply also knows about the customizable definition of what
> whitespace breakages are, and I was reasonably happy. But Bruce kicke=
d
> it back from "scheduled to merge" to "still cooking" status, remindin=
g
> that we would want to have this not a tree-wide configuration but
> per-path attribute. =A0And I agree with him.

Currently apply.whitespace is per repository - would this be changed
as well, i.e. would it be moved to gitattributes together with custom
diff drivers (or at least custom funcnames), custom merge drivers,
making it per-project (if put under version control) and per-path?


By the way, i18n.commitEncoding is per repository, and used to affect
repository; not so with the "encoding" header in commit object.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
