From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: Problems with git cvsimport
Date: Tue, 27 Feb 2007 17:15:50 +0100
Organization: Softwarelandschaft
Message-ID: <002d01c75a8a$8c664dd0$0b0aa8c0@abf.local>
References: <Pine.LNX.4.63.0702271700300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:16:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4zc-0003FL-GO
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbXB0QPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbXB0QPx
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:15:53 -0500
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:33978 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbXB0QPw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Feb 2007 11:15:52 -0500
Received: (qmail 24385 invoked from network); 27 Feb 2007 17:21:06 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 27 Feb 2007 17:21:06 +0100
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <Pine.LNX.4.63.0702271700300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40757>

> > > > When trying to cvsimport a project into git, I get an error from
> > > > cvsps:
> > > > 
> > > > bad usage: invalid argument -A
> > > 
> > > What was your command line?
> > 
> > The complete command line was
> > 
> > git-cvsimport -d 
> :pserver:ray007@cvs.drupal.org:/cvs/drupal-contrib -C 
> > views -k contributions/modules/views
> 
> Sorry to have missed that earlier. AFAIR cvsimport _needs_ 
> cvsps 2.1. You 
> have version 2.0rc1, which is not sufficient...

Thanks, I will make sure we get a new cvsps on the server.

> Ciao,
> Dscho

-- 
best regards

  Ray
