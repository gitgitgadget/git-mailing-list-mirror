From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH nd/dwim-wildcards-as-pathspecs] t2019: skip test
 requiring '*' in a file name non Windows
Date: Thu, 13 Aug 2015 10:30:08 +0200
Organization: gmx
Message-ID: <3a67b9f0c21518c9e3d8e2d33bbfd2ee@www.dscho.org>
References: <55CA5D56.6030800@kdbg.org>
 <a9e3c007fb6b39e7339c8d2b1c50d56b@www.dscho.org>
 <xmqqbnecmpyc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCZPH74Q5YNRBFNLWGXAKGQEIMK3AOY@googlegroups.com Thu Aug 13 10:30:17 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBFNLWGXAKGQEIMK3AOY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f59.google.com ([209.85.215.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBFNLWGXAKGQEIMK3AOY@googlegroups.com>)
	id 1ZPntv-00075R-BI
	for gcvm-msysgit@m.gmane.org; Thu, 13 Aug 2015 10:30:15 +0200
Received: by labcl3 with SMTP id cl3sf9806983lab.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 13 Aug 2015 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:cc:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=5zHHyFFBZy8EMUIv7ddkjDGz47s4U1DUG1ntEaTs1cw=;
        b=awGkcYVdkkwgDTjqgrRzG4rclrpzgBxMdSKe7mjAQ+wThoGukOYbKljKdGgbKgJUxh
         FlJmKR8I9DEbgs711RdLlNgIzVe/b3hWbzEYstfWUFiqi7i3t7CE3DIWSs03l4cepXO2
         DRWk8My9kbg1rB7j3wvol52/8VHxGARb13jUgvqaunEvXdgeTYAXdCkzpx3tDwRaFEZC
         TG9A9MAmT418tSUVBuRBKwqLzQe/Uvx0tLwwtc0D7OkhlUS4EoF9IrwSuJjST1JWyRPt
         xvy+HyJjvSmuiYOQSzvT7q96Q/TS13W0wZIYNVMbc+eG0A3SJRNRbDcsFGcnHr9VZLF2
         nTBg==
X-Received: by 10.180.21.195 with SMTP id x3mr119944wie.13.1439454615080;
        Thu, 13 Aug 2015 01:30:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.35.73 with SMTP id f9ls1416320wij.4.canary; Thu, 13 Aug
 2015 01:30:13 -0700 (PDT)
X-Received: by 10.180.35.162 with SMTP id i2mr8234535wij.6.1439454613214;
        Thu, 13 Aug 2015 01:30:13 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id hm7si60592wib.0.2015.08.13.01.30.13
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2015 01:30:13 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MarAM-1Z6Utm36YE-00KNHT; Thu, 13 Aug 2015 10:30:08
 +0200
In-Reply-To: <xmqqbnecmpyc.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Sddk4iCSG1pqagmB9aojIdZgBFcwkpLoWYJS+xN6KL1yvpy8Ld5
 UFaQSR6Gbf606zLtYbEWecar3ye+jl2+KKL++pWARwGV8e7k0fIAVyZmr3eoUZm3A5nwDX7
 NbbrIyGUK7kaVKAlFzjVsvyNmTrvT78J4Rvcqu31N668iHbQMxqWJrF5IZ07LYGOLDSbUZB
 R+RWJd+IKvRtoZXBaphvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vn/TfHrKBv4=:T7NldvM0pyDdPJybTQ6Q4+
 gkv3AZpx64wjH2jc+4e/J158xSZspVE0rYA7MLEyAv4fNNwqOCqhlY7vIyXUAhaZxjszC65bX
 Xfwbb6DmBok2hhRcwGp1jqz5ApTdHp1E9gOZq4uJ74W+Nj1osxiQmlWDXoHKNwYY6i++7Xxpu
 gIM+tMbBoFpPySRVhq+e5GyLdnBvAByzUsRsNee5qv6p4bVPvGz+aY2e6dHyXFhtZ4ppVSlx2
 /pg6N4wN3bx4xR0GzaE9OowgNQIgPUAHABprI4TFIzyeBF7bcOOjSQKw+cU3mkgNMZ73epFfa
 FeJnMfIXz37hY0dtgldqrl/SPCXZBrScEMHaCg7SDI8tbjyUOWJtl+h6OHIiDwLdVQeU7xudP
 yTcU4O4xw44HxFk6fau4/9dyCqMtuTPhtnV3JxsFy6NQSS38prZLxBfWn3wmSCmo9NIdz4j9P
 R7/Z9uKc96781AV2936X4lhxoaBrnc6+0dvPpfc+RD/KECYEZknNNepq1gF7+6MayiZ0hZRpI
 DFGpodXQ5G9za68YRJOjDWyRvKma8gaNSdv/R05aWhvuT8f/Sw9ZK3ttpG5EfNhCQDkr4pvsp
 m6m/yLa8KCfp1fjq34F+sWDpTYxMUOnCSzavwHdYDs3hvP6mi+I66RGr3xiIXG/uhJ/vW2iYT
 vQxuEoxvL6a1JYLphlGsjlBliF3SOXFQ7WsXaMIS6qbwLf4Ic97JyvH9W1zw8M/7apTt0Yduz
 vmXPUfOQ/2k1EsjT/HxuyrXEYhpnF74wiHxMcQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.20 as
 permitted sender) smtp.mailfrom=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275837>

Hi Junio,

On 2015-08-12 18:28, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> On 2015-08-11 22:38, Johannes Sixt wrote:
>>
>>> diff --git a/t/t2019-checkout-ambiguous-ref.sh
>>> b/t/t2019-checkout-ambiguous-ref.sh
>>> index 8396320..199b22d 100755
>>> --- a/t/t2019-checkout-ambiguous-ref.sh
>>> +++ b/t/t2019-checkout-ambiguous-ref.sh
>>> @@ -69,7 +69,7 @@ test_expect_success 'wildcard ambiguation, paths win' '
>>>  	)
>>>  '
>>>
>>> -test_expect_success 'wildcard ambiguation, refs lose' '
>>> +test_expect_success !MINGW 'wildcard ambiguation, refs lose' '
>>>  	git init ambi2 &&
>>>  	(
>>>  		cd ambi2 &&
>>
>> FWIW I planned to submit a patch including this fix:
>>
>> https://github.com/git-for-windows/git/commit/4694320330e1b4d9178e13e215ce60a1cc8e0b1c
>>
>> (The idea of the `fixup! ` was to make this change part of a larger
>> change during the next merging rebase of Git for Windows.)
> 
> Thanks.  Is that an Ack?

Yes, this is an Ack. (Although I would have preferred to organize the contribution of Windows-related patches better, really.)

Ciao,
Dscho

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
