From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 19:46:59 +0200
Message-ID: <20071003174659.GA13691@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <7vprzwhkgd.fsf@gitster.siamese.dyndns.org> <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com> <85abr0y5ua.fsf@lola.goethe.zz> <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com> <7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, David Kastrup <dak@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 19:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id8I1-0002jb-SI
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 19:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917AbXJCRpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 13:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbXJCRpc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 13:45:32 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:47131 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661AbXJCRpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 13:45:32 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 14AE4E321CB;
	Wed,  3 Oct 2007 19:45:29 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 7ACB3580D2; Wed,  3 Oct 2007 19:46:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4vwfou9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59861>

Hi Junio.
> 
> In short, although I do appreciate Johannes's and Sam's attempt,
> I would really prefer to see us pick some externally maintained
> alternative, instead of inventing a homebrew system that we need
> to maintain ourselves.  It is rumored that git has much higher
> developer count vs loc count ratio than many other open source
> projects, doing the documentation format is not part of our
> project, and I'd rather see them spend time working on git, not
> building and maintaining AsciiDoc lookalike.

For the kernel I would like to see a tool that does:

o Based on nicely formatted ascii/utf-8 be able to:
 - Generate good looking and easy to read HTML
 - Possible generate other output formats too

And if the kernel folks do not like it then at least the possibility
to run this on kbuild documentation locally so I can generate nice
html docs for that part.

For a kernel integrated tool the dependencies shall be minimal which
is where asciidoc fails today. If asciidoc people could address this
issue for the simpler output format then the tool IMO would
have a much stronger position.

	Sam
