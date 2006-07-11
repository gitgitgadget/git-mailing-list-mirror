From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 23:25:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607112324330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607111153170.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607112116270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607111241460.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 23:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0PjP-0004qW-OY
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 23:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWGKVZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 17:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWGKVZU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 17:25:20 -0400
Received: from mail.gmx.net ([213.165.64.21]:32724 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751160AbWGKVZT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 17:25:19 -0400
Received: (qmail invoked by alias); 11 Jul 2006 21:25:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 11 Jul 2006 23:25:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607111241460.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23736>

Hi,

On Tue, 11 Jul 2006, Linus Torvalds wrote:

> On Tue, 11 Jul 2006, Johannes Schindelin wrote:
> > 
> > > Or, more likely, the parse_sha1_header() function should just be changed 
> > > to check the binary format first (and then add your comment about why that 
> > > is safe).
> > 
> > Yes, exactly.
> 
> Here's a newer verson of [2/3], with these issues fixed. It actually fixes 
> things twice: (a) by parsing the binary version first (which makes sense 
> for a totally independent reason - if that is going to be the "default" 
> version in the long run, we should just test it first anyway) and (b) by 
> making the ASCII version parser stricter too.

Melikey.

Ciao,
Dscho
