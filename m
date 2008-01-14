From: Stephan Hennig <mailing_list-KvP5wT2u2U0@public.gmane.org>
Subject: Re: [PATCH] gitk: make Ctrl "+" really increase the font
 size
Date: Mon, 14 Jan 2008 15:52:07 +0100
Message-ID: <fmft8d$kuv$2@ger.gmane.org>
References: <fm5oln$ahq$1@ger.gmane.org> <alpine.LSU.1.00.0801111238150.31053@racer.site>
Reply-To: mailing_list-KvP5wT2u2U0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 14 16:06:37 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEQtE-0007tp-5V
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jan 2008 16:06:16 +0100
Received: by wa-out-0708.google.com with SMTP id n36so2366786wag.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Jan 2008 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ZmE1BSO+jtsHPCzYOqECZJSYOxLdZ3NHaRbFZBqY9w4=;
        b=QulPZp8av0Dq+4V0RBoIERxXWGRLhASNa2RlG1EyqjF5URZ8GFue57hE7Kn2hluSUn1hs1Eg/nuvTW3DOEmQZOcPORYgy47anAYLYBi4zzC9lI9Y4G7CiW/MKVXG75K18rQ+OKhYJE9t84fqemtKRt1YKyOrspzFkD0YdAge0aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=uzZ32t/CT8SPI4SUddNkhQn29bDym/aXtZRgcwvAMg4djMCDYHyYPTMv9urlZ7KZFk5STdPMtElO+Qemf8XxUGOiQE4YzcYP9aJcVbGQj8meiijzyy/4db8ad5cdDj6JN+UbM+nZS7EXsXw5bqEIGlGIaa7MkVPYk4lgQxe2qSE=
Received: by 10.142.147.15 with SMTP id u15mr41172wfd.15.1200323146421;
        Mon, 14 Jan 2008 07:05:46 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1397hsa;
	Mon, 14 Jan 2008 07:05:46 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.36.1 with SMTP id j1mr1150969waj.25.1200323145728; Mon, 14 Jan 2008 07:05:45 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id h49si2687092nzf.5.2008.01.14.07.05.45; Mon, 14 Jan 2008 07:05:45 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from root by ciao.gmane.org with local (Exim 4.43) id 1JEQs2-0001S2-Gz for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Mon, 14 Jan 2008 15:05:02 +0000
Received: from dialin-145-254-070-092.pools.arcor-ip.net ([145.254.70.92]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 14 Jan 2008 15:05:02 +0000
Received: from mailing_list by dialin-145-254-070-092.pools.arcor-ip.net with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Mon, 14 Jan 2008 15:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-070-092.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
In-Reply-To: <alpine.LSU.1.00.0801111238150.31053-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70460>


Johannes Schindelin schrieb:
> 
> Only Ctrl "=" was bound to increase the font size, probably because
> English keyboards have the plus on the same key as the equal sign.
> However, not the whole world is English, and at least with some
> other keyboard layouts, Ctrl "+" did not work as documented.
> 
> Noticed by Stephan Hennig.
> 
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
> 
> ---
> 
> 	On Thu, 10 Jan 2008, Stephan Hennig wrote:
> 
> 	> 
> 	> Hi,
> 	> 
> 	> reducing font size in gitk with CTRL-- works, but enlarging font 
> 	> size fails.  Typing CTRL-+ just doesn't have any effect here.
> 
> 	This is no bug in msysgit, but in gitk.
> 
> 	Paul, please apply.

The bug is still present in gitk that comes with Msysgit

> $ git version
> git version 1.5.4.rc3.941.gebb79

Best regards,
Stephan Hennig
