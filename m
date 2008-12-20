From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 23:37:28 +0200
Message-ID: <878wqaplyf.fsf@iki.fi>
References: <200812191314.19302.markus.heidelberg@web.de>
	<200812201418.38707.markus.heidelberg@web.de>
	<7v3agiy5gs.fsf@gitster.siamese.dyndns.org>
	<200812202213.45029.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Dec 20 22:39:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE9XG-0000mr-Kc
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 22:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYLTVhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Dec 2008 16:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYLTVhk
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 16:37:40 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:58883 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbYLTVhj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 16:37:39 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C702CC0FA2; Sat, 20 Dec 2008 23:37:37 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LE9Vo-0001Od-Ah; Sat, 20 Dec 2008 23:37:28 +0200
In-Reply-To: <200812202213.45029.markus.heidelberg@web.de> (Markus Heidelberg's message of "Sat\, 20 Dec 2008 22\:13\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103669>

Markus Heidelberg (2008-12-20 22:13 +0100) wrote:

> Junio C Hamano, 20.12.2008:
>>               f   l   o   g   =3D 342 200 231   1   0   ,   1       =
h   o   u
                                   ^^^^^^^^^^^

This is $E2 $80 $99 in hex and it's the UTF-8 sequence for U+2019 RIGHT
SINGLE QUOTATION MARK (=E2=80=99).

> I get this instead:

>                 e   f   l   o   g   =3D 302 264   1   0   ,   1      =
 h   o   u
                                        ^^^^^^^

And this is $C2 $B4 in hex and it's U+00B4 ACUTE ACCENT (=C2=B4) in UTF=
-8
encoding. This is what I get too with groff, in terminal and PostScript=
=2E
Weird that Junio is getting different output for \' in the man page
source.

But this is nothing yet, Emacs' "M-x woman" renders them as _grave
accents_ aka backticks (`, U+0060 GRAVE ACCENT). Nice.
