From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 06:53:13 -0600 (CST)
Message-ID: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>, Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 13:53:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI2aT-0003YX-J8
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 13:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXBPMxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 07:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXBPMxP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 07:53:15 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:30625 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272AbXBPMxO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 07:53:14 -0500
Received: from vms064.mailsrvcs.net ([192.168.1.1])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDK00AN33SQOTK8@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 06:53:14 -0600 (CST)
Received: from 12.109.151.100 ([12.109.151.100])
 by vms064.mailsrvcs.net (Verizon Webmail) with HTTP; Fri,
 16 Feb 2007 06:53:13 -0600 (CST)
X-Originating-IP: [12.109.151.100]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39911>

>>
>Also as Shawn pointed out, the script too heavily depends on GNU
>tar.  Can we do something about it?

Let me ponder, I'm sure I can do something. As I noted in another response, Cygwin won't let me reliably pipe the pack file through bash, so I'm forced to use some archiver.

Mark
