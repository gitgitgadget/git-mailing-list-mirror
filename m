From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: Merging commits together into a super-commit
Date: Thu, 10 May 2007 13:19:08 +0200
Organization: Softwarelandschaft
Message-ID: <000e01c792f5$0861abd0$0b0aa8c0@abf.local>
References: <1178794261.5806.98.camel@murta.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Alex Bennee'" <kernel-hacker@bennee.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 10 13:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm6gN-0008V7-K7
	for gcvg-git@gmane.org; Thu, 10 May 2007 13:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXEJLTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 07:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbXEJLTe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 07:19:34 -0400
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:33851 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049AbXEJLTe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 07:19:34 -0400
Received: (qmail 2721 invoked from network); 10 May 2007 13:25:07 +0200
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 10 May 2007 13:25:07 +0200
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
In-Reply-To: <1178794261.5806.98.camel@murta.transitives.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46856>

> Hi,
> 
> I really love the fact I can micro-commit changes when I'm 
> developing. However at some point the combination of changes 
> I have made can be considered a single body of work. This is 
> especially true when you start doing things like re-basing on 
> code that has moved around a lot. You don't want to be 
> correcting a whole bunch of merge failures for every commit 
> in your current tree.
> 
> So far the only was I can see to do this is a:
> 
> git-diff master..HEAD > my.patch
> 
> And then re-applying your patch in stages, manually doing the commits.
> 
> Am I missing something?

git merge --squash ?

-- 
best regards

  Ray
