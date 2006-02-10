From: Brian Smith <linuxfood@linuxfood.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Thu, 9 Feb 2006 17:06:58 -0800
Message-ID: <200602091706.59521.linuxfood@linuxfood.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz> <200602091650.55370.linuxfood@linuxfood.net> <7vk6c43ue5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 02:07:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Mke-00083m-SD
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 02:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWBJBHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 20:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWBJBHF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 20:07:05 -0500
Received: from [67.124.82.122] ([67.124.82.122]:37959 "EHLO linuxfood.net")
	by vger.kernel.org with ESMTP id S1750950AbWBJBHE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 20:07:04 -0500
Received: (qmail 4597 invoked from network); 9 Feb 2006 17:07:03 -0800
Received: from unknown (HELO borealis.linuxfood.net) (192.168.1.2)
  by 192.168.1.6 with AES256-SHA encrypted SMTP; 9 Feb 2006 17:07:03 -0800
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
In-Reply-To: <7vk6c43ue5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15853>

On Thursday 09 February 2006 16:54, Junio C Hamano wrote:
> Brian Smith <linuxfood@linuxfood.net> writes:
> > While that is an admirable goal, unless you can point me to something
> > that will allow you to actually commit back to SVN without a working
> > copy, it defeats the purpose of my tools which is basically to use to git
> > for the purpose of holding intermediate development before sending it
> > into SVN as a final commit.
>
> Wouldn't svk (or svl or whatever it is called these days) be a
> better match for that kind of "keep my work while disconnected
> from master svn repository" purpose?

It would, if it wasn't god awful slow. And besides, AFAIK, it doesn't allow 
you to do anything other than keep offline work in a separate SVN repo hosted 
on your machine, which means I can't use the git tools.
