From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 2/4] Properly accept quoted space in filenames
Date: Fri, 21 Nov 2014 10:42:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411211041560.13845@s15462909.onlinehome-server.info>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>, 
    Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
    Jonathan Nieder <jrnieder@gmail.com>, 
    Michael Wookey <michaelwookey@gmail.com>, 
    Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCZPH74Q5YNRBF4SXSRQKGQEZ66IQ6A@googlegroups.com Fri Nov 21 10:42:50 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBF4SXSRQKGQEZ66IQ6A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f59.google.com ([74.125.83.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBF4SXSRQKGQEZ66IQ6A@googlegroups.com>)
	id 1Xrkjn-0002kM-QG
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 10:42:47 +0100
Received: by mail-ee0-f59.google.com with SMTP id e49sf449261eek.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=OXn9AkcmAIfdL6uV5RqqKjZYy0VWAdlTXQ5cb/QdMRs=;
        b=cbsPOhnI8BvVqij4LmrxGriIEKq8iqgEwxw8yJZrHcjnhzSEAHVMeuTU4U+OnTQGlX
         AHdbKSWJ0228JCtDX9cjEQFubRl1/12+kCzYrB4FxC4Kq9kXE+B5jkR4Xr+yeF1f8GHx
         fjjqL6zGcFnwKenBlBIVHEl+avOu0WVAdJWSoEnrZ6dnVDSaAaMJVVtSu275UouWGvuh
         VF7HVDGzQuiCDx8VyDcjg+rXT0mN0SFT/NhrmRIfcuyfolZiFMdA7pHfIyfYSdqMN+/i
         YDv8CJTtV02e9ns5HlMdh5cCS2FJZHle2tvd+R5UnCR7NgX9b+qUBTxJ4VRuTNQh0gyr
         MfRQ==
X-Received: by 10.180.19.130 with SMTP id f2mr89718wie.7.1416562967346;
        Fri, 21 Nov 2014 01:42:47 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.23.101 with SMTP id l5ls1597613wif.8.canary; Fri, 21 Nov
 2014 01:42:46 -0800 (PST)
X-Received: by 10.194.104.227 with SMTP id gh3mr489512wjb.7.1416562966767;
        Fri, 21 Nov 2014 01:42:46 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id p14si465962wie.1.2014.11.21.01.42.46
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Nov 2014 01:42:46 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lw285-1Y1d9g273t-017mqg;
 Fri, 21 Nov 2014 10:42:41 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1416526682-6024-3-git-send-email-philipoakley@iee.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:HHoub0SB1up1ubQkC/wtgiEHutVptFzLQwomR99fTDyeJxxX3aD
 2RnLZOCkloxhOp3QGde/kz4eGFNOrQYGjC+mu1b/srA7L9iXqM2aNN1xaBfRxAdS3iVJAMZ
 xrOuqgibjtfjLoZt4MzrchAee+AAvl4v4lLy9kdJA/4HezxsOXcaqDaxvuSfEbY3VTPXoq7
 FLYX918/rXZGgaZxBEv9g==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Hi Philip,

apart from adding dead code:

On Thu, 20 Nov 2014, Philip Oakley wrote:

> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
> index 9144ea7..8e41808 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -243,7 +244,8 @@ sub removeDuplicates
>  sub handleCompileLine
>  {
>      my ($line, $lineno) = @_;
> -    my @parts = split(' ', $line);
> +    # my @parts = split(' ', $line);
> +    my @parts = quotewords('\s+', 0, $line);
>      my $sourcefile;

(i.e. the commented-out line) it looks good to me.

Ciao,
Johannes
