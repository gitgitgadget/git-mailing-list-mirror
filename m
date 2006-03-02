From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: windows problems summary
Date: Thu, 2 Mar 2006 16:35:29 +0100
Message-ID: <81b0412b0603020735j603b3518ob5e27a02c531093a@mail.gmail.com>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
	 <20060302152329.GH2781@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 16:35:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEpq4-0004Zb-Bw
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWCBPfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWCBPfb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:35:31 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:48205 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbWCBPfb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:35:31 -0500
Received: by nproxy.gmail.com with SMTP id g2so297117nfe
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 07:35:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m5tTiyp9A4y7ihvDcHFEKE2GusiSomBX/iIZ/UAjT1y9xn8ef/UfGbBo7ghJ/5WpQ8a8GTG8LKVUqf/93hUW7oiBKxMWrO/L9uEuuD2A/c++5tk+JA46QnvD5TJSNz86n4AU8hGc7kJ2fqNNAV/pQVMw9J5RYLS5TZUtH0Qf63U=
Received: by 10.48.213.18 with SMTP id l18mr693595nfg;
        Thu, 02 Mar 2006 07:35:29 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 07:35:29 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060302152329.GH2781@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17080>

On 3/2/06, Christopher Faylor <me@cgf.cx> wrote:
>
> Are we *really* contemplating porting git to native Windows?
>

Actually, I wasn't thinking about that when I was writing that mail,
but ... why not?
Cygwin makes syscalls many times slower, git is very slow on
windows, users (well, I) want it faster, so if the needed api subset
can be narrowed down to a reasonable amount of work - I think
I'd give the idea a try.
