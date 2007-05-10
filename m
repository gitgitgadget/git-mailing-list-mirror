From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 15:33:08 +0200
Message-ID: <81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	 <20070510095156.GC13655@mellanox.co.il>
	 <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	 <20070510120802.GG13655@mellanox.co.il>
	 <81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	 <20070510122550.GJ13655@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 15:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm8lr-0005DA-Nn
	for gcvg-git@gmane.org; Thu, 10 May 2007 15:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758215AbXEJNdM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 09:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758452AbXEJNdL
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 09:33:11 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:57680 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758215AbXEJNdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 09:33:10 -0400
Received: by an-out-0708.google.com with SMTP id d18so140851and
        for <git@vger.kernel.org>; Thu, 10 May 2007 06:33:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dW4qC79U2uUQCaxOCzB0yJhQrZGqbzb3modcxMbst3BvT6dfk7gJKn24Erw+rHpEkO6DOj201SJFemYJO0ZfDyN6xkwVoO5MUbqfoITGgCgqJDFrj0lUbd0tF8d27bLgDWrpxxM2ekp5ObDYvPdlAvDRkrrJ6X2M8HuucVORWr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fz4E7oYu760ncBQVgWvVsBljylEJWIOKQbaDan1qwoftLusy1Vf4nYOwKSPvo0LTbcpUTRUr+WTZUemmbx7zHVWbH0GomOi2l3lVDCPmU1a2ixnZKgCMR9bxdj1aifIYOkRbPbQPP4uo0U6f8NXks0yKcMGpcGu45nvbInwRn0Q=
Received: by 10.100.210.10 with SMTP id i10mr1221406ang.1178803988499;
        Thu, 10 May 2007 06:33:08 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 06:33:08 -0700 (PDT)
In-Reply-To: <20070510122550.GJ13655@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46865>

On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> > >> What addresses were tried by connect?
> > >
> > >You are speaking about your patch reporting the IP on failure?
> >
> > Yes. Not on failure (not only). Every time an address is tried
> > to connect.
>
> Why not only on failure? IP addresses look ugly.

So you can see DNS problems you wanted to uncover.
DNS is all about mapping names to that ugly IP.
And DNS _problems_ often manifest themselves
by mapping the name to an unexpected IP.
Now that's really ugly

> > >I think it makes sense, but it's a separate issue, isn't it?
> >
> > You are just about to make git_tcp_connect verbose,
> > are you not?
>
> Only if the flag is set. So git-fetch without -q qill be more verbose -
> but it already spits out a fair amount of data on screen.

And so you added some more? Does not sound logical.

How about cleaning up this (reduce the amount of date
on screen) and adding another verbosity level (with your
messages and IP) instead?
