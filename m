From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH] Define -D__BSD_VISIBLE for FreeBSD
Date: Thu, 21 Dec 2006 10:09:52 +0000
Organization: Berlin University of Technology
Message-ID: <20061221100952.GA15424@peter.daprodeges.fqdn.th-h.de>
References: <11666916581935-git-send-email-pdmef@gmx.net> <7vk60lbnvj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Thu Dec 21 11:10:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxKsC-0003k0-Eu
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 11:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWLUKJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 05:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWLUKJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 05:09:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:60736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965186AbWLUKJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 05:09:56 -0500
Received: (qmail invoked by alias); 21 Dec 2006 10:09:55 -0000
Received: from cable-62-117-26-66.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.26.66]
  by mail.gmx.net (mp038) with SMTP; 21 Dec 2006 11:09:55 +0100
X-Authenticated: #1642131
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 483CA20F16
	for <git@vger.kernel.org>; Thu, 21 Dec 2006 10:09:54 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vk60lbnvj.fsf@assigned-by-dhcp.cox.net>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.2-PRERELEASE i386)
User-Agent: Mutt/1.5.13-pdmef (2006-11-28)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35045>

Hi,

* Junio C Hamano [06-12-21 01:26:56 -0800] wrote:

>We've changed this exact area quite heavily during the last
>24-hours (not in Makefile but in git-compat-util.h).  Do you
>see the problem with the latest 'master'?

Now when looking at sys/cdefs.h, the 
85023577a8f4b540aa64aa37f6f44578c0c305a3 commit seems to have broken 
things. So the patch should be ignored and I'll try to come up with a 
better one not using implementation-defined __-macros...

   bye, Rocco
-- 
:wq!
