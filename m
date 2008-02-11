From: Wincent Colaiuta <win@wincent.com>
Subject: gitweb bug: broken "next" and other links
Date: Mon, 11 Feb 2008 13:51:13 +0100
Message-ID: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 13:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOY8V-0006nG-J6
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 13:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYBKMvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 07:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbYBKMvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 07:51:16 -0500
Received: from wincent.com ([72.3.236.74]:45869 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbYBKMvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 07:51:15 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1BCpEbg001501
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 06:51:15 -0600
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73527>

Just noticed a bug (possibly bugs) in gitweb.

Look at a shortlog page like this one:

http://repo.or.cz/w/git.git?a=shortlog

Mouse over the "next" link at the bottom and you'll see this is the URL:

http://repo.or.cz/w/ARRAY(0x85a5318)?a=shortlog;pg=1

Which obviously won't work...

Same if you look at the "log" view:

http://repo.or.cz/w/git.git?a=log

There the "next" links point at URLs like:

http://repo.or.cz/w/ARRAY(0x85e87b8)?a=log;pg=1

But it's not only "next" links that are broken. Some random clicking  
around discovered ones like this:

Looking at a commitdiff, eg:

http://repo.or.cz/w/git.git?a=commitdiff;h=94bf9f7c37cca0241785a5f4e54e5cc98e175244

The "raw" link is:

http://repo.or.cz/w/ARRAY(0x8579c0c)?a=commitdiff_plain;h=94bf9f7c37cca0241785a5f4e54e5cc98e175244

There may be others, but that's what I've found so far.

Cheers,
Wincent
