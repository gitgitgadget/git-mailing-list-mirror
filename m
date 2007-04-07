From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Makefile: iconv() on Darwin has the old interface
Date: Fri, 6 Apr 2007 22:51:06 -0400
Message-ID: <227FC9AB-5E23-4088-8368-EBA64B1D876A@silverinsanity.com>
References: <20070406234917.GK3854@regex.yaph.org> <7v1wixhvof.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: arjen@yaph.org (Arjen Laarhoven),
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 04:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha11G-0001vz-MD
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 04:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbXDGCvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 22:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXDGCvM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 22:51:12 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:59478 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965145AbXDGCvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 22:51:10 -0400
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 8B7EF1FFC157;
	Sat,  7 Apr 2007 02:51:09 +0000 (UTC)
In-Reply-To: <7v1wixhvof.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43959>


On Apr 6, 2007, at 8:31 PM, Junio C Hamano wrote:

> Anybody else on Darwin around?

Applying the patch does silence an incompatible pointer warning I  
hadn't noticed previously on OS 10.4.9.  The man page also agrees  
that iconv() uses const char **.  So ACK from me.

~~ Brian
