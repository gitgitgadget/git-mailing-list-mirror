From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: How to prevent Git from compressing certain files?
Date: Thu, 23 Jul 2009 20:51:47 +0200
Message-ID: <4A68B143.1070902@dirk.my1.cc>
References: <4A676D4B.7040004@dirk.my1.cc> <20090723101227.GA4247@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 20:52:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MU3P8-0004GC-78
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 20:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbZGWSvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbZGWSvu
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 14:51:50 -0400
Received: from smtprelay09.ispgateway.de ([80.67.31.43]:53286 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbZGWSvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 14:51:50 -0400
Received: from [84.176.110.17] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1MU3Pv-0007m5-4n; Thu, 23 Jul 2009 20:53:23 +0200
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <20090723101227.GA4247@coredump.intra.peff.net>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123885>

Jeff, Jakub, thanks for the answers and explanation of how and when Git 
compresses data. Setting both core.compression and pack.window to 0 sped 
up my git-gc :-)

	Dirk
