From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Wed, 20 Jun 2007 11:31:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706201129550.4059@racer.site>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de>
 <Pine.LNX.4.64.0706190151160.4059@racer.site> <7v645kyba8.fsf@assigned-by-dhcp.pobox.com>
 <20070619021252.GE19725@planck.djpig.de> <Pine.LNX.4.64.0706191208300.4059@racer.site>
 <20070619152139.GF19725@planck.djpig.de> <Pine.LNX.4.64.0706191655490.4059@racer.site>
 <20070619172619.GH19725@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jun 20 12:31:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0xSx-00047I-5H
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 12:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbXFTKbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 06:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbXFTKbH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 06:31:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:60100 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751344AbXFTKbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 06:31:05 -0400
Received: (qmail invoked by alias); 20 Jun 2007 10:31:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 20 Jun 2007 12:31:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DQUN8MiTDxeOhcJoJSPtY8TekCCa/TS2gSqfv+U
	H9iXTXcXchZ4Pm
X-X-Sender: gene099@racer.site
In-Reply-To: <20070619172619.GH19725@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50555>

Hi,

On Tue, 19 Jun 2007, Frank Lichtenheld wrote:

> On Tue, Jun 19, 2007 at 04:57:21PM +0100, Johannes Schindelin wrote:
> > [foo "bar\nbaz"]
> > 	key = value
> > gives
> > 
> > foo.barbaz.key=value
> 
> for me this gives
> 
> foo.barnbaz.key=value

Yes, of course I had to have a typo in my message. *sigh*

The point is, that I would not expect a "\" to be _ignored_. Either 
interpreted, or throwing an error, but just ignored?

Ciao,
Dscho
