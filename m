From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Fri, 11 Jul 2008 16:48:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111647080.8950@racer>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>  <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>  <7vprpnlglh.fsf@gitster.siamese.dyndns.org>  <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com> 
 <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>  <alpine.DEB.1.00.0807101526380.18205@racer>  <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>  <7v3amglxmb.fsf@gitster.siamese.dyndns.org>  <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
  <alpine.DEB.1.00.0807111635400.8950@racer> <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:49:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHKsD-0003NC-Eg
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 17:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922AbYGKPsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 11:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbYGKPsa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 11:48:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:57530 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751944AbYGKPsa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 11:48:30 -0400
Received: (qmail invoked by alias); 11 Jul 2008 15:48:28 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp004) with SMTP; 11 Jul 2008 17:48:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0yYVeGwi0iU56ZLsa6P+VHSzeKwNGSqeUmZPsSe
	F+SsokJGu45amP
X-X-Sender: gene099@racer
In-Reply-To: <7f9d599f0807110841r329dfb95g786a576bd981dd1b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88131>

Hi,

On Fri, 11 Jul 2008, Geoffrey Irving wrote:

> On Fri, Jul 11, 2008 at 8:36 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > Why so complicated?  I mean, you can count in that "infinite" loop 
> > yourself, no?
> 
> Yeah, I was just trying to avoid the extra termination condition, 
> because I don't think it adds any real safety.

Sorry.  You absolutely lost me.  While doing the loop over the entries, 
trying to find an entry, adding a counter, and exiting when the counter 
reaches the total number of slots does not add any real safety?

Puzzled,
Dscho
