From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 21:21:11 +0200
Message-ID: <20071003192111.GA14277@uranus.ravnborg.org>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <7vprzwhkgd.fsf@gitster.siamese.dyndns.org> <39F3EE1B-7BD4-4927-AB90-2EB4BBAF05D0@wincent.com> <85abr0y5ua.fsf@lola.goethe.zz> <1D18C52E-BB96-49EC-97A9-F802D56CAFF5@wincent.com> <7vd4vwfou9.fsf@gitster.siamese.dyndns.org> <20071003174659.GA13691@uranus.ravnborg.org> <Pine.LNX.4.64.0710031957170.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 21:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id9lC-0000lw-47
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 21:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbXJCTTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbXJCTTo
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 15:19:44 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:52489 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbXJCTTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 15:19:44 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id B0B71801698;
	Wed,  3 Oct 2007 21:19:40 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 2611B580D2; Wed,  3 Oct 2007 21:21:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710031957170.28395@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59869>

On Wed, Oct 03, 2007 at 07:57:48PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 3 Oct 2007, Sam Ravnborg wrote:
> 
> > For a kernel integrated tool the dependencies shall be minimal which is 
> > where asciidoc fails today.
> 
> Is perl not too much already?

No - perl has not proved to be a problem.
But like git we have had a smaller share of docbook
incompatibilities.

We even require perl for a regular kernel build
for some arch's these days.

	Sam
