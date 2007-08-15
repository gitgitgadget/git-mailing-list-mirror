From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-cvsexportcommit getting out of sync with CVS status requests
Date: Wed, 15 Aug 2007 18:11:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708151810000.19496@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1187178510.13096.46.camel@murta.transitives.com>
 <1187182726.13096.50.camel@murta.transitives.com> <46C3218E.6020309@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: alex.bennee@transitive.com, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLSl-0002Yq-2U
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbXHOQLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758214AbXHOQLI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:11:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:47151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757066AbXHOQLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:11:07 -0400
Received: (qmail invoked by alias); 15 Aug 2007 16:11:05 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 15 Aug 2007 18:11:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PWh0+DBlP2ltS6bG1hhic3JeLbe4Xq5rmVzAMW8
	RyV//Tmt2J19M6
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <46C3218E.6020309@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55916>

Hi,

On Wed, 15 Aug 2007, Simon 'corecode' Schubert wrote:

> Alex Bennee wrote:
> > It looks like running a single CVS query for each file is the only
> > solution.
> 
> I think internally CVS is doing single queries anyways.  At least that 
> was my impression.

Why then was cvsexportcommit so much slower without 
c56f0d9c661dc918a088e60d0ab69dd48019a9be?

Ciao,
Dscho
