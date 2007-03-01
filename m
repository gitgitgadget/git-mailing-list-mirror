From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: gitweb not friendly to firefox?
Date: Thu, 1 Mar 2007 14:34:26 +0100
Organization: Softwarelandschaft
Message-ID: <000f01c75c06$555d5e50$0b0aa8c0@abf.local>
References: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "'Li Yang-r58472'" <LeoLi@freescale.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 15:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMlQc-0005z5-20
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 14:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbXCANeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbXCANeb
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 08:34:31 -0500
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:56744 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965052AbXCANea convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 08:34:30 -0500
Received: (qmail 22234 invoked from network); 1 Mar 2007 14:39:43 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 1 Mar 2007 14:39:43 +0100
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41096>

> XML Parsing Error: not well-formed
> Location: 
>
http://10.193.20.133/gitweb/?p=linux-2.6.git;a=commit;h=c0051ec763eca4c1adfc
b8d461243d0a7b444bb7
> Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
<LeoLi@freescale.com></td></tr> -------------------------------------^

Try to save the output and verify it with some other xml-parser. The
"<LeoLi@freescale.com>" seems to be the culprit here, since "@" is no
allowed character for a xml-tag, and there maybe is some html-escaping of
the email address missing?

> Would it be anything wrong with my gitweb configuration or apache setup?

I think IE just chooses to ignore the error.

> Thanks,
> Leo

-- 
best regards

  Ray
