From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/6] Bring notes.c template handling in line with commit.c.
Date: Sun, 19 Jun 2011 23:23:09 +0200
Message-ID: <201106192323.09511.johan@herland.net>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-2-git-send-email-ydirson@free.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:07:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQ9i-0008NH-U8
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab1FSWHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:07:39 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59476 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929Ab1FSWHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:07:39 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200I2A5GP0810@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:37 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 094601798FBD_DFE7329B	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:37 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E6D8517962DF_DFE7328F	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:36 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200CIB5GO4R00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:36 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <1308431208-13353-2-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176030>

On Saturday 18 June 2011, Yann Dirson wrote:
> Signed-off-by: Yann Dirson <ydirson@free.fr>

Please mention in the commit message that the commit merely replaces 
write_or_die()/int fd with the corresponding stdio functionality, and that 
there is no (intended) change in behavior. It was not apparent from your 
commit message that you had not made any other changes.

Otherwise the patch looks OK.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
