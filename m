From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: Problems with git cvsimport
Date: Tue, 27 Feb 2007 14:12:42 +0100
Organization: Softwarelandschaft
Message-ID: <002001c75a70$f69586e0$0b0aa8c0@abf.local>
References: <Pine.LNX.4.63.0702271318070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	"'Raimund Bauer'" <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 14:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM2Er-0003Tj-4w
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 14:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbXB0NT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 08:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933054AbXB0NT0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 08:19:26 -0500
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:60779 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750884AbXB0NTZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 08:19:25 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Feb 2007 08:19:25 EST
Received: (qmail 19930 invoked from network); 27 Feb 2007 14:17:57 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 27 Feb 2007 14:17:57 +0100
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <Pine.LNX.4.63.0702271318070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40729>

> > When trying to cvsimport a project into git, I get an error from 
> > cvsps:
> > 
> > bad usage: invalid argument -A
> 
> What was your command line?

The complete command line was

git-cvsimport -d :pserver:ray007@cvs.drupal.org:/cvs/drupal-contrib -C views
-k contributions/modules/views

Leaving out -k doesn't change anything.
And the manpage for git-cvsimport says, option -A is implicit ...

> Ciao,
> Dscho

-- 
best regards

  Ray
