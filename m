From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Fix problematic ']'
Date: Mon, 23 Jul 2007 23:58:35 +0300
Message-ID: <20070723235835.36b6d87a.tihirvon@gmail.com>
References: <200707232236.21389.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:59:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID50D-0005CQ-Vd
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936067AbXGWU7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935999AbXGWU7T
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:59:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:22256 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935918AbXGWU7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:59:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so35293ugf
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 13:59:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=kPq9dl4Fq8OHIytnmrffTZI1lwYBkYKNr0nWsX6ow6AQcFxipbojnBnacvL0HwuJPyYdxPWny6GJdiMK61XKasd0ZwWMX46ukvHZJXTchctWu1qwd8HyESLVqJUAjTYjxoHT8Yz2uFFXTHctpkqxNP1Mffr5p0AmAdyeb241nIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=eoiIJNBlROf5OFJSvy9lfHD4vKt1pjXu/0Chka5cH3l/GbdT8ryOs/6wNj7dsAz5aTM9V9hJ47NQgcD1Z3UM40p4P0IMYYY5k7kYvhMyRXjqQfn/idpKJ/7XtoDjn3CRBq8YUh3uYljYc3HmJNoujP6WQOgYYML7KGG803l95b8=
Received: by 10.86.60.7 with SMTP id i7mr2724317fga.1185224355978;
        Mon, 23 Jul 2007 13:59:15 -0700 (PDT)
Received: from garlic.home.net ( [85.23.17.126])
        by mx.google.com with ESMTPS id f31sm15009051fkf.2007.07.23.13.58.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2007 13:59:15 -0700 (PDT)
In-Reply-To: <200707232236.21389.johannes.sixt@telecom.at>
X-Mailer: Sylpheed 2.4.4 (GTK+ 2.10.13; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53485>

Johannes Sixt <johannes.sixt@telecom.at> wrote:

> Not all shells grok a closing ']' of the shell '[' command without
> surrounding space.

That's one good reason to use test instead of /usr/bin/[ hack (yes it
has been a shell built-in for a long time). [ is just like test but
expects ] as last parameter and ignores it.  Very ugly IMO.

-- 
http://onion.dynserv.net/~timo/
