From: Sven Ekman <svekman@yahoo.se>
Subject: Feature wish: Cloning without history
Date: Thu, 18 May 2006 21:21:44 +0200 (CEST)
Message-ID: <20060518192144.15912.qmail@web25913.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 18 21:21:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgo4D-0002mJ-Qg
	for gcvg-git@gmane.org; Thu, 18 May 2006 21:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWERTVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 15:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWERTVq
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 15:21:46 -0400
Received: from web25913.mail.ukl.yahoo.com ([217.146.176.251]:52069 "HELO
	web25913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751382AbWERTVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 15:21:46 -0400
Received: (qmail 15915 invoked by uid 60001); 18 May 2006 19:21:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.se;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nrvN4f6NiDgNu78kbjyDI6hNoNXam4bvtgI+KbjNjGY8gD9DSOvP7VMKbVdu/UJMNfdXVOwofZog+MKPXuxh5jWlGYzsR6frOL0DvSs/4Gz5fwCAeKUTH3MmbdNCoJpVQrB/W/J5UfqhG0QY8/GwoGU8QrZZxWC0lAXHfwhb/2Y=  ;
Received: from [149.9.0.21] by web25913.mail.ukl.yahoo.com via HTTP; Thu, 18 May 2006 21:21:44 CEST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20299>

Hello,

Would it be possible to add an option to git-clone to
skip the complete history? The result should be a
repository which contains the current head only (or
maybe a specified tag) and has that commit id added to
.git/info/grafts. For the fetch process, this would
certainly have to imply the --no-tags flag.

>From a user's point of view I'd imagine something like
this:

git-clone --no-history=v2.6.16 \
    git://git.kernel.org/.../linux-2.6.git

The background: I'm regularly building kernels for a
handful of machines, and while I am happy to use the
blessings of git to get updates from the -stable
releases, I see no point in wasting space for a copy
of the complete kernel history on every single
machine. In practice this works pretty good, once I
have manually created such a castrated repository.

Sven
