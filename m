From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 12:43:32 +0200
Message-ID: <20070509104332.GA14214@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070508210153.GA3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705082306100.4167@racer.site> <20070508213158.GB3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705090105450.4167@racer.site> <Pine.LNX.4.64.0705090015360.18541@iabervon.org> <Pine.LNX.4.64.0705091137190.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, bfields@citi.umich.edu,
	junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 12:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HljeB-0002B7-0S
	for gcvg-git@gmane.org; Wed, 09 May 2007 12:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757391AbXEIKnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 May 2007 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbXEIKnm
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 06:43:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1418 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbXEIKnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 06:43:41 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hljdt-0003jX-00; Wed, 09 May 2007 11:43:33 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705091137190.4167@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46694>

On 2007-05-09 11:38:34 +0200, Johannes Schindelin wrote:

> On Wed, 9 May 2007, Daniel Barkalow wrote:
>
> > It's kind of important to distinguish between the hex
> > representation and the octet representation, because your code
> > will not work at all if you use the wrong one. And "unsigned char
> > *" or "unsigned char[20]" is always the octets; the hex is always
> > "char *". Primarily mentioning the one that is more intuitive but
> > less frequently used doesn't help with understanding the actual
> > code.
>
> That's a really good idea, to point out that "unsigned char *"
> refers to octets, while "char *" refers to the ASCII representation.
> I will add this, together with a simple example (the initial
> commit).

That'll address my complaint nicely, I believe. It was the confusion
between these two formats that I was trying to get at.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
