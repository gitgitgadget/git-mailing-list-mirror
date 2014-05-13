From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bug - Git reset --quiet not quiet
Date: Tue, 13 May 2014 11:38:32 +0200
Message-ID: <5371E818.1090001@viscovery.net>
References: <764966de191443d68e7ceca790b641ff@CO1PR02MB029.namprd02.prod.outlook.com> <CABPQNSaj3xwknXsrYnF35tcDAmTwK5KALOsUOgHF_hrEf2H_+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas-Louis Laforest <tllaforest@arbault.ca>, 
 "git@vger.kernel.org" <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: msysgit+bncBCJYV6HBKQIJXUGHTMCRUBARTHM4G@googlegroups.com Tue May 13 11:38:37 2014
Return-path: <msysgit+bncBCJYV6HBKQIJXUGHTMCRUBARTHM4G@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIJXUGHTMCRUBARTHM4G@googlegroups.com>)
	id 1Wk9AS-00018m-Bc
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 11:38:36 +0200
Received: by mail-lb0-f187.google.com with SMTP id q8sf7991lbi.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 May 2014 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=rs7Twr3FMiYf02E+v78Nxo1fvR+5myWxSkUqi+HND4A=;
        b=Xo986nz4V/98zGeOwetKJFzhSRc4roFJH6T6V5K7LPDUUKBAAQy0ncM7cgHUEq8bhl
         3gJOBUJ/vUz35QbG/A0xaWegPuYDeXG0DaDyyVLm1ugdsm7CX4cqSptzqJA4ogwtsQ6a
         h9t3AXmBgYwJi1yOqp7l7RG/Urv8zu11u0nTDNjap3szVLA8ZlxD6iOoj+Gi8puZmlaF
         dCqiLBV2StFGZpq1jSRojG5h1erITrPY6gs5+Uogsn0AgxGLe4IfbUdqU9sUIGkT1SyJ
         rb+djHf9TVU8gMB1WmSRU50i3AcIbUZmCvUHFlMQd3c4BS5+vZllQ4XVpx3hAhxKKMIg
         /cDg==
X-Received: by 10.152.116.44 with SMTP id jt12mr9631lab.10.1399973915955;
        Tue, 13 May 2014 02:38:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.205.11 with SMTP id lc11ls39146lac.79.gmail; Tue, 13 May
 2014 02:38:35 -0700 (PDT)
X-Received: by 10.152.42.141 with SMTP id o13mr141390lal.7.1399973915023;
        Tue, 13 May 2014 02:38:35 -0700 (PDT)
Received: from so.liwest.at (so.liwest.at. [212.33.55.19])
        by gmr-mx.google.com with ESMTPS id r49si943947eep.0.2014.05.13.02.38.34
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 02:38:34 -0700 (PDT)
Received-SPF: none (google.com: j.sixt@viscovery.net does not designate permitted sender hosts) client-ip=212.33.55.19;
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Wk9AO-00053M-T9; Tue, 13 May 2014 11:38:33 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9595A16613;
	Tue, 13 May 2014 11:38:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CABPQNSaj3xwknXsrYnF35tcDAmTwK5KALOsUOgHF_hrEf2H_+g@mail.gmail.com>
X-Spam-Score: -1.0 (-)
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j.sixt@viscovery.net does not designate permitted sender hosts) smtp.mail=j.sixt@viscovery.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248758>

Am 5/13/2014 11:09, schrieb Erik Faye-Lund:
> On Mon, May 12, 2014 at 9:16 PM, Thomas-Louis Laforest
> <tllaforest@arbault.ca> wrote:
>> When running this command on Git for Windows (version 1.9.2-preview20140411)
>> git reset --quiet --hard with one file having read/write lock git ask this question :
>> Unlink of file 'XXXX' failed. Should I try again? (y/n)
>>
>> I will have expected the command --quiet to remove the question and auto-answer no.
>> This broke an automated script we use.
...
> I guess this could be solved in a few ways.
> 1) Let mingw_unlink() know about the quiet-flag. This probably
> involves moving the quiet-flag from each tool into libgit.a.
> 2) Make the quiet-flags close stdout instead of suppressing every output.
> 3) Make the higher level call-sites of Git EBUSY-aware. This probably
> involves making an interactive convenience-wrapper of unlink, that
> accepts a quiet flag - similar to what mingw_unlink does.

Is any of this really needed? We have this in ask_yes_no_if_possible():

	if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
		return 0;

i.e., we answer "no" automatically without asking if at least one of stdin
and stderr are not a terminal. Perhaps the OP's problem is that they do
not redirect these channels to files or something in their automated
scripts? In particular, it should be sufficient to redirect stdin from
/dev/null (a.k.a. "nul" on Windows).

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
