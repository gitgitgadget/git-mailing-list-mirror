From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: checkout Error on cygwin
Date: Tue, 17 Apr 2007 17:15:46 +0200
Message-ID: <81b0412b0704170815g77b0a7cdj7dd45d53396660f8@mail.gmail.com>
References: <5c08a49c0704170608s4f643bf6ubc53d521149f2d55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joan Ripoll Balaguer" <joan.ripsa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:16:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpPb-0002JL-Ge
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXDQPPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbXDQPPr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:15:47 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:53598 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965095AbXDQPPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:15:46 -0400
Received: by an-out-0708.google.com with SMTP id b33so2255454ana
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 08:15:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qmvLMmkP3677yoaWqW7lcZYjPlwWideBfS2dQdAKd/dbow67P6JpXD8jSVIy6i3RBhRXeGTvQiKtdtbINgDqGWUokC3oAz6GHF7MhNuILBErEOOSm4xoQxhHxcSEnZZNEO/3oZJV9nM0dS283eQAUCVshPpx6l3s9K70pTDFE2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8gjKRcfdG+ZL5uVWlzSmdwcTBtln66slwVyhEuiFnVPp3Oms3oUT5ARDUXlCFWm04WdjR96lqBkLfPker2cTr5ld1g1T6A6QlIpcvFvV3l2EtGp+hTPYSMR17G5KWdyHSf7oT5oLIh9h3wYy1jaBxGHrbXyuO6OokCvPGzTuic=
Received: by 10.100.7.18 with SMTP id 18mr5526518ang.1176822946160;
        Tue, 17 Apr 2007 08:15:46 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 17 Apr 2007 08:15:46 -0700 (PDT)
In-Reply-To: <5c08a49c0704170608s4f643bf6ubc53d521149f2d55@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44777>

On 4/17/07, Joan Ripoll Balaguer <joan.ripsa@gmail.com> wrote:
>
> $ git checkout master
>       6 [main] git-read-tree 2640
> C:\cygwin\usr\local\bin\git-read-tree.exe: *** fatal error - could not
> load shell32, Win32 error 487
>

haven't seen this one yet. Cygwin bug, I'm sure.
Try "strace -o cygwin.bug --mask=all git-read-tree master" and send
the output to cygwin maintainers. And a copy to Bill Gates, just for fun.
