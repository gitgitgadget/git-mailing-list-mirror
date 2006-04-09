From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 01:22:58 +0300
Message-ID: <20060410012258.589f1581.tihirvon@gmail.com>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
	<Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 00:22:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSiIw-0003Uw-0u
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 00:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDIWW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 18:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWDIWWZ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 18:22:25 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:47110 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750938AbWDIWWZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 18:22:25 -0400
Received: by nproxy.gmail.com with SMTP id g2so537526nfe
        for <git@vger.kernel.org>; Sun, 09 Apr 2006 15:22:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MAeEBEIKa0vQA0zVfQh5ndkUVDjMNIfdKSeUTgwHJqgLFn0z0Wu3a+rwR6eqdu80wdoStihqSYGvDxRpqof4t0AzGFXg6pp36ZanzOI8sKapIOXDHnthPtHKI0uD+I2VZkt4lGdMCUxJ4u1y0FiqeMvkXArbZV1G28HLpT34ln8=
Received: by 10.49.3.14 with SMTP id f14mr1197698nfi;
        Sun, 09 Apr 2006 15:22:23 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id o45sm374314nfa.2006.04.09.15.22.22;
        Sun, 09 Apr 2006 15:22:23 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.16; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18569>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> +static int cmd_whatchanged(int argc, const char **argv, char **envp)
> +{
> +	memmove(argv + 2, argv + 1, argc - 1);

Shouldn't the size be sizeof(char *) * argc (NULL terminated array)?
There's also overflow...

-- 
http://onion.dynserv.net/~timo/
