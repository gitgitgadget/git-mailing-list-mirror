From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Fri, 28 Oct 2005 14:16:09 +1300
Message-ID: <46a038f90510271816i26389d5cqe136f515007ca057@mail.gmail.com>
References: <20051027203945.GC1622@pe.Belkin>
	 <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 03:16:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVIqv-0003hN-6W
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 03:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVJ1BQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 21:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVJ1BQL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 21:16:11 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:61785 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965041AbVJ1BQK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 21:16:10 -0400
Received: by xproxy.gmail.com with SMTP id h30so100194wxd
        for <git@vger.kernel.org>; Thu, 27 Oct 2005 18:16:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m5Kzp4OGCd2dUP39rDUc73vMZYzFsKSubCQnMbIIVM9uXbj1oKa9jzSzsRsNUNJEiE6OeHjTWI/ZcPNmRlF8s8nhtzbt9X4sbp0TF7VUk2fQLuJveTpCjnC09V/sLjAfLFkng9lNM7T5lM2ZgQh8IFucDp5Uj7UTESGuWIJTCnM=
Received: by 10.65.189.10 with SMTP id r10mr2065940qbp;
        Thu, 27 Oct 2005 18:16:09 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Thu, 27 Oct 2005 18:16:09 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10735>

On 10/28/05, Junio C Hamano <junkio@cox.net> wrote:
> > which is pretty slow.  Any suggestions?
>
> * do we really want to know the number of lines?

What about both? And sugar (rename detection) on top! ;-)

If you try an find the largest commit (by line count) in the gitweb
revision history, you bump into the gitweb.pl -> gitweb.cgi rename.

cheers,


martin
