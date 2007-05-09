From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Wed, 9 May 2007 09:42:11 +0200
Message-ID: <EC3AE084-0AB8-406A-A3C7-916CCF35BEAE@zib.de>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 09:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlgoQ-00017h-3S
	for gcvg-git@gmane.org; Wed, 09 May 2007 09:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbXEIHmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 03:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXEIHmD
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 03:42:03 -0400
Received: from mailer.zib.de ([130.73.108.11]:51577 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbXEIHmB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 03:42:01 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l497g0RY028773
	for <git@vger.kernel.org>; Wed, 9 May 2007 09:42:00 +0200 (CEST)
Received: from [192.168.178.32] (p54BF2F28.dip0.t-ipconnect.de [84.191.47.40])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l497fxXE008366
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 9 May 2007 09:41:59 +0200 (MEST)
In-Reply-To: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46675>


On May 9, 2007, at 1:59 AM, Steffen Prohaska wrote:

> The old implementation executed 'cvs status' for each file touched  
> by the patch
> to be applied. The new code calls 'cvs status' only once and parses  
> cvs's
> output to collect status information of all files contained in the  
> cvs working
> copy.
>
> [...]

I didn't recognize that my modifications cause the testsuite to fail.  
I'll send a corrected patch in a minute.

I apologize,
- Steffen
