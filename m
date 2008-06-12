From: Johan Herland <johan@herland.net>
Subject: Cleaning up INSTALL before 1.5.6
Date: Thu, 12 Jun 2008 09:20:31 +0200
Message-ID: <200806120920.31161.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 09:22:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6h8a-0000d0-Et
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbYFLHV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbYFLHV2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:21:28 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64939 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYFLHV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:21:27 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2C004359RQU100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 12 Jun 2008 09:21:26 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2C00M3K9Q7Q1B0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 12 Jun 2008 09:20:31 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2C003IM9Q71N50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 12 Jun 2008 09:20:31 +0200 (CEST)
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84730>

AFAICS, there's a couple of things that should be changed in the list of 
system requirements:

- cpio is no longer needed due to git-clone now being a builtin

- According to some other thread on this list, curl might no longer be 
needed, as all its users are now builtin, and uses libcurl instead.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
