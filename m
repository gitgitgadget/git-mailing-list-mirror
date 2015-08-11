From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH bc/connect-plink] t5601-clone: remove broken and
 pointless check for plink.exe
Date: Tue, 11 Aug 2015 19:26:22 -0400
Message-ID: <CAPig+cQd-ocaKV3V+Ky34i_Fw5RDo-HZ0Qm3=2km7o0YRja3BA@mail.gmail.com>
References: <55CA6066.5070500@kdbg.org>
	<CAPig+cS2CPFPBK+4W56dRVUas8UDpV1FZfMmOqxm6mprW+O_mw@mail.gmail.com>
	<xmqq37zpo2nr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Git Mailing List <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBD2JJCMYYEGBBHUJVKXAKGQEPNH67JI@googlegroups.com Wed Aug 12 01:26:25 2015
Return-path: <msysgit+bncBD2JJCMYYEGBBHUJVKXAKGQEPNH67JI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-io0-f186.google.com ([209.85.223.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2JJCMYYEGBBHUJVKXAKGQEPNH67JI@googlegroups.com>)
	id 1ZPIw4-0001uJ-1g
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 01:26:24 +0200
Received: by iodb91 with SMTP id b91sf789372iod.0
        for <gcvm-msysgit@m.gmane.org>; Tue, 11 Aug 2015 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=BHD3jpS/nuu4L723PpUBQ9hB4qtO5N+ySLYiqpphbTo=;
        b=vcn3Y0JiKyd/PohC4XibjZXQ4uORZ77vJE7IsR6oBSviVSA3b8F6tHhYXeTyX003hB
         f/MWuwv0JguIisQnW+KdzYmWi5aZM61kNpBGrWnEpAhL1IlxxTdo5F8Bl1dBasRvEq2J
         saLYLQlLQCr8UGXLZZmy6eBE0Qo6C06zS/R99r5BfVtrzheMYzto6yH+GnqSJcvWj+8b
         4s2NzKSru2CQyl+jv2xsSeJdYea6NJHY8E/EI7g6wt2x2QfaPJpmteYKpTP0S8/4eL81
         GSU87MJvp8rk7TwCgiB9B2j9Ocy0JaTizVUWy9qfCn5GQveC15rmJquPN/ZiOU0wuos5
         e6lQ==
X-Received: by 10.140.31.70 with SMTP id e64mr250514qge.12.1439335583239;
        Tue, 11 Aug 2015 16:26:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.31.55 with SMTP id e52ls598367qge.16.gmail; Tue, 11 Aug
 2015 16:26:22 -0700 (PDT)
X-Received: by 10.129.131.212 with SMTP id t203mr27464283ywf.35.1439335582430;
        Tue, 11 Aug 2015 16:26:22 -0700 (PDT)
Received: from mail-yk0-x234.google.com (mail-yk0-x234.google.com. [2607:f8b0:4002:c07::234])
        by gmr-mx.google.com with ESMTPS id g144si348638ywb.6.2015.08.11.16.26.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 16:26:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::234 as permitted sender) client-ip=2607:f8b0:4002:c07::234;
Received: by ykay144 with SMTP id y144so580301yka.3
        for <msysgit@googlegroups.com>; Tue, 11 Aug 2015 16:26:22 -0700 (PDT)
X-Received: by 10.129.1.213 with SMTP id 204mr6737801ywb.48.1439335582300;
 Tue, 11 Aug 2015 16:26:22 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.37.208.78 with HTTP; Tue, 11 Aug 2015 16:26:22 -0700 (PDT)
In-Reply-To: <xmqq37zpo2nr.fsf@gitster.dls.corp.google.com>
X-Original-Sender: sunshine@sunshineco.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::234
 as permitted sender) smtp.mailfrom=ericsunshine@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275744>

On Tue, Aug 11, 2015 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Aug 11, 2015 at 4:51 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> Invoking plink requires special treatment, and we have support and even
>>> test cases for the commands 'plink' and 'tortoiseplink'. We also support
>>> .exe variants for these two and there is a test for 'plink.exe'.
>>>
>>> On Windows, however, where support for plink.exe would be relevant, the
>>> test case fails because it is not possible to execute a file with a .exe
>>> extension that is actually not a binary executable---it is a shell
>>> script in our test. We have to disable the test case on Windows.
>>>
>>> Considering, that 'plink.exe' is irrelevant on non-Windows, let's just
>>> remove the test and assume that the code "just works".
>>
>> putty and plink are used on Unix as well. A quick check of Mac OS X,
>> Linux, and FreeBSD reveals that package managers on each platform have
>> putty and plink packages available.
>
> But they do not force their users to say "plink.exe", but instead
> let them invoke "plink", no?
>
> The test before the one that was removed is about "plink" (sans .exe),
> and what was removed is with ".exe", so I think J6t's patch is OK.

Ah, you're correct. I overlooked the extra emphasis j6t's commit
message placed on ".exe".

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
