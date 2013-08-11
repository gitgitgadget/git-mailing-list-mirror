From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sun, 11 Aug 2013 16:05:07 +0200
Message-ID: <CABPQNSbvC8+skkPmcmh_LBrThO39A4FOdRTzum+uibooZk+stw@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
 <20130810125140.GD25779@paksenarrion.iveqy.com> <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
 <20130810163459.GE25779@paksenarrion.iveqy.com> <CABPQNSaU_69RxNEAAY0=BYdJm0ir_xkOkd2nPaxop7m0aJ9trg@mail.gmail.com>
 <CABJxLaMtHLGzwaxJgM3H9uFzb9_LMLzQ4_A6q0dcEOyShhb+kw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Sedat Kapanoglu <sedat@eksiteknoloji.com>
X-From: msysgit+bncBDR53PPJ7YHRBPFUT2IAKGQEZHNDA6I@googlegroups.com Sun Aug 11 16:05:51 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBPFUT2IAKGQEZHNDA6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f64.google.com ([209.85.220.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBPFUT2IAKGQEZHNDA6I@googlegroups.com>)
	id 1V8WHG-0006Ug-8J
	for gcvm-msysgit@m.gmane.org; Sun, 11 Aug 2013 16:05:50 +0200
Received: by mail-pa0-f64.google.com with SMTP id kx10sf399390pab.9
        for <gcvm-msysgit@m.gmane.org>; Sun, 11 Aug 2013 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=oR/tA9QrTyXOjYWngIPyL+v5z1+v4QMm/ePWvIA5LI8=;
        b=WkYlaxSbXP2Y9y8uPmknupeojDDSUGmQcuB1HzKEuSbXtrk5h76TbUUr6RJD4kKWaZ
         +YM8Aa/DCAzh55ipiFFr821lPtBrvp2APcQ+RXu/835LBSZfJXXQu9UJs9VXkc87ICKL
         gBZzILeWAmGql8cKs3gJoFwJz22qgEbJ0LsXm2BPBGJ4GlSeCmwIzAagZMNSbSuFM9Wq
         BqLjyVSNHFpueLYP4X7VCTaHTPTxgsHPJ8+DjkDEAWb0zhPAjAhVhS6P55FHFrJB/1QV
         /Sp+j8wt4ollxZ+zXbC0jg89B16UHx/aQn5lGIVUzCzJG0DMprF3K9A6ELJ7wcd6COVD
         Shxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=oR/tA9QrTyXOjYWngIPyL+v5z1+v4QMm/ePWvIA5LI8=;
        b=BZdKx1OPzgx/R1tuoyq8KiMoaXo3W2xvPFBFiP+qDg7b8Chdc+duUOR6fJOG78OYx0
         vy3jGAg1Be3Necg4aEj8UvxOfzH1gQ+Dm9t2MfTACPK7LsnsBsex3NKlSHa04VRc5l8T
         xphkz/H7jLRJ1SXePzgKvCn/vySCbEs2LZ+meNMs4jID+m0sgp8eg+byR0Fr9JyAN3is
         vnckYaLwzdLOsIQJtGTq0B/iXBAYRdb6Ye1T3Kn6zm0SThADDQ3JLai3pOquNcgGxY3y
         Ec+/nlt3ZD6gp/DiqBrjWwnGPmKUeghMHPxb4r9oQpd58pqIemCvVM6TZH9oAPv9gzvm
         mJXw==
X-Received: by 10.50.13.105 with SMTP id g9mr535654igc.9.1376229948900;
        Sun, 11 Aug 2013 07:05:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.43.168 with SMTP id x8ls1703832igl.15.canary; Sun, 11 Aug
 2013 07:05:48 -0700 (PDT)
X-Received: by 10.42.40.79 with SMTP id k15mr13130066ice.25.1376229948391;
        Sun, 11 Aug 2013 07:05:48 -0700 (PDT)
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com [2607:f8b0:4003:c01::232])
        by gmr-mx.google.com with ESMTPS id c7si1359929igm.0.2013.08.11.07.05.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 07:05:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4003:c01::232 as permitted sender) client-ip=2607:f8b0:4003:c01::232;
Received: by mail-ob0-f178.google.com with SMTP id ef5so4981924obb.9
        for <msysgit@googlegroups.com>; Sun, 11 Aug 2013 07:05:48 -0700 (PDT)
X-Received: by 10.60.54.39 with SMTP id g7mr7352685oep.18.1376229948078; Sun,
 11 Aug 2013 07:05:48 -0700 (PDT)
Received: by 10.76.22.79 with HTTP; Sun, 11 Aug 2013 07:05:07 -0700 (PDT)
In-Reply-To: <CABJxLaMtHLGzwaxJgM3H9uFzb9_LMLzQ4_A6q0dcEOyShhb+kw@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4003:c01::232
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) d=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232136>

On Sun, Aug 11, 2013 at 9:28 AM, Sedat Kapanoglu
<sedat@eksiteknoloji.com> wrote:
> Thanks folks. So that this won't be fixed, I added a new Q&A to
> MsysGit FAQ at https://github.com/msysgit/msysgit/wiki/Frequently-Asked-Questions
> , I appreciate if you can review and correct if needed. I hope it will
> help avoiding further conversations about this matter.

Thanks, that's very helpful!

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
For more options, visit https://groups.google.com/groups/opt_out.
