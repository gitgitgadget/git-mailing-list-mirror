From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: Re: git version 1.9.0 missing git-http-push?
Date: Mon, 28 Apr 2014 17:47:42 +0400
Message-ID: <20140428134742.GA18447@seldon>
References: <DAB1109C3DA82E48A383F6960A32A9E567020669@EXCH2010.inferno.local>
 <1398670610456-7608792.post@n2.nabble.com>
 <CABPQNSY-bM2pv7mn2R+wsnn944BkKbW6Hz2EhwrruPuxUJpUEQ@mail.gmail.com>
 <CABPQNSZh1GePGwm6_cC9Zf7N1LaeiavbnOxG4JoWMAab4GcfQQ@mail.gmail.com>
 <alpine.DEB.1.00.1404281519060.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCE7TAPITACRBBFY7GNAKGQEBHAKP4Y@googlegroups.com Mon Apr 28 15:47:50 2014
Return-path: <msysgit+bncBCE7TAPITACRBBFY7GNAKGQEBHAKP4Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f183.google.com ([209.85.214.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBBFY7GNAKGQEBHAKP4Y@googlegroups.com>)
	id 1WeluQ-0006yn-8i
	for gcvm-msysgit@m.gmane.org; Mon, 28 Apr 2014 15:47:50 +0200
Received: by mail-ob0-f183.google.com with SMTP id vb8sf1550885obc.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 28 Apr 2014 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=n58H58YwRC0Jbhw6OhkGvYBeUNJ/f4xs9CPC+vtexcU=;
        b=BFFoXUSMj+t4VmALB++OB6BenFU2OR+Va5j7ypDlH2CYUrOtVorMD3E/SUZw8Yu5H8
         e+Sl//HJzZw4lNb5fo41UvJyg4Z2yQAt5rg0+SEAuS09zi0uci4Kc2fxZiI9OKYpe1qa
         wBUFmgFHNllG9SYqZ1yo6cx+WRum76/V2ey+QqgUhEAUrR1YtbUXvjbb6tQuZ21pqOhe
         dlL06Q/FaMPmC+nCYLnLtaVNujkrcZwIAZzRL2M0ea6+zeAo5YA3p+L3cfbGsOkschgY
         /O8VUuzRgQQYe6MXLgTI5URC76DFSfPOwT/ZZklrG6XMnx34Nh/LSL261a8Ide4p46zW
         Gqww==
X-Received: by 10.140.102.150 with SMTP id w22mr71581qge.9.1398692869379;
        Mon, 28 Apr 2014 06:47:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.32.67 with SMTP id g61ls2661683qgg.12.gmail; Mon, 28 Apr
 2014 06:47:48 -0700 (PDT)
X-Received: by 10.236.134.235 with SMTP id s71mr2310136yhi.55.1398692868638;
        Mon, 28 Apr 2014 06:47:48 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id f5si2085774igh.3.2014.04.28.06.47.47
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 06:47:47 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WeluI-0004qK-LG; Mon, 28 Apr 2014 17:47:42 +0400
In-Reply-To: <alpine.DEB.1.00.1404281519060.14982@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247327>

On Mon, Apr 28, 2014 at 03:20:46PM +0200, Johannes Schindelin wrote:
> That way, upstream Git does not have anything to change (and we avoid
> discussing five versions of essentially the same patch :-P).

This bug isn't specific to msysGit but also affects all environments
where curl-config is not available or cannot be run for some reason,
for example during cross-compilation.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
