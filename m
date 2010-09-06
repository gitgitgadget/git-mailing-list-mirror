From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Mon, 06 Sep 2010 18:24:58 +0200
Message-ID: <4C8515DA.9010109@web.de>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com> <4c8197ab.1707e30a.3f10.714a@mx.google.com> <201009061741.27840.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: avarab@gmail.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Sam Reed <sam@reedyboy.net>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 06 18:25:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OseVS-0004pG-9H
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 18:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab0IFQZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 12:25:04 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47565 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab0IFQZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 12:25:03 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 170641676F721;
	Mon,  6 Sep 2010 18:25:01 +0200 (CEST)
Received: from [93.240.118.225] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OseVA-0007aG-00; Mon, 06 Sep 2010 18:25:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <201009061741.27840.trast@student.ethz.ch>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19pghiDGJZddqCSHnN3yGOcJd4Q+NeQ5QbTjyUh
	Aszu19k5v6K/B9m61a78/e5zLN2Ns1DuESOdzmx0DugMOu7yGk
	m8k4/tlMuFZymBpAut+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155581>

Am 06.09.2010 17:41, schrieb Thomas Rast:
> I already like the translation way better than the one that
> gitk/git-gui have, because it doesn't try so hard to translate *every=
*
> term.

=46ull Ack, I can't find my way through git-gui or gitk when I forget
to start them with "LC_ALL=3DC" (And when you use git mainly via these
guis, you will have to learn /every/ git command again when you
start using the command line). IMHO terms that have a special in git
should not be translated, so I would even vote for leaving terms like
"fetch", "fast-forward" and maybe even "tracking-branch" as they are.

But however, translations should be consistent between gitk/git-gui
and the command line, no? E.g. tracking branch is "=DCbernahmezweig"
(whatever that means) there and "verfolgter Branch" here ... :-/


> [probably out of order, I found it while compiling the glossary]
>> +msgid "detached HEAD"
>> +msgstr "von HEAD abgetrennt"
>=20
> That's not strictly speaking true; HEAD always points to a commit
> except in an unborn branch, and in any case (this is from commit.c)
> points to a commit after this message is output.  You could try
> "abgetrennter HEAD", "entkoppelter HEAD" or so...

Yup, maybe "abgel=F6ster HEAD" or "loser HEAD" (even if the latter may
sound funny when parsed in English ;-)
