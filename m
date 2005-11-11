From: Paolo Teti <paolo.teti@gmail.com>
Subject: Re: lock
Date: Fri, 11 Nov 2005 17:48:43 +0100
Message-ID: <34a7ae040511110848o624569cah@mail.gmail.com>
References: <34a7ae040511110831y3e896738o@mail.gmail.com>
	 <20051111164101.GV30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 17:50:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eac52-0003tX-KI
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKKQsp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKKQsp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:48:45 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:63429 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbVKKQso convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 11:48:44 -0500
Received: by xproxy.gmail.com with SMTP id i30so759116wxd
        for <git@vger.kernel.org>; Fri, 11 Nov 2005 08:48:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OUApIzZNHzkW2XTz6D+j92BnOQYtbGo1hffvWfHv6JC2UgquNG6AKAmabbStCvv87ZO5xC/5HcbATGKGfWvovrI9nv9vhfsk7yVC7wpvwrQW66VZkpBz8u6+ImPbc3J6dY1qIIm7QEb3CJ7msxck4XFoct4yvEIiFu09f5ar2cE=
Received: by 10.70.124.8 with SMTP id w8mr2369847wxc;
        Fri, 11 Nov 2005 08:48:43 -0800 (PST)
Received: by 10.70.94.20 with HTTP; Fri, 11 Nov 2005 08:48:43 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051111164101.GV30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11617>

2005/11/11, Petr Baudis <pasky@suse.cz>:

> Do you want to lock the file so that noone else will be able to check it
> out? That's impossible from GIT's very nature of distributed version
> control system.

No! I know that is impossible using GIT

> Do you want to lock the file in your working copy so that you won't be
> able to remove it or change it? In that case, this is possible, but not
> implemented yet. Part of the solution would involve making the file
> read-only, the rest would be probably to make sure all the tools handle
> that case gracefully.

Yes! this is my case.. The as work-around I can use an hook (i.e. a
kind of ClearCase trigger). But remain a work-around!
