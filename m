From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 12:09:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191208300.4059@racer.site>
References: <f2t6na$5bi$1@sea.gmane.org> <11821227322913-git-send-email-frank@lichtenheld.de>
 <Pine.LNX.4.64.0706190151160.4059@racer.site> <7v645kyba8.fsf@assigned-by-dhcp.pobox.com>
 <20070619021252.GE19725@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 13:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0baT-0003Rw-6h
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 13:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbXFSLJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 07:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755601AbXFSLJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 07:09:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:60016 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755572AbXFSLJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 07:09:27 -0400
Received: (qmail invoked by alias); 19 Jun 2007 11:09:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 19 Jun 2007 13:09:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hnEFJSGghbCkowEorM3YRQpauFI2KxbZ6ie5A0u
	IM/6598/5esHBm
X-X-Sender: gene099@racer.site
In-Reply-To: <20070619021252.GE19725@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50467>

Hi,

On Tue, 19 Jun 2007, Frank Lichtenheld wrote:

> On Mon, Jun 18, 2007 at 06:37:35PM -0700, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Another possibility, though, is to say:
> > 
> > 	core.some\0where\0core.over\0\0core.the\0core.rainbow\0
> 
> How do you denote empty values then?
> 
> [section]
> 	key=
> 	key
> 
> this are two very different statements atm (e.g. the one is false and
> the other one is true).
> 
> I still think using two different delimiters is the simplest choice.

Okay, good point. But of course, you have to use a delimiter for the key 
name that cannot be part of the keyname. You picked '\n'. The original was 
'='. Both work.

Ciao,
Dscho
