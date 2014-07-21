From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Re: [PATCH 4/6] t4210: skip command-line encoding tests
 on mingw
Date: Mon, 21 Jul 2014 21:21:31 +0200
Message-ID: <53CD683B.3080407@kdbg.org>
References: <20140716092959.GA378@ucw.cz> <1405611425-10009-1-git-send-email-kasal@ucw.cz> <1405611425-10009-5-git-send-email-kasal@ucw.cz> <CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com> <xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1407211944510.3456@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, Stepan Kasal <kasal@ucw.cz>, 
 Karsten Blees <karsten.blees@gmail.com>,
 GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>,
 Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCJYV6HBKQIL7UFVTYCRUBBYM5ZU6@googlegroups.com Mon Jul 21 21:21:40 2014
Return-path: <msysgit+bncBCJYV6HBKQIL7UFVTYCRUBBYM5ZU6@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIL7UFVTYCRUBBYM5ZU6@googlegroups.com>)
	id 1X9J9U-0004Ce-B7
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jul 2014 21:21:36 +0200
Received: by mail-la0-f64.google.com with SMTP id el20sf855207lab.9
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=pWcX7wLUc0vWrWa2w4Wqyh6lmdzwIA9ICVtTQFsW3lA=;
        b=P0wCoEdCwceAYEmR9waKtdDZnhtAzE3PjH8ZCOgHiMwRMt9MqKg96LInlxmhhNVqX1
         Nj5hd5pBLOoGZ+MmVT5UJRzcqS3UohlCG0YaIsi7MrHMKeqgruk28t6cjhlhBmnj0H81
         ry5MnajaAm9a71/BBBJvjdqyUd03c5jnWd+b5clc9tE59toeFiBqZOq/MOA0XWVkoLnF
         6FyW1ixZwWBMj7Orc13WyJfmJVJwS9iVx/R6ROzKTBUgrK4yt8uR2YuHXhmVci9omhet
         QvINDYc0W6M+QuTp5mfeQq27jwgwM3ezAeuwsEmyOKkLy3JfL6JKDH3GnkyOgyU6pAIS
         1ugA==
X-Received: by 10.152.88.3 with SMTP id bc3mr276956lab.1.1405970495750;
        Mon, 21 Jul 2014 12:21:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.25.130 with SMTP id c2ls398051lag.78.gmail; Mon, 21 Jul
 2014 12:21:34 -0700 (PDT)
X-Received: by 10.112.167.138 with SMTP id zo10mr43351lbb.20.1405970494537;
        Mon, 21 Jul 2014 12:21:34 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp1.bon.at. [213.33.87.15])
        by gmr-mx.google.com with ESMTPS id r13si735667wib.0.2014.07.21.12.21.33
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 12:21:33 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.15;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1243C130082;
	Mon, 21 Jul 2014 21:21:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5C0AB19F489;
	Mon, 21 Jul 2014 21:21:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <alpine.DEB.1.00.1407211944510.3456@s15462909.onlinehome-server.info>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253990>

Am 21.07.2014 19:45, schrieb Johannes Schindelin:
> Hi Junio,
> 
> On Mon, 21 Jul 2014, Junio C Hamano wrote:
> 
>> Oh by the way, can somebody remind me why we spell these as
>> NOT_MINGW,  instead of !MINGW?
> 
> I guess that is my mistake; when I introduced the use of NOT_MINGW I was
> simply unaware of the !MINGW syntax.

You can hardly be blamed. The first occurrence of NOT_MINGW was added
much earlier than the ability to negate prerequisite tokens.

> Let's use the latter consistently?

Of course!

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
