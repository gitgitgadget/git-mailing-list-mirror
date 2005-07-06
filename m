From: Greg KH <greg@kroah.com>
Subject: git-pull-script hates me
Date: Wed, 6 Jul 2005 13:31:39 -0700
Message-ID: <20050706203139.GA19198@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 22:34:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqGZt-0007Sw-Ui
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 22:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVGFUcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVGFUcF
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 16:32:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:22987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262525AbVGFUb4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 16:31:56 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j66KVJq12329;
	Wed, 6 Jul 2005 13:31:19 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1DqGYV-506-00; Wed, 06 Jul 2005 13:31:39 -0700
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just updated to the latest git tree, and now get the following when I
try to pull from a ssh repo:

 $ git-pull-script gregkh@someserver.org:/public_html/udev.git/
 fatal: I don't like '@'. Sue me.

So I drop the @ and then get:
 $ git-pull-script someserver.org:/public_html/udev.git/
 fatal: I don't like '_'. Sue me.

This worked just fine before I updated git :(

Any hints?  Or should I be using a different command to do pulls?

thanks,

greg k-h
