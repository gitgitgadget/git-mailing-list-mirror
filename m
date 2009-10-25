From: Clemens Buchacher <drizzd@aon.at>
Subject: Smart HTTP tests
Date: Sun, 25 Oct 2009 13:06:17 +0100
Message-ID: <1256472380-924-1-git-send-email-drizzd@aon.at>
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Oct 25 13:06:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N21ry-00023Q-74
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 13:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbZJYMGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 08:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbZJYMGg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 08:06:36 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45178 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbZJYMGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 08:06:35 -0400
Received: by bwz27 with SMTP id 27so1602555bwz.21
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 05:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer;
        bh=b4J/fJ1Da+QJTXHrtaHzjHRfbL4S0JU5v2pufN3ibWM=;
        b=XiNsh4gY+GZjf34fcjIBXvP8KkzExA0nRwf8r7v9qIkriNFuPhm1lexQtEBelFysKD
         HYl77ytw4l5LpccG4YF+y83wajR0312p8Czk6D2iIqQ6zi4oWMIPKpUOXwteo/uzQrxW
         5ovdTZm+NkyOVjvT1UujRfhavuI657u89QQfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=P16Tnn6LaCCjiYQ5yjNsDi7UZIGqKrXTS+Ix1RNfxWM9Q/4v0or5xwgnHswuoJ2xnG
         a6F2kIwjEEJwJtaXCDsaZUGY4YikuUZb/Vo7UZOwtc7aXrwoPSIUIf98tFcnzNJHb0VC
         PmyhkDbwXmLaVMfM9nWDUJYJljM22aP+X9xyw=
Received: by 10.204.153.27 with SMTP id i27mr3175471bkw.155.1256472399468;
        Sun, 25 Oct 2009 05:06:39 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 3sm6808424fxm.85.2009.10.25.05.06.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 05:06:38 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N21rs-0001PP-5S; Sun, 25 Oct 2009 13:06:40 +0100
X-Mailer: git-send-email 1.6.5.35.ge41a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131200>

Hi Shawn,

This is on top of 1e0eb0f0 (Smart HTTP fetch: gzip requests) in pu.

I had to use the SetHandler syntax as suggested by Mark. My apache setup
(debian 2.2.9-10+lenny) does not resolve the suffix to git-http-backend
relative to document root automatically. Instead it will look for repos in
${GIT_EXEC_PATH}/git-http-backend/git/...

Clemens
