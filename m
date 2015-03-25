From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: Sparse checkout not working as expected (colons in
 filenames on Windows)
Date: Wed, 25 Mar 2015 07:39:49 +0100
Organization: gmx
Message-ID: <61604ca6e1c2c114f5b536be420ba73a@www.dscho.org>
References: <BE2660C974C9415E997F20A49ABC766E@PhilipOakley>
 <CACsJy8BOuhohQzaGzD+4cthqOaL4sz1ADRD-ekhFhKt4wMcg7A@mail.gmail.com>
 <90D5D4B5F2ED41A6AB07E291004AA615@PhilipOakley>
 <CACsJy8AACwDPSEWdGiLLK3PTY=hLm0XOvN4_y4PbCFYrMzrnHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, Git List <git@vger.kernel.org>,
 Yue Lin Ho <yuelinho777@gmail.com>, msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBO5QZGUAKGQEYEEPMYQ@googlegroups.com Wed Mar 25 07:39:57 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBO5QZGUAKGQEYEEPMYQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBO5QZGUAKGQEYEEPMYQ@googlegroups.com>)
	id 1Yaeyq-0007Q3-A2
	for gcvm-msysgit@m.gmane.org; Wed, 25 Mar 2015 07:39:56 +0100
Received: by lams18 with SMTP id s18sf5845276lam.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Mar 2015 23:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=IttNjxfWTgLZCo6tOMSE2l352AwysAovd+40fQN5qhc=;
        b=BxUC9SJCnUPzRZTmOE7HIW51bsbtgEyitmKs/CyhlJKXzvOsHzH8ByuZYEUYe9XTbh
         S6bqSN3gss9fFK6Q9tb5l4v5tuWphQU/IP7RqwUUDjDAHomZiiqtxYFStKcui13aFTXb
         HpVOWHF5nifO5rv32qvZXjZaVxxX5rZl8CJ3m3Yryav7aRjxORA1LCngOpjwQRfrgkqx
         UKmLhBdsOKMb7Sru2LKkLUC0piAgEhr4O+GWHDQI/zHzSpgPuQ2IVqFPXW1FruuckYZv
         pr3XvVLAlXJefjaW4nvfGEYGD7ArVpY1j1dvwXOk988iOQIN3Dr32kok2NnP/NbWugOu
         q2EA==
X-Received: by 10.180.86.135 with SMTP id p7mr134927wiz.6.1427265595893;
        Tue, 24 Mar 2015 23:39:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.130 with SMTP id q2ls1185134wiy.13.canary; Tue, 24 Mar
 2015 23:39:55 -0700 (PDT)
X-Received: by 10.180.218.2 with SMTP id pc2mr76564wic.0.1427265595192;
        Tue, 24 Mar 2015 23:39:55 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id bz6si837859wib.3.2015.03.24.23.39.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 23:39:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lqm3a-1Z51yp2Qsc-00eO1v; Wed, 25 Mar 2015 07:39:49
 +0100
In-Reply-To: <CACsJy8AACwDPSEWdGiLLK3PTY=hLm0XOvN4_y4PbCFYrMzrnHg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:i3rpT+gu2WZt9R69cU0V+wHsUpJrkWYOYnKF8xNPVXNWJeQaMmR
 8tcevFx+CfWL1tax43xPoaZ1Kr7KtLCGzIDXLbe1f4icwB+qEDgiyGWqWVnIRUj7i2mueSR
 Rve9YCKus5Jj8PLTSjDNWDzkMIJpOLjY0imyiHkWVxDfiO9+qIIb+cgJt5V4pgaiOcFzXio
 Wo4F+Eoge4+2dDRoktQ1Q==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266264>

Hi Duy,

On 2015-03-25 01:46, Duy Nguyen wrote:
> On Wed, Mar 25, 2015 at 6:50 AM, Philip Oakley <philipoakley@iee.org> wrote:
>
>> That said, the final error (which I'd missed in the earlier post) is:
>> fatal: make_cache_entry failed for path 'ifcfg-eth0:0'
>>
>> This is on the Windows (pre-compiled msysgit at v1.9.5) Git bash, so could
>> be a catch path in that code for make_cache_entry (I've not checked the code
>> yet). So at the moment it doesn't look like sparse checkout can be used to
>> avoid colons in windows on-disk files based on the current code.
> 
> Both of your commands below fail by the same function, verify_path()
> because of this msysgit commit 2e2a2d1 (NTFS: Prevent problematic
> paths from being checked out - 2014-12-10). I guess that check is a
> bit too strong, it should apply when new index entries are created
> from worktree (not from a tree)..

Oh, right, that check needs some relaxing. But certainly in a different way: you *definitely* want to prevent attacks from the outside, and those originate from the *tree*.

What we need to do instead is to relax the check to apply only if we are really going to write out that file, not when it is skipped.

Thanks,
Johannes

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
