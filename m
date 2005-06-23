From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 20:18:22 +1200
Message-ID: <46a038f9050623011838d6b85f@mail.gmail.com>
References: <42B9FCAE.1000607@pobox.com> <42BA14B8.2020609@pobox.com>
	 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
	 <42BA1B68.9040505@pobox.com>
	 <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
	 <42BA271F.6080505@pobox.com>
	 <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
	 <42BA45B1.7060207@pobox.com>
	 <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
	 <20050623073845.GA5204@pasky.ji.cz>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 12:02:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlOXI-0000Ju-VB
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 12:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVFWKG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 06:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVFWKEg
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 06:04:36 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:52235 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263073AbVFWISW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 04:18:22 -0400
Received: by rproxy.gmail.com with SMTP id i8so222034rne
        for <git@vger.kernel.org>; Thu, 23 Jun 2005 01:18:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YTFdPXNdpFlruui9qc7rrWbF4U9pMUYZ93b1zHtKgZwGz1GDpUiLy2CPX5gFzdJXG30787XBrC87gW65IT09aynHvwFYwkv7YjHlHJ6ZOlxayNA2XbDTkGL+I3o1nhGqIPTvrHxVB07YsPe1UVsBKCbqBBRWX4zLre6+kZMhNi4=
Received: by 10.38.78.53 with SMTP id a53mr731561rnb;
        Thu, 23 Jun 2005 01:18:22 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Thu, 23 Jun 2005 01:18:22 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050623073845.GA5204@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/23/05, Petr Baudis <pasky@ucw.cz> wrote:
> I think there should simply be two namespaces - public tags and private
> tags. Private tags for stuff like "broken", "merged", or "funnychange".

I guess that public tags would also probably be in a different
location from the actual tree. With the split Linus advocates, several
people could be publishing sets of "public" tags, as well as having
the official tags hosted separately from the .git repo.

cheers,


martin
