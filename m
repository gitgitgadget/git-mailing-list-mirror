From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Tue, 07 Oct 2014 21:57:45 +0200
Message-ID: <543445B9.508@kdbg.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>	<20141006051707.GA23305@seldon> <5432E45A.8000208@kdbg.org> <xmqqvbnvemak.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>, 
 msysGit <msysgit@googlegroups.com>,
 git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCJYV6HBKQIL3C6RUECRUBDW3CIB6@googlegroups.com Tue Oct 07 21:57:52 2014
Return-path: <msysgit+bncBCJYV6HBKQIL3C6RUECRUBDW3CIB6@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f184.google.com ([209.85.212.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIL3C6RUECRUBDW3CIB6@googlegroups.com>)
	id 1XbatK-0004fk-DD
	for gcvm-msysgit@m.gmane.org; Tue, 07 Oct 2014 21:57:50 +0200
Received: by mail-wi0-f184.google.com with SMTP id cc10sf486242wib.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Oct 2014 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=qotY/EcqIN4klH/2utdu/keq9CP4mYKJ3hQFMyb26g8=;
        b=GDgBoPIAZJDGDirEPz8t0To+XfFKhHUwzTCdlZ5Q5C3mziTxBcOyLFtFu1gbRLM09k
         XiktLWvDt9GdyA8xrQQ47bqkXGbiMN+BHZHRDa3P43rJMP3BSi8SSdGmPpxpbcR4Eg2W
         WdrqBN9Prn7UYwT17yTC3sHfnyZZl9YCnnQq32zglt8MDnLH/gda7fQDZEjN2K2l8UJd
         qL65oGTMzqcD/9Plluadnq9tp4SOQW0fxO+F8KVCG5pDTzHI+bYDrhcyXHrw+UL+iivy
         zdK62eqGDqsfZzHvvZtYaeYAfUloLH5O/eEbRbOICni8ygu5CbsZJkousSzU1/ZSuSbM
         Hkfg==
X-Received: by 10.152.87.13 with SMTP id t13mr27905laz.37.1412711870125;
        Tue, 07 Oct 2014 12:57:50 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.42.212 with SMTP id q20ls742597lal.22.gmail; Tue, 07 Oct
 2014 12:57:48 -0700 (PDT)
X-Received: by 10.152.26.225 with SMTP id o1mr885208lag.4.1412711868440;
        Tue, 07 Oct 2014 12:57:48 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp1.bon.at. [213.33.87.15])
        by gmr-mx.google.com with ESMTPS id ed3si775028wib.1.2014.10.07.12.57.48
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 12:57:48 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.15;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jC8bf48syz5tlD;
	Tue,  7 Oct 2014 21:57:34 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 928E119F361;
	Tue,  7 Oct 2014 21:57:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqvbnvemak.fsf@gitster.dls.corp.google.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257952>

Am 07.10.2014 um 21:01 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 06.10.2014 um 07:17 schrieb Marat Radchenko:
>>> On Tue, Sep 30, 2014 at 11:02:29AM +0400, Marat Radchenko wrote:
>>>> This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
>>>
>>> Junio, ping?
>>>
>>
>> Sorry, I forgot to report that this updated series works now for me.
>>
>> The patches all look reasonable. I don't have an opinion on the
>> restriction that MSVC < 2010 can't be used anymore (path 08/14).
> 
> So, is that an Ack, or would you prefer to cook this first in
> msysgit tree and then feed the result as part of "This series is to
> shrink the difference between the mainline and msysgit" later?

At this time, it's really just a "works for me" report, because I didn't
look carefully at each patch. I may do that at some time later.

If someone from the msysgit crew (I don't count myself to it) could
report "works for us, too", then the series could go into your tree
right away, in my opinion.

-- Hannes

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
