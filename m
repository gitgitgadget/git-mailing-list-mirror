From: Wayne Scott <wsc9tt@gmail.com>
Subject: Re: bogus merges
Date: Tue, 6 Sep 2005 08:08:57 -0500
Message-ID: <59a6e58305090606082a23b048@mail.gmail.com>
References: <59a6e58305090507387d412b3d@mail.gmail.com>
	 <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
Reply-To: wsc9tt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 15:11:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECdCB-0007io-8h
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 15:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbVIFNJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 09:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVIFNJA
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 09:09:00 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:52269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964867AbVIFNJA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 09:09:00 -0400
Received: by wproxy.gmail.com with SMTP id i35so831614wra
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 06:08:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BFOHXG1JQyb15XGHGZ3LNOBYmKysVx6kaF91rKXc+Yp4H1PXkZz3loWDVi8aLyH3Njkrk4vkC/CXSHCF3BTDwnbzldskhfJZunsKAn0lLW/yq/oXWYa5eC1inXdQjxpM0GDiYDeUNdhUUMmemv20I+sC+IvH0vlXOD1MYbXKqAY=
Received: by 10.54.121.12 with SMTP id t12mr4358922wrc;
        Tue, 06 Sep 2005 06:08:57 -0700 (PDT)
Received: by 10.54.36.41 with HTTP; Tue, 6 Sep 2005 06:08:57 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8129>

On 9/5/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > Really 'git commit' should detect problems like this automatically and
> > prevent them from getting in the tree.
> 
> Well, that would depend on having the fixed git-merge-base in the first
> place, which in turn would mean that such a commit wouldn't happen at all,
> so it's kind of circular. It's not worth fixing anywhere else, since once
> you fix it in git-merge-base, it just becomes a non-issue.

This just error checking to prevent future bugs from getting committed
to the tree.  These kinds of things are very hard to repair after the
fact.

-Wayne
