From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 09:36:50 -0400
Message-ID: <118833cc05042606362cc60ad2@mail.gmail.com>
References: <20050426032422.GQ13467@pasky.ji.cz>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 26 15:34:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQQA8-0002sZ-9X
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 15:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDZNgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVDZNgv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 09:36:51 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:63239 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261494AbVDZNgu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 09:36:50 -0400
Received: by rproxy.gmail.com with SMTP id a41so1114993rng
        for <git@vger.kernel.org>; Tue, 26 Apr 2005 06:36:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RfdVGsl6ilwrutEUOeJbTnqpWYJRUlSfrBPCRU8YNpl1sUxIH6LEcq/l5jsduvNvadWsF7U3gfASSEahMULooqE3DIc9Yp+ubbtUfIhyjtQltjXdxgwDw1GikrPWKyanq+lmQ77hjYnFDZ8PmI7tfaRlQilqqTJGfSq+TlWoqe0=
Received: by 10.38.6.75 with SMTP id 75mr7034324rnf;
        Tue, 26 Apr 2005 06:36:50 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Tue, 26 Apr 2005 06:36:50 -0700 (PDT)
To: pasky@ucw.cz, git@vger.kernel.org
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> [...] build and install it, [...]

It assumes the presense of .git/HEAD but doesn't actually fail when missing.

...
gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o diff-tree-helper
diff-tree-helper.c libgit.a -lz -lssl
cat: .git/HEAD: No such file or directory
Invalid id: 
Generating cg-version...

Morten
