From: Ruediger Meier <sweet_f_a@gmx.de>
Subject: git clone --depth and git describe
Date: Fri, 10 May 2013 01:07:58 +0200
Message-ID: <201305100107.59115.sweet_f_a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 01:08:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZwW-0006G4-FV
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759302Ab3EIXID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:08:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:63269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937Ab3EIXIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:08:01 -0400
Received: from mailout-de.gmx.net ([10.1.76.24]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Ll3wB-1U0gtR0F1B-00anYP for
 <git@vger.kernel.org>; Fri, 10 May 2013 01:08:00 +0200
Received: (qmail invoked by alias); 09 May 2013 23:07:59 -0000
Received: from dslb-088-073-076-227.pools.arcor-ip.net (EHLO dslb-088-073-076-227.pools.arcor-ip.net) [88.73.76.227]
  by mail.gmx.net (mp024) with SMTP; 10 May 2013 01:07:59 +0200
X-Authenticated: #11967524
X-Provags-ID: V01U2FsdGVkX188/pMkun88YhHGBff/q1iHse1ASBzXLebCL5V1vk
	cu1fHWcO4m1aIO
User-Agent: KMail/1.9.10
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223798>

Hi,

I have a use case where I'd like to improve performance using "git 
clone --depth". But I also need "git describe" working on that clone.

So something like
 git clone --depth=describable
would be nice to have.

Would it be possible to add such feature?

cu,
Rudi
