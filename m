From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-reset: make the output as the fetch output
Date: Wed, 17 Jan 2007 16:35:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171634160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87odox23u9.fsf@gmail.com> 
 <Pine.LNX.4.63.0701171441250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <8aa486160701170723j5767f0d3jd3eb4b8817413195@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1571847763-1169048153=:22628"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 16:36:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7CpR-0002oF-KT
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 16:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbXAQPf4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 10:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbXAQPf4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 10:35:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:49822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932474AbXAQPfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 10:35:55 -0500
Received: (qmail invoked by alias); 17 Jan 2007 15:35:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 17 Jan 2007 16:35:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8aa486160701170723j5767f0d3jd3eb4b8817413195@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37010>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1571847763-1169048153=:22628
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

[reCc'ing list]

On Wed, 17 Jan 2007, Santi Béjar wrote:

> On 1/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > IMHO your version is less helpful than the current behaviour: now it
> > shows the oneline (which your version doesn't), and in most cases you
> > reset from a dirty state (at least I _exclusively_ use reset in such
> > situations), where "from..to" does not make any sense.
> 
> My motivation is to have a coherent output. I recognize that the ..
> notation in fetch (fastforwarding) does not generally make sense in
> reset. Could be better
> 
> * HEAD: reset to ...
>  old: $hash
>  new: $hash
> 
> If I want to see the commit title I do a "git branch -v".

The whole point of tags/v1.5.0-rc0~44 was to _avoid_ "git branch -v", or 
"git show HEAD".

Ciao,
Dscho

---1148973799-1571847763-1169048153=:22628--
