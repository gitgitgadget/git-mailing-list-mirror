From: Akira Kitada <akitada@gmail.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 15:03:55 +0900
Message-ID: <AANLkTimz4vHXN-YngO6rUjaTc+-sdNm20GAG4ta9Z2TC@mail.gmail.com>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
 <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
 <AANLkTindQ8Nty=eUGNgREish0K-=dGgg9qXjWbefKb3M@mail.gmail.com> <AANLkTi=QJ8bbyNHwFibY+W9dMyiYa5s_ne0zG8Ltt0um@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 08:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4p1D-00034r-NZ
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 08:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab0JJGES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 02:04:18 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49937 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab0JJGER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 02:04:17 -0400
Received: by qyk1 with SMTP id 1so1610120qyk.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 23:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=CqsysgOcc9r5va25M4KobwlQ8UUKTgfe/6TVCbQVxtY=;
        b=OM4zcTWlQkIgy9wK+mqnioKMlyNyMkYBQyXZC6kS0AxCu6MSJw0UuvMt2f2rwTUFGz
         GBT72QGfF7BXbqnUcpxV/F5qfw+87tXvohFeLc3veO+w5Agdr2E6EErVLJE2iIFbFgSt
         ZvtO+V8iWVozSLPtWDB3nvIe1u7x81OLJCweg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JRZn+PCzttsHgXZcrUn9rpSCs9KuWFpjWHPuxAV/ZR3U9/X6/pJaU1ydQrkEOCfr2i
         uTl/GHnsmDJ+DDRHKteFVaDxb7CCk0/jMKlBFiW5MfjobSSFKrEJ3c2XnxEuu86/5F30
         l27qwk2ZO/bPVPofR9xyNcZTM+8F6aAl0YLTk=
Received: by 10.224.45.16 with SMTP id c16mr3245347qaf.310.1286690656897; Sat,
 09 Oct 2010 23:04:16 -0700 (PDT)
Received: by 10.220.191.73 with HTTP; Sat, 9 Oct 2010 23:03:55 -0700 (PDT)
In-Reply-To: <AANLkTi=QJ8bbyNHwFibY+W9dMyiYa5s_ne0zG8Ltt0um@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158645>

I upgraded ExtUtils::MakeMaker to 6.56 and ran make again but it
didn't fix the issue.

On Sun, Oct 10, 2010 at 2:48 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Hi,
>
> On Sun, Oct 10, 2010 at 1:25 PM, Akira Kitada <akitada@gmail.com> wrote:
>> I use perl 5.8.9 and ExtUtils::MakeMaker is 6.48.
>
> Can you try upgrading it and running make again? I think the cpan
> commads for it are "r" (show upgrades) and "upgrade".
>
>> $ /usr/local/bin/perl -v | grep v5
>> This is perl, v5.8.9 built for i386-freebsd
>>
>> What version of Perl does Git require to build?
>> It seems INSTALL does not mention it.
>
> Ah, Perl is used for git-add--interactive and git-svn.
>
> --
> Cheers,
> Ray Chuan
>
