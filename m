From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: Problem with gitk on cygwin
Date: Fri, 30 Mar 2007 09:36:22 +0200
Organization: Softwarelandschaft
Message-ID: <000201c7729e$1d7c40b0$0b0aa8c0@abf.local>
References: <20070330052533.GQ13247@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 09:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXBeB-0007va-KD
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 09:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbXC3Hfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 03:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbXC3Hfk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 03:35:40 -0400
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:47651 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752274AbXC3Hfk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2007 03:35:40 -0400
Received: (qmail 809 invoked from network); 30 Mar 2007 09:41:03 +0200
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 30 Mar 2007 09:41:03 +0200
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
In-Reply-To: <20070330052533.GQ13247@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> From: spearce@spearce.org [mailto:spearce@spearce.org] 
> 
> I have seen this failure before, and its usually a result of 
> having your CYGWIN environment variable including 'notty':
> 
>   http://www.cygwin.com/cygwin-ug-net/using-cygwinenv.html
> 
> Or maybe its the opposite.  I don't have access to my Cygwin 
> system right now, so I cannot check if I have notty, tty, or 
> just ommitted it entirely from my CYGWIN environment varible. 
>  But I think that's the issue.

Thanks a lot, that was the right pointer, even if I don't
understand what went wrong.
My CYGWIN environment variable was set to "ntsec tty", and after
doing a 
export CYGWIN=ntsec
in the shell (which according to your link shouldn't change
anything) gitk magically started working!

> Shawn.

Thank you very much my saviour, now I can use gitk in office too ;-)

-- 
best regards

  Ray 
