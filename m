From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: sunos nay install nay ginstall nay
Date: Sat, 5 Apr 2008 07:07:53 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0804050653570.14919@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 07:08:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji0dq-0008Uu-UC
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 07:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbYDEFHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 01:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYDEFHy
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 01:07:54 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:46504 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbYDEFHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 01:07:54 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 3973E180311EF; Sat,  5 Apr 2008 07:07:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 2DA761C00FE9B
	for <git@vger.kernel.org>; Sat,  5 Apr 2008 07:07:53 +0200 (CEST)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78838>

Hi,


I found myself in a position to compile Git on Nexenta, and ran into the 
incredibly smart Makefile logic to pick "ginstall" when `uname -s` 
equals SunOS. Except that on GNU/*, it's install, not ginstall.
Would not it be time to completely use automake?
