From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 23:12:21 +0200
Message-ID: <CAHGBnuMdTYEPnYLM0ozqLLCxRJJOx4EL61kL=pbAfW47zK+_Jg@mail.gmail.com>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
	<20140419184210.GB3617@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marat Radchenko <marat@slonopotamus.org>, Git Mailing List <git@vger.kernel.org>, 
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: msysgit+bncBDZMLEGXWQLBBNONZONAKGQEU325Z6I@googlegroups.com Sat Apr 19 23:12:24 2014
Return-path: <msysgit+bncBDZMLEGXWQLBBNONZONAKGQEU325Z6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f185.google.com ([209.85.213.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBNONZONAKGQEU325Z6I@googlegroups.com>)
	id 1WbcYg-0001A2-Ue
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 23:12:23 +0200
Received: by mail-ig0-f185.google.com with SMTP id uq10sf73739igb.12
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Eyoi8omJAzya2YS3nXUm5X/rL7ItE4Pb27+aFnK6Fxw=;
        b=Dzoe+z/LJABX0hmXqSezxCH7Z6cidACdDuwB2ONTFOo3M6f5mFDMlucg1eRhaSMQDs
         KXd9q7h+VtRKqvzTdoiSrfrjnrxfHcFXPu2QQIPmjed+5iGLHVX3bn9nztOCrj7N2esU
         48adJfdMfpyDiQVzaR7vOTstdt7H8WF1h6do3RMCLZCPGY/gtYkOXYBCZyGf3iOzq7Tz
         DmBVa00ckU+y8gAid3PaJ8u3uo4af0dv6JPgU05TSMV6jBhDzO27kn7rExmkd5zjWh/v
         BGGa31/9EVFSkc3LXxvNY6vv73SrIgVcBW0F/esxMc98mDObw9Nau5BlWXY/5bAYunnC
         hjLA==
X-Received: by 10.140.108.2 with SMTP id i2mr3355qgf.16.1397941942069;
        Sat, 19 Apr 2014 14:12:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.90.11 with SMTP id w11ls1927164qgd.43.gmail; Sat, 19 Apr
 2014 14:12:21 -0700 (PDT)
X-Received: by 10.236.134.98 with SMTP id r62mr11861077yhi.14.1397941941572;
        Sat, 19 Apr 2014 14:12:21 -0700 (PDT)
Received: from mail-yh0-x22b.google.com (mail-yh0-x22b.google.com [2607:f8b0:4002:c01::22b])
        by gmr-mx.google.com with ESMTPS id f65si4541016yhg.7.2014.04.19.14.12.21
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 14:12:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2607:f8b0:4002:c01::22b as permitted sender) client-ip=2607:f8b0:4002:c01::22b;
Received: by mail-yh0-x22b.google.com with SMTP id b6so2441851yha.2
        for <msysgit@googlegroups.com>; Sat, 19 Apr 2014 14:12:21 -0700 (PDT)
X-Received: by 10.236.108.176 with SMTP id q36mr40433226yhg.18.1397941941498;
 Sat, 19 Apr 2014 14:12:21 -0700 (PDT)
Received: by 10.170.151.10 with HTTP; Sat, 19 Apr 2014 14:12:21 -0700 (PDT)
In-Reply-To: <20140419184210.GB3617@book-mint>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2607:f8b0:4002:c01::22b
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246541>

On Sat, Apr 19, 2014 at 8:42 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> But AFAIK its not ready for production use yet. I guess Sebastian would
> not mind contributions.

Not at all!

-- 
Sebastian Schuberth

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
