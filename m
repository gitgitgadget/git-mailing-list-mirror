From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 09:24:36 +0200
Message-ID: <483FABB4.1010309@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805281414.36141.jnareb@gmail.com> <483DA594.5040803@gmail.com> <200805300127.10454.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 09:25:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1yzW-0000MT-I8
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 09:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbYE3HYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 03:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbYE3HYk
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 03:24:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:46196 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbYE3HYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 03:24:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so58272fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 00:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=BsRlwEYviEGctmIY45bEOWFR9TQNY7d9uI7Fe3oiIwc=;
        b=HcT0xLPnXCj6PW+BQ6UKNjTGZ1GVyCDp1XtY19doPZpbUP8cgsPesSDM2Fmr1T9U5PqzgZqtEaMITNc3/sDclfxWdCmnNjc0yhf5I2+JKoyoY7UlHVbMxcna3G/29pbTSugFgQfKNB/d7p3oc/mv4dOf4g2mSWB98itVV5n2ISI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=xFylOg6V3L9PhaMEXHcdCIEGZ6D/FHR2ZCvEqA6Xge72lqamhzkwCn3RMWxkd847g/EECf9Kzg6aJL6CrkVFKVCxyD+YR9kadpI8i/suAmOGXuBowztoYiykVABjpr7J24P2D7oIVouMCGcE+IaVMvQnP/+4x9KrDcQnj/JuX1c=
Received: by 10.86.98.14 with SMTP id v14mr382872fgb.74.1212132277450;
        Fri, 30 May 2008 00:24:37 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.225.53])
        by mx.google.com with ESMTPS id 4sm210033fgg.6.2008.05.30.00.24.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 00:24:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200805300127.10454.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83270>

Jakub Narebski wrote:
> you cannot assume that memcached API is installed, so
> you have to provide some kind of fallback.

That fallback would be to have no caching. :)  I think that's acceptable 
-- I'm not too willing to implement caching for two API's. 
(Incidentally, memcached takes two shell commands to install and get 
running on my machine; I think that's acceptably easy.)

> What's more, if you want to implement If-Modified-Since and
> If-None-Match, you would have to implement it by yourself, while
> for static pages (cahing HTML output) web server would do this
> for us "for free".

Are web servers doing anything that we can't easily reimplement in a few 
lines (and, on top of that, more easily tailored to different actions, 
projects, etc.)?

> By the way what do you think about adding (as an option) information
> about gitweb performance to the [HTML] output,

Definitely a good idea!

> I hope you have some ideas in gitweb access statistics from kernel.org,

I'm waiting for John to give me SSH access and/or send them my way. :)

> and you plan on benchamrking gitweb caching using [snip]

Absolutely -- thanks for the suggestions!

-- Lea
