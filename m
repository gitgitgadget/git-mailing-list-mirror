From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 19:55:39 +0100
Message-ID: <46d6db660701231055u63259fave0f33e9b52fc9bff@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <200701222127.09601.johannes.sixt@telecom.at>
	 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <46d6db660701230512l571d8c35k24e475c3fe0933cf@mail.gmail.com>
	 <Pine.LNX.4.63.0701231517290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 19:55:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Qo9-0008IC-Ri
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 19:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965384AbXAWSzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 13:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965391AbXAWSzm
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 13:55:42 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:48303 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965384AbXAWSzk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 13:55:40 -0500
Received: by an-out-0708.google.com with SMTP id b33so715545ana
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 10:55:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oE6mSeakeSqHZxujCpJ8rI1AbM4OjIS2Hxwtg6VYx7JCJH3dHWKg6qfM61eyUOM3jv7cp3bRy3arQq5bEo2gQBvYFCMmSUHYuPDztPd61rWWn/0MNELN8T5KwYJLabeSmqfsEBltyX8N+xP5vNMYVZd5pM+xvdCsZU17QqyIDKw=
Received: by 10.78.201.2 with SMTP id y2mr562881huf.1169578539274;
        Tue, 23 Jan 2007 10:55:39 -0800 (PST)
Received: by 10.78.175.18 with HTTP; Tue, 23 Jan 2007 10:55:39 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231517290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37556>

On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > maybe I'm stuck with windows at work, but I still use vim inside mingw.
>
> I don't:
>
> $ vi
> m.AllocationBase 0x0, m.BaseAddress 0x715B0000, m.RegionSize 0x4D0000,
> m.State 0x10000
> C:\msys1\bin\vim.exe: *** Couldn't reserve space for cygwin's heap
> (0x715B0000 <0xB10000>) in child, Win32 error 487

interesting. which version of msys are you using ?
I'm using this snapshot successfully:
msysCORE-1.0.11-2007.01.19-1

> > it would be nice to fix the pager issue...
>
> Go ahead!

well:

git log | less

:)

seriously enough, I do not know where to start. I guess we're
close to mingw limitations of fork() ??

--
Christian
