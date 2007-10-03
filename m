From: Wincent Colaiuta <win@wincent.com>
Subject: Re: WIP: asciidoc replacement
Date: Wed, 3 Oct 2007 08:40:06 +0200
Message-ID: <06B9DBA8-596F-4576-8995-8044EA714384@wincent.com>
References: <Pine.LNX.4.64.0710030133020.28395@racer.site> <4702F6BB.60908@vilain.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 08:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcxuD-00038U-Jz
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 08:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbXJCGkO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 02:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbXJCGkO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 02:40:14 -0400
Received: from wincent.com ([72.3.236.74]:46275 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbXJCGkN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 02:40:13 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l936e9tY010045;
	Wed, 3 Oct 2007 01:40:10 -0500
In-Reply-To: <4702F6BB.60908@vilain.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59795>

El 3/10/2007, a las 3:56, Sam Vilain escribi=F3:

> However I have a suspicion that your script is doing line-based =20
> parsing
> instead of recursive descent; I don't know whether that's the right
> thing for asciidoc.  It's actually fairly easy to convert a grammar t=
o
> code blocks using tricks from MJD's _Higher Order Perl_.  Is it
> necessary for the asciidoc grammar?

I haven't looked at all of the asciidoc source for the Git =20
documentation but I suspect that almost all of it is entirely =20
regular, and if there is any nesting in it is is probably of a =20
limited scope (ie. sections, subsections, subsubsections in the user =20
manual) and so you can avoid the complexity of a full recursive =20
descent parser. I'd also expect Johannes' approach to be faster (is =20
it faster than the existing tool chain? I would expect so).

Cheers,
Wincent
