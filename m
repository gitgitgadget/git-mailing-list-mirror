From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "malloc failed"
Date: Tue, 27 Jan 2009 19:02:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271900260.3586@pacific.mpi-cbg.de>
References: <878wow7pth.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 19:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRsI2-0006U9-QH
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 19:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbZA0SCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 13:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755927AbZA0SCf
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 13:02:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:37360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755846AbZA0SCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 13:02:35 -0500
Received: (qmail invoked by alias); 27 Jan 2009 18:02:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 27 Jan 2009 19:02:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/c05EmWPXcz5uGpv/SwpjpkzAvp8yQW4chv54dGB
	b0TcnCC3TqW/t3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <878wow7pth.fsf@mcbain.luannocracy.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107374>

Hi,

On Tue, 27 Jan 2009, David Abrahams wrote:

> I've been abusing Git for a purpose it wasn't intended to serve: 
> archiving a large number of files with many duplicates and 
> near-duplicates.

Hah!  My first UGFWIINI contender!  Unfortunately, I listed that purpose 
explicitely already...

> Every once in a while, when trying to do something really big, it tells 
> me "malloc failed" and bails out (I think it's during "git add" but 
> because of the way I issued the commands I can't tell: it could have 
> been a commit or a gc).  This is on a 64-bit linux machine with 8G of 
> ram and plenty of swap space, so I'm surprised.

Yes, I am surprised, too.  I would expect that some kind of arbitrary 
user-specifiable limit hit you.  Haven't had time to look at the code, 
though.

Ciao,
Dscho
