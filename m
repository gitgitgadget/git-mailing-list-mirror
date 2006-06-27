From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fixed PPC SHA1
Date: Wed, 28 Jun 2006 08:50:03 +1000
Message-ID: <1151448603.2350.104.camel@localhost.localdomain>
References: <20060623005456.21460.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linuxppc-dev@ozlabs.org
X-From: git-owner@vger.kernel.org Wed Jun 28 00:50:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvMO5-0007LY-Si
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWF0WuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWF0WuW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:50:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:26835 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161037AbWF0WuU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 18:50:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k5RMuciH024685;
	Tue, 27 Jun 2006 17:56:39 -0500
To: linux@horizon.com
In-Reply-To: <20060623005456.21460.qmail@science.horizon.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22760>

On Thu, 2006-06-22 at 20:54 -0400, linux@horizon.com wrote:
> Here's the lwsi-based version that's slightly faster on a G5, but slightly
> slower on a G4.

I wouldn't bother with 2 versions... use the non-string version (string
operations will cause performance problems on other processors)

Ben.
