From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 17:11:37 +0100
Message-ID: <81b0412b0603020811r37edca03wde5562b926dab549@mail.gmail.com>
References: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
	 <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	 <20060226195552.GA30735@trixie.casa.cgf.cx>
	 <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org>
	 <20060226204027.GC30735@trixie.casa.cgf.cx>
	 <81b0412b0603020618q3b205cdeuabc7e204044cca5b@mail.gmail.com>
	 <slrne0e36r.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 17:13:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEqP0-00057O-W1
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWCBQLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWCBQLk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:11:40 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:34536 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752001AbWCBQLj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 11:11:39 -0500
Received: by nproxy.gmail.com with SMTP id l36so301792nfa
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 08:11:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tmPiYm3VG3uguhUJtPaiMOCD2OTgbWGBa4sGiuuF7N/re4junWvrLxNhyOG7CrCHZ1ZIDWxb2OprnjktfHsS9uQ0YH80tR0QCPb9d17Xj9SlGAxQr8Ayy5goBwVWQU5990tm6Cqr/LAj3qI460wuMBuMpXoWIaxBMB3sDsx0/7c=
Received: by 10.48.244.5 with SMTP id r5mr258016nfh;
        Thu, 02 Mar 2006 08:11:37 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 08:11:37 -0800 (PST)
To: "Mark Wooding" <mdw@distorted.org.uk>
In-Reply-To: <slrne0e36r.fr9.mdw@metalzone.distorted.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17088>

On 3/2/06, Mark Wooding <mdw@distorted.org.uk> wrote:
>
> > AFAIK, windows has only one argument, returned by GetCommandLine?
>
> This is true, but there's a standard quoting convention which (in
> particular) Microsoft's C library uses to split the single argument back
> into an argv.  The spawn* functions quote; the C library startup stuff
> unquotes and splits.

Doesn't for programs using WinMain, which is probably 90% of all
windows programs.
