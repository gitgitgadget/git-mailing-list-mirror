From: dhruva <dhruvakm@gmail.com>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 1 Dec 2008 17:32:20 +0530
Message-ID: <e3f230850812010402n69cced19s3f36a5bcb84977c6@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com> <4933A922.7080300@viscovery.net> <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com> <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com> <e3f230850812010348w793e17c2q6ab92cf9b2c04972@mail.gmail.com> <4933D10E.6020706@viscovery.net>
Reply-To: dhruvakm@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Dec 01 13:03:45 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-1516.google.com ([209.85.146.162])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77V7-0006dZ-SY
	for gcvm-msysgit@m.gmane.org; Mon, 01 Dec 2008 13:03:42 +0100
Received: by wa-out-1516.google.com with SMTP id k6so397168wah.53
        for <gcvm-msysgit@m.gmane.org>; Mon, 01 Dec 2008 04:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Np3NIEOq5R8LP1O8zRdNAKT1OFUS6M5SeEH5fFyWkDE=;
        b=vOxt4Xe+HotKlY4geMYL0Wgr+2jDVBAr9cMKagfDlJFcMOGm/Wvaht9IMm9Ap1DrqH
         lpdjpN7wcBVQ9QF7hDZUx9c1B54jVFW+d1JT+JQgQwtecgve+/hCOtsu6T0lyGYPAFr+
         Ebo28SRyrXJgPu47j6tHl3LaoJRqLbAh+f9Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:references:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=LGzxwCc4jwnHvA26MShnG5bcafoluGSAjANvYdi5Vs44m2zn1Ip5smFPLmR2kEGJ5R
         1g3J4kXqsq1K7bsP8CwoFO12lVuXrzHTsnjRX+HE1SaZmNoTSBTyZRdtn/S6UoyUefdG
         5q8OmPN42rT7tts4v4B4RCiCAdfcXNUAulUvM=
Received: by 10.114.180.1 with SMTP id c1mr504839waf.17.1228132941999;
        Mon, 01 Dec 2008 04:02:21 -0800 (PST)
Received: by 10.106.176.3 with SMTP id y3gr3193pre.0;
	Mon, 01 Dec 2008 04:02:21 -0800 (PST)
X-Sender: dhruvakm@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.135.1 with SMTP id i1mr5881462wad.6.1228132941778; Mon, 01 Dec 2008 04:02:21 -0800 (PST)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170]) by mx.google.com with ESMTP id m37si3424588waf.0.2008.12.01.04.02.20; Mon, 01 Dec 2008 04:02:20 -0800 (PST)
Received-SPF: pass (google.com: domain of dhruvakm@gmail.com designates 209.85.200.170 as permitted sender) client-ip=209.85.200.170;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dhruvakm@gmail.com designates 209.85.200.170 as permitted sender) smtp.mail=dhruvakm@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by wf-out-1314.google.com with SMTP id 28so2697044wfa.25 for <msysgit@googlegroups.com>; Mon, 01 Dec 2008 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=uPClcs0ZkSiXoZlwxHfWV7v0jYbKMlkKkFVngepCefo=; b=va/yyiT4jLiGjMhZs5CT7QdKWO7B6Ne7NaWewTcUrLUKJgYFmViCr+5YO3u+kYSqXN cYDTd3hl4rsBIETxYogLllMy/8D93U8M5uHMJqnzwpmZihVIMp9QlUB7wMKhE7+oURda Nnt2Y1eyiX4Pl5jsxPV/K0YgXrLR08n0qPg+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=TDuRUvH00V4O04+EZB1Ka4FhFs2413M/hH/XkPaqvjuLSIeGr7E9Pqe0tTY15VmzXp xSUqW3yQbcAplpDFQ5EhH1FKti4JLngFmaUDctJNzSvU/lPVkcgF7yBZbIDUY44t6w5W h+xT83qebBaEcmahzJB9De7AtjVBmIK55Cmb4=
Received: by 10.142.241.15 with SMTP id o15mr4480404wfh.258.1228132940724; Mon, 01 Dec 2008 04:02:20 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 04:02:20 -0800 (PST)
In-Reply-To: <4933D10E.6020706@viscovery.net>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102026>


Hello,

On Mon, Dec 1, 2008 at 5:27 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> dhruva schrieb:
>>  I got the mob branch and I fail to see the Makefile. I decided to
>> just add the pthread related files and push so that someone could
>> build, I get authentication failures. I had tried to push perl
>> sometime back when I had a gcc compiler perl (before strawberry perl)
>> and had similar problems. I am fairly certain I am doing something
>> wrong but cannot figure it out!
>
> msysgit.git is *not* a git.git clone; it is the MSYS/MinGW environment to
> build git.git on Windows.
>
> You should apply the steps 1. to 4. that you mentioned in an earlier mail
> and push the result; but you cannot apply 5. because that is a change to
> git itself.

I request someone to just pull the archive I have placed just this
time, I will try again for other patches. I will create a clone in a
separate folder for msysgit and keep it ready. Unknowingly, I just
cleaned up the remote and lost all the changes I had pulled earlier :(

-dhruva

-- 
Contents reflect my personal views only!
