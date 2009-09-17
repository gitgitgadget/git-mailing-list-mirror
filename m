From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC 15/15] Tag GIT_VERSION when Git is built with MSVC
Date: Thu, 17 Sep 2009 22:18:15 +0200
Message-ID: <200909172218.15678.j6t@kdbg.org>
References: <cover.1253088099.git.mstormo@gmail.com> <aa80ad559c731ca73179956e34b2743d903fbbec.1253088099.git.mstormo@gmail.com> <894136433cc5b03a4b89a1f9c0e4f8a2704222fa.1253088099.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com
To: "Marius Storm-Olsen" <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Sep 17 22:18:37 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f138.google.com ([209.85.210.138])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoNR4-0004LW-Ck
	for gcvm-msysgit@m.gmane.org; Thu, 17 Sep 2009 22:18:34 +0200
Received: by yxe2 with SMTP id 2so461003yxe.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Sep 2009 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:received:from:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=AyZHW7Mfekn5ych4BZ19FaRwT1yqJY3NibDqzKueFjo=;
        b=sCoOsiElqChHjeDY/7PtcH4au8UDAh98ivAKqDJCJmlbSRgRobr3u2P16bmxZObQx6
         J5gVxZ8X2e2tsTmfsuZTtsg6F40N9GBHPufjZlalFh9j0bcfuVWDNWbNpvRDTEtyT1o5
         3yLdHovjNoWlbFSAITFIfSAGxeQN6EjNKlmqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=4U4Uo1Tr2BQmrOK+iyMbhuJV6mVVxeeyoBZDoxoyEWwgl2RM6gtJOJsN5LYtk998/c
         XSR5fdxdpGCpajzuiL3wt7vGzVME3CK3vWyBB1y+Faxu4gSm3LtjDl4ZM85y3CkmGiEf
         QqcjPfVOqOqonAYxDtdB6fu0NWrl+cE4XbB+8=
Received: by 10.100.240.3 with SMTP id n3mr85299anh.17.1253218707620;
        Thu, 17 Sep 2009 13:18:27 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr7079yqn.0;
	Thu, 17 Sep 2009 13:18:22 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.6.21 with SMTP id 21mr488319ebf.9.1253218699711; Thu, 17 Sep 2009 13:18:19 -0700 (PDT)
Received: by 10.210.6.21 with SMTP id 21mr488318ebf.9.1253218699687; Thu, 17 Sep 2009 13:18:19 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14]) by gmr-mx.google.com with ESMTP id 16si75280ewy.3.2009.09.17.13.18.19; Thu, 17 Sep 2009 13:18:19 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.14;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 213.33.87.14 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from dx.sixt.local (unknown [93.83.142.38]) by bsmtp.bon.at (Postfix) with ESMTP id 6A530CDF8A; Thu, 17 Sep 2009 22:18:17 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id C03473BEBE; Thu, 17 Sep 2009 22:18:15 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <894136433cc5b03a4b89a1f9c0e4f8a2704222fa.1253088099.git.mstormo@gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128768>


On Mittwoch, 16. September 2009, Marius Storm-Olsen wrote:
> This may help us debug issues on Windows, as we now can build Git
> natively on Windows with both MinGW and MSVC.
>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> ---
>  I'm just throwing this one out there. If people think manipulating
>  the version here, to ease debugging, I don't mind if this patch is
>  squashed into patch 12.
>  If people don't like it, just skip this path.
>
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index aa918eb..2c20922 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -878,6 +878,7 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
>  	UNRELIABLE_FSTAT = UnfortunatelyYes
>  endif
>  ifdef MSVC
> +	GIT_VERSION := $(GIT_VERSION).MSVC
>  	pathsep = ;
>  	NO_PREAD = YesPlease
>  	NO_OPENSSL = YesPlease

I like it, but I would not squash it into patch 12.

-- Hannes
