From: Jon Seymour <jon.seymour@gmail.com>
Subject: Summary Of Jon's Recent Patches
Date: Thu, 7 Jul 2005 12:51:53 +1000
Message-ID: <2cfc40320507061951563bdd76@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jul 07 04:57:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqMZj-0007iO-Sa
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 04:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVGGCxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 22:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVGGCwU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 22:52:20 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:38284 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262218AbVGGCvy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Jul 2005 22:51:54 -0400
Received: by rproxy.gmail.com with SMTP id i8so82054rne
        for <git@vger.kernel.org>; Wed, 06 Jul 2005 19:51:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eNekbEhM2DpQLZXzLokKk1ZFKvT5l3BaZyCiya7CYasGs7RF55IinBFYDQZUjypMx5hvLrIo9DZp2X8gOOmz8Juqh2e/o6n2DRQa/52xDufRx2p7a88nvqMhI58bzL4HYiJkXQTN2fI7ggL8d5dLKAqo3NbPWlK6njk5gD9EZTc=
Received: by 10.38.65.70 with SMTP id n70mr423303rna;
        Wed, 06 Jul 2005 19:51:53 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 6 Jul 2005 19:51:53 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I've recently posted the following patches, in this order:

These ones are tidy ups:

[PATCH] Remove use of SHOWN flag
[PATCH] Move SEEN flag into epoch.h, replace use of VISITED flag with SEEN flag
[PATCH] Simplification - remove unnecessary list reversal from epoch.c

This series contains a big fix, but assumes the tidy ups above have
been applied:

[PATCH 1/2] Fix --topo-order, --max-age interaction issue
[PATCH 2/2] Add test case that shows --topo-order, --max-age break

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
