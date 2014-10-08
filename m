From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 08 Oct 2014 12:43:16 +0200
Message-ID: <54351544.9050907@virtuell-zuhause.de>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org> <543472A0.3020401@virtuell-zuhause.de> <20141008045330.GA5672@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCL7JHHTPAIMNKWUUECRUBBCABL5G@googlegroups.com Wed Oct 08 12:43:21 2014
Return-path: <msysgit+bncBCL7JHHTPAIMNKWUUECRUBBCABL5G@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f60.google.com ([74.125.83.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIMNKWUUECRUBBCABL5G@googlegroups.com>)
	id 1XboiG-0002br-Vw
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 12:43:21 +0200
Received: by mail-ee0-f60.google.com with SMTP id e51sf732708eek.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=oGD+nj9tgj+ON5aCTIHBw2pnwPqUgipg7iE+WCRw3Go=;
        b=AWYNzyxgN5cE3uK53gNtyTh5TB1mhMBD7h23egy+OLEq/td+kWN6jIk93j1lYYytQh
         7jpnlluF/ulGvpYyVFveEA9UNvth7H2OGI+brdeMzORt+kulyTEPX2DRfAeboazWLIxc
         SLaMZP8pH7ratgDk2vxd3WOCllz8BL1wZkKlZl3QgFZyY295ukDTWn74ueW1UTtblV2z
         s+5+/PRboPcCtKTiBaAQr7NJ+sk9un/QMye5pZ2CBlDvPQsD+++6n6EPS80ky8vAuz9C
         m+C3rPRF9HnB5NvBX37P+ve0mb6ZjqpJLOIRTd3WHXfYLcNa4ayw/dBOwwqipC90YTFc
         YuTw==
X-Received: by 10.152.7.99 with SMTP id i3mr5855laa.20.1412765000626;
        Wed, 08 Oct 2014 03:43:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.168 with SMTP id a8ls43095lab.55.gmail; Wed, 08 Oct 2014
 03:43:18 -0700 (PDT)
X-Received: by 10.152.19.131 with SMTP id f3mr1477378lae.0.1412764998392;
        Wed, 08 Oct 2014 03:43:18 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id rb5si2345798lbb.0.2014.10.08.03.43.18
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 03:43:18 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p5ddc06d9.dip0.t-ipconnect.de ([93.220.6.217] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1XboiC-0007gt-8f; Wed, 08 Oct 2014 12:43:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <20141008045330.GA5672@seldon>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1412764998;9c01866f;
X-Original-Sender: thomas.braun@virtuell-zuhause.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted
 sender hosts) smtp.mail=thomas.braun@virtuell-zuhause.de
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

Am 08.10.2014 um 06:53 schrieb Marat Radchenko:
> On Wed, Oct 08, 2014 at 01:09:20AM +0200, Thomas Braun wrote:
>> Am 30.09.2014 um 09:02 schrieb Marat Radchenko:
>>> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
>>>
>>> *Compilation* tested on:
>>>  - MSVC
>>>  - msysGit environment (twice)
>>
>> Hi Marat,
>>
>> I wanted to verify that on msysgit but some patches fail to apply
>> cleanly. Did you also had to tweak the patches?
>> If yes, are these tweaked patches still available somewhere?
> 
> msysgit != git-for-windows, as msysgit folks say. msysgit is a development
> environment for git-for-windows.

I surely know that!

> I tested my patches by applying them to git.git/master and building
> inside msysgit.

Fine, but then please explicitly state that. Compiling "git.git/master
in msysgit" and "msysgit.git/master in msysgit" are two different things.

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
