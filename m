From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Careful object writing..
Date: Wed, 4 May 2005 01:25:05 +0200
Message-ID: <81b0412b0505031625478de1a5@mail.gmail.com>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
	 <81b0412b05050316045fa31c2a@mail.gmail.com>
	 <Pine.LNX.4.58.0505031618360.26698@ppc970.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 01:19:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6fS-0006Th-Gb
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVECXZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVECXZS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:25:18 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:12831 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261922AbVECXZI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:25:08 -0400
Received: by wproxy.gmail.com with SMTP id 68so91191wra
        for <git@vger.kernel.org>; Tue, 03 May 2005 16:25:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j4IvBR/0D+ikUK1VZkN2IRTdAqEzzG6PdQYR8bc+48ZMOZuurmYlPyKSmhYFXxrlQOFcUbQDLwMwvHhvzrsev4cG1PTBSfkVlXSir3GHEMG6CFEdDC9K1nd0d4oIgN3G5XpNWMSQo66fIOFavGV32DO/GzK58Xrz7la5TwBObTc=
Received: by 10.54.82.19 with SMTP id f19mr134163wrb;
        Tue, 03 May 2005 16:25:05 -0700 (PDT)
Received: by 10.54.79.20 with HTTP; Tue, 3 May 2005 16:25:05 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031618360.26698@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/4/05, Linus Torvalds <torvalds@osdl.org> wrote:
> > > I also change the permission to 0444 before it gets its final name.
> > Maybe umask it first? Just in case.
> 
> I considered it, but it's not worth it.
> 
> If you don't want somebody else to see your objects, you should just
> disable execute permission on your .git directory. ...

Of course. It's leaves even more control to the user. Forget I asked :)
