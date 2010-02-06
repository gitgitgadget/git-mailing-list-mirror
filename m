From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: upload-pack timing issue on windows?
Date: Sat, 6 Feb 2010 11:06:04 +0100
Message-ID: <201002061106.04305.j6t@kdbg.org>
References: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
 Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: 3fz9tSwMIB3ce1ofYWb.jmbhntnbdobjjbgZbmjpkn.Xjh@groups.bounces.google.com Sat Feb 06 11:08:19 2010
Return-path: <3fz9tSwMIB3ce1ofYWb.jmbhntnbdobjjbgZbmjpkn.Xjh@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3fz9tSwMIB3ce1ofYWb.jmbhntnbdobjjbgZbmjpkn.Xjh@groups.bounces.google.com>)
	id 1NdhaM-0002We-0P
	for gcvm-msysgit@m.gmane.org; Sat, 06 Feb 2010 11:08:18 +0100
Received: by yxe5 with SMTP id 5sf12250275yxe.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 06 Feb 2010 02:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=bEexwu3z6NE7dFc6J1dqUgd4GdcfjuRpffYU5OLtM4c=;
        b=2A+cBcJKnTi7/CFNBDWhMJnIvVvgSGNCs4hz2kV36fZ/WmqcI5QDvujvVRZAqZEmlR
         TOgr22WraAK4XrqV+0BZvZhyDbFp5JC5Sh2sqvwHCndLG8kdYJQ9UOA5d0+LVQ/Ez4w4
         +hSROo6RS2D+x/3WTq6nZrYR5SoNdoCXB+WfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=Iho4lYgKjSC6HE1Wnd7J5QvZiW42f9DyYf43O8kxoUHR/3mwsBqq2YsbD9u5QHCSfP
         2b1v68nJHEcXEvspzzMvOyDs0zBWueOH5KcU4MoZyjtkynEjEXvOsVSuk4OLw6TYwlrp
         cIljA88htclNnN2TFXPT93f5h8YAq3VoBLris=
Received: by 10.100.233.40 with SMTP id f40mr55416anh.39.1265450879060;
        Sat, 06 Feb 2010 02:07:59 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.223.58.206 with SMTP id i14ls243359fah.1.p; Sat, 06 Feb 2010 
	02:07:56 -0800 (PST)
Received: by 10.223.95.92 with SMTP id c28mr177744fan.24.1265450876708;
        Sat, 06 Feb 2010 02:07:56 -0800 (PST)
Received: by 10.223.95.92 with SMTP id c28mr177743fan.24.1265450876684;
        Sat, 06 Feb 2010 02:07:56 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 17si297592fxm.11.2010.02.06.02.07.56;
        Sat, 06 Feb 2010 02:07:56 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 24C6AA7EEA;
	Sat,  6 Feb 2010 11:07:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 8F00619F6B8;
	Sat,  6 Feb 2010 11:06:04 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1002051551o6d116a50uee3f6a32b16adb46@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/56f6d7fe458cd633
X-Message-Url: http://groups.google.com/group/msysgit/msg/6f2d9b006360e4f8
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139155>

On Samstag, 6. Februar 2010, Erik Faye-Lund wrote:
> As some of you might know, I've been working on porting git-daemon to
> Windows for quite some time now. As it stands now, there's really only
> one known issue that is blocking on my end here:
>
> Something weird happens *sometimes* when upload-pack is exiting,
> leading to a client dying with a "fatal: read error: Invalid
> argument\nfatal: early EOF"-error. If I place a sleep(1) at some place
> after exiting the while(1)-loop in create_pack() in upload-pack.c, the
> symptom goes away. create_pack() contains some async-code, but this
> doesn't seem to be triggered in my minimal case at all. I've tried
> flushing stdout and stderr explicitly, no luck.

I've observed timing related issues in upload-pack as well, but only in the 
case where the die() is called from the async thread. This is the reason why 
t5530 does not pass.

But your case seems to be different - i.e. there is no die() involved. Sorry, 
can't help more...

Perhaps use Procmon to analyse differences among the different successful and 
failing cases.

Try hacking fetch-pack so that it does not announce side-band(-64k). Perhaps 
it makes a difference.

-- Hannes
