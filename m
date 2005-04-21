From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH] multi item packed files
Date: Thu, 21 Apr 2005 21:28:17 +0200
Message-ID: <m3u0m0q69a.fsf@defiant.localdomain>
References: <200504211113.13630.mason@suse.com>
	<Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 21:25:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOhHT-0007HY-91
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 21:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVDUT2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 15:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVDUT2Y
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 15:28:24 -0400
Received: from khc.piap.pl ([195.187.100.11]:16132 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261809AbVDUT2W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 15:28:22 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id 7AA3C1082A; Thu, 21 Apr 2005 21:28:18 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504210832490.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 21 Apr 2005 08:41:12 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Wrong. You most definitely _can_ lose: you end up having to optimize for
> one particular filesystem blocking size, and you'll lose on any other
> filesystem. And you'll lose on the special filesystem of "network
> traffic", which is byte-granular.

If someone needs better on-disk ratio, (s)he can go with 1 KB filesystem
or something like that, without all the added complexity of packing.

If we want to optimize that further, I would try doing it at the
underlying filesystem level. For example, loop-mounted one.
-- 
Krzysztof Halasa
