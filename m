From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Wed, 9 Jul 2008 13:43:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807091341230.5277@eeepc-johanness>
References: <11911047823308-git-send-email-jean.guyader@linkea.org> <7v8x6pjb4c.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709300039430.28395@racer.site> <7v4phdja01.fsf@gitster.siamese.dyndns.org> <7v4p6zmx0l.fsf@gitster.siamese.dyndns.org>
 <20080709055150.GA28482@glandium.org> <7vlk0blgg0.fsf@gitster.siamese.dyndns.org> <20080709075345.GA22022@glandium.org> <7vhcazlbch.fsf@gitster.siamese.dyndns.org> <20080709085651.GA23453@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, jean.guyader@linkea.org,
	git@vger.kernel.org, Jean Guyader <jean.guyader@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:44:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGY5T-0007Pz-A5
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 13:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbYGILm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 07:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbYGILm4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 07:42:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:37333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753649AbYGILmz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 07:42:55 -0400
Received: (qmail invoked by alias); 09 Jul 2008 11:42:53 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp009) with SMTP; 09 Jul 2008 13:42:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iayx+ABPiO7lniUh+EfazUmtEa5C33F8ioJZ0Xi
	mv2tud6DIYIJ34
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080709085651.GA23453@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87870>

Hi,

On Wed, 9 Jul 2008, Mike Hommey wrote:

> Note that http://user:pass@server/path/ /should/ work (but that would 
> need validation), though not a good idea on command line.

Well, now that the programs using URLs are all builtins, we can actually 
do something about it.  We can edit out the "user[:pass]@" part out of 
argv, which usually means that "ps" will not see it anymore.

Ciao,
Dscho
