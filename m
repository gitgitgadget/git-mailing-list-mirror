From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Bug - Git reset --quiet not quiet
Date: Tue, 13 May 2014 11:42:08 +0200
Message-ID: <CABPQNSbw335wEeDfc+3Jg2X+Zv2422vPf5P5Wwm8NWbuYPMVQA@mail.gmail.com>
References: <764966de191443d68e7ceca790b641ff@CO1PR02MB029.namprd02.prod.outlook.com>
 <CABPQNSaj3xwknXsrYnF35tcDAmTwK5KALOsUOgHF_hrEf2H_+g@mail.gmail.com> <5371E818.1090001@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas-Louis Laforest <tllaforest@arbault.ca>, "git@vger.kernel.org" <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDR53PPJ7YHRBGOSY6NQKGQE6SS5A4Q@googlegroups.com Tue May 13 11:42:51 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBGOSY6NQKGQE6SS5A4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f63.google.com ([209.85.160.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBGOSY6NQKGQE6SS5A4Q@googlegroups.com>)
	id 1Wk9EY-000827-Ki
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 11:42:51 +0200
Received: by mail-pb0-f63.google.com with SMTP id rr13sf13887pbb.18
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 May 2014 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=QnY4Bh4RjJTnqWnan8E26jtTCNgZfodmTeGgFRt+MY4=;
        b=tXh6p2YpkwoEMrcoDYmP8N2pj12uax3034Twh/blSsJCxSuiTSKjJhYSE0Jrmg9sqr
         7J0AbXkJwfvoUkQfK6ufWjoVo9bzTtFGhe4uG/eRerqmig7Yqlp7AmyxeUFWbc6M++oO
         JSbXXaJyYX/yorreQb7lahMvN1yJDCdU2T/fxePf8EIEBQ1YhU9DTPqk17KcjQDn9DFi
         /+aW5SF6yDUKnUEGCmZyiOM+mNmAt/XFWxSdh7k9pB033XQt3FEg9DuCGR5L5l8am6ce
         Hl3eqkc50zPOuznxHxiD9PWfZDS7l3kH9Gnzn09rWpG5fBWNXasoe9RETIB+DXKJ3VbJ
         kFsQ==
X-Received: by 10.50.25.4 with SMTP id y4mr624869igf.10.1399974169559;
        Tue, 13 May 2014 02:42:49 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.152.67 with SMTP id uw3ls2096153igb.38.gmail; Tue, 13 May
 2014 02:42:49 -0700 (PDT)
X-Received: by 10.66.141.135 with SMTP id ro7mr13811481pab.28.1399974169003;
        Tue, 13 May 2014 02:42:49 -0700 (PDT)
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com [2607:f8b0:4001:c05::233])
        by gmr-mx.google.com with ESMTPS id jj2si897995igb.3.2014.05.13.02.42.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 02:42:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::233 as permitted sender) client-ip=2607:f8b0:4001:c05::233;
Received: by mail-ig0-f179.google.com with SMTP id hn18so158808igb.6
        for <msysgit@googlegroups.com>; Tue, 13 May 2014 02:42:48 -0700 (PDT)
X-Received: by 10.50.22.69 with SMTP id b5mr56059418igf.45.1399974168865; Tue,
 13 May 2014 02:42:48 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 02:42:08 -0700 (PDT)
In-Reply-To: <5371E818.1090001@viscovery.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::233
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248759>

On Tue, May 13, 2014 at 11:38 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 5/13/2014 11:09, schrieb Erik Faye-Lund:
>> On Mon, May 12, 2014 at 9:16 PM, Thomas-Louis Laforest
>> <tllaforest@arbault.ca> wrote:
>>> When running this command on Git for Windows (version 1.9.2-preview20140411)
>>> git reset --quiet --hard with one file having read/write lock git ask this question :
>>> Unlink of file 'XXXX' failed. Should I try again? (y/n)
>>>
>>> I will have expected the command --quiet to remove the question and auto-answer no.
>>> This broke an automated script we use.
> ...
>> I guess this could be solved in a few ways.
>> 1) Let mingw_unlink() know about the quiet-flag. This probably
>> involves moving the quiet-flag from each tool into libgit.a.
>> 2) Make the quiet-flags close stdout instead of suppressing every output.
>> 3) Make the higher level call-sites of Git EBUSY-aware. This probably
>> involves making an interactive convenience-wrapper of unlink, that
>> accepts a quiet flag - similar to what mingw_unlink does.
>
> Is any of this really needed? We have this in ask_yes_no_if_possible():
>
>         if (!isatty(_fileno(stdin)) || !isatty(_fileno(stderr)))
>                 return 0;
>
> i.e., we answer "no" automatically without asking if at least one of stdin
> and stderr are not a terminal. Perhaps the OP's problem is that they do
> not redirect these channels to files or something in their automated
> scripts? In particular, it should be sufficient to redirect stdin from
> /dev/null (a.k.a. "nul" on Windows).

Well, sure. But if sounds like surprising behavior to me. And I also
suspect doing this unconditionally on all platforms will fix strange
corner-cases on other systems, when using Windows file-systems. AFAIK,
the whole "cannot delete an open file"-thing is an NTFS-detail (and
possibly also FAT, which is quite commonly used on non-Windows).

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
