From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Fix typos in git-remote.txt and git-symbolic-ref.txt
Date: Tue, 11 Aug 2009 09:09:32 +0200
Message-ID: <200908110909.33904.trast@student.ethz.ch>
References: <20090811005207.GE24183@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?q?=C5=A0t=C4=9Bp=C3=A1n?= =?utf-8?q?_N=C4=9Bmec?= 
	<stepan.nemec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 13:50:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MapsN-0006tQ-Hy
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 13:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbZHKLuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 07:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbZHKLuj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:50:39 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:13241 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbZHKLui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 07:50:38 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 09:09:48 +0200
Received: from thomas.localnet (129.132.208.187) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 11 Aug
 2009 09:09:49 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090811005207.GE24183@headley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125514>

Thanks for the updated version!

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
>=20
> I did look at some of the other documentation files (and now also gre=
pped
> the whole directory for `--' and `\--' occurences), but wasn't able t=
o see
> any rule or consistence in the usage. Whether it is an indication of
> real inconsistence or just another example of my ignorance I do not k=
now
> (not now, at least).

Well, as I said I'm not sure what asciidoc versions, if any, needed
the backslash inside backtick quoting.  However, there is precedent in

commit e1ccf53a60657930ae7892387736c8b6a91ec610
Author: Yasushi SHOJI <yashi@atmark-techno.com>
Date:   Mon Sep 12 02:29:10 2005 +0900

    [PATCH] Escape asciidoc's built-in em-dash replacement

    AsciiDoc replace '--' with em-dash (&#8212) by default. em-dash
    looks a lot like a single long dash and it's very confusing when
    we are talking about command options.

    Section 21.2.8 'Replacements' of AsciiDoc's User Guide says that a
    backslash in front of double dash prevent the replacement.  This
    patch does just that.

    Signed-off-by: Yasushi SHOJI <yashi@atmark-techno.com>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

So until we know for certain that they're not needed, I'd rather not
actively remove them.  Admittedly, there are lots of instances of `--
in the docs too, so making sure which way is "right" and then
replacing _all_ of them would probably be a nice cleanup.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
