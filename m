From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: [PATCH 0/3] fix test suite with mingw-unicode patches
Date: Wed, 16 Jul 2014 13:01:00 +0200
Message-ID: <53C65B6C.3020304@virtuell-zuhause.de>
References: <20140712075035.GA12400@ucw.cz> <1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com> <53C5B0A1.4060502@gmail.com> <20140716092959.GA378@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
 GIT Mailing-list <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>, Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCL7JHHTPAIPFNUZTYCRUBHLBZEVI@googlegroups.com Wed Jul 16 13:01:08 2014
Return-path: <msysgit+bncBCL7JHHTPAIPFNUZTYCRUBHLBZEVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f188.google.com ([74.125.82.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCL7JHHTPAIPFNUZTYCRUBHLBZEVI@googlegroups.com>)
	id 1X7MxP-0001pm-71
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 13:01:07 +0200
Received: by mail-we0-f188.google.com with SMTP id t60sf89862wes.25
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Jul 2014 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=hq+nEfVfndAFGd279iZm83YsYDVkIIumPnRZs7YYmU0=;
        b=rhi7crtJH+uJ2SECcm2jIPiNyNxjOOF5wEu2UG3qgHa25TSyx/as1Tql2i+0Qb/3z4
         SzZvDSoAxyJbcTbmvbRgV2iIpzp96Wy4rJNJy7Uc6m2NFLlbDrS9Cnboj0Mo3+j1X7Do
         RFRdtSWr8unI7oMOVACokO9JTV2WlPIiUOnUyMW7jTMtFnUEPQBRlpp0IVJtu5xUyXTL
         57MFFIkZLAnI3m7lFYMDdAPCW/SfgGS9iKRRVGi6EFtpuXdSeWznKrdGo7EFzICb19DN
         E5Dz66BBE5uioxZxAQR2CWWpwA4qGUc4pVqh2D7H07jK2c12PNd6CVCXgG9HKhR1UF/a
         0feA==
X-Received: by 10.152.36.37 with SMTP id n5mr275875laj.3.1405508466747;
        Wed, 16 Jul 2014 04:01:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.133 with SMTP id q5ls101631laj.77.gmail; Wed, 16 Jul
 2014 04:01:05 -0700 (PDT)
X-Received: by 10.152.6.200 with SMTP id d8mr1975894laa.4.1405508465843;
        Wed, 16 Jul 2014 04:01:05 -0700 (PDT)
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de. [2a01:488:42::50ed:84a3])
        by gmr-mx.google.com with ESMTPS id cj4si804056wid.0.2014.07.16.04.01.05
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 04:01:05 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@virtuell-zuhause.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:84a3;
Received: from p3ee2f6cd.dip0.t-ipconnect.de ([62.226.246.205] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1X7MxK-0001wv-Ce; Wed, 16 Jul 2014 13:01:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140716092959.GA378@ucw.cz>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1405508465;cabc5eb6;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253663>

Am 16.07.2014 11:29, schrieb Stepan Kasal:
>> * t7001-mv: 6
>> cp -P fails in MinGW - perhaps use the long option forms (--no-dereference)?
> 
> "cp -P" fails with our 2001-edition of cp, so msysgit had to revert:
> https://github.com/msysgit/git/commit/6d3e23d4
> 
> But I was ashamed to mention that upstream; and I hope mingwGitDevEnv is
> going to solve that.

Yes it does. cp in mingwGitDevEnv is from coreutils 5.97 and knows about -P.

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
