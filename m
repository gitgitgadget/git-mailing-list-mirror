From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: windows problems summary
Date: Thu, 2 Mar 2006 17:33:02 +0100
Message-ID: <81b0412b0603020833j214556bek887c53a3ef43fd58@mail.gmail.com>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
	 <Pine.LNX.4.63.0603021636020.30490@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 17:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEqjl-0001nn-FT
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCBQdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWCBQdG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:33:06 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:32828 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751095AbWCBQdE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 11:33:04 -0500
Received: by nproxy.gmail.com with SMTP id m19so306107nfc
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 08:33:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zug/ELKqSzT05EFKGKLWVOtUx4c3h5uFYQNQ5/gesG8PnTda849S03dzyS9HL/FK8R9hjR39jjfMMFwUVURKyYmqDeV/G79YKh6P0550ycW43T2AjvYJlZWWaPFRxNlZARW9iFx2zzjOZzFf1hb7GQUV3Iern/d9a+XLN28uJFw=
Received: by 10.49.11.18 with SMTP id o18mr734586nfi;
        Thu, 02 Mar 2006 08:33:02 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 08:33:02 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0603021636020.30490@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17091>

On 3/2/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > 1. opened and mmaped files can't be removed or renamed
> >   (caused workaround with reading index in memory)
>
> It was not the locking which caused the workaround. It was the
> not-working. (I still have to find a Windows machine where git-whatchanged
> does not segfault without NO_MMAP.)

me too. It crashes everywhere here.

> > 4. non-unix permissions model
> >   (breaks x-attr)
> > 5. real slow filesystems and caching
> >   (makes everything slow. I noticed I'm trying to avoid git status!).
> >   Caused workaround with manual checkout)
> > 6. real slow program startup
> >   (makes everything slow, eventually may cause everything being put
> >   in one super-executable, just to avoid spawning new processes,
> >   with all associated problems. Makes scripting harder)
>
> Except for (4), these issues should be resolvable by the libifying effort.
>

How can it help with 5? Less accesses to index?
