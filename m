From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: Weird filename encoding issue
Date: Sat, 18 Oct 2008 10:22:24 +0400
Message-ID: <c6c947f60810172322o12beeb80xfd39b551b0db7c99@mail.gmail.com>
References: <c6c947f60810170059s3859d906r9935b5e80d8a41c6@mail.gmail.com> <c6c947f60810170108q3038b66bj2ad89bdcb7105903@mail.gmail.com> <48F852FC.2070506@viscovery.net>
Reply-To: agladysh@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 18 08:23:43 2008
connect(): Connection refused
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f62.google.com ([209.85.217.62])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr5Dy-00017W-Mf
	for gcvm-msysgit@m.gmane.org; Sat, 18 Oct 2008 08:23:42 +0200
Received: by gxk22 with SMTP id 22so1119482gxk.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Oct 2008 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=mN6W8k2c5zbMtRWWJpw18YPPc7plW0RhXSE1agX95/A=;
        b=exTHd2kNQZolAZPSyv2BFcHIBMsYkYV71W86T1zQMUekZudE9/rWPWfnMj7UBWkOa5
         fFlVxlXGJVFPk7odeaQzf8n30eIHMY8a2ZCk+oOScQI1VSsZrrV+LdVF6jlKI4QUmpM+
         oC+6rkwgssFh9eI2rPkuNNnNr2M+MIlMTlIfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:references:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=MH7BzcxDpgHoNegaPy8dpMpHJF0SKD8/lsCrWl7Eha8eoMkbMHfz6W6wkULxLo3T9o
         s9wruqoilYPp4fm1sH4ZxCMOU1RKFVQLwNsnZu2mRrZOzkX2xb+qtTNNeywRDzndiYmV
         oWdi3WBSZH84K8U/p3uKfiVpwP4SMeB6NyXi4=
Received: by 10.100.45.5 with SMTP id s5mr118896ans.10.1224310948006;
        Fri, 17 Oct 2008 23:22:28 -0700 (PDT)
Received: by 10.106.151.34 with SMTP id y34gr3098prd.0;
	Fri, 17 Oct 2008 23:22:26 -0700 (PDT)
X-Sender: agladysh@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.60.2 with SMTP id i2mr771953waa.5.1224310945949; Fri, 17 Oct 2008 23:22:25 -0700 (PDT)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238]) by mx.google.com with ESMTP id k19si929365waf.2.2008.10.17.23.22.24; Fri, 17 Oct 2008 23:22:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of agladysh@gmail.com designates 209.85.198.238 as permitted sender) client-ip=209.85.198.238;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of agladysh@gmail.com designates 209.85.198.238 as permitted sender) smtp.mail=agladysh@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0506.google.com with SMTP id k40so839471rvb.19 for <msysgit@googlegroups.com>; Fri, 17 Oct 2008 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=NhA42lHRLVRm1fHmOnh2Tige5whId61XQhWuUmMEglE=; b=QSLeHC4p2tyMKmOCsb4d2zucg6E0b/4+K9F4Ev8HZPS1CrZ91SPrpTgA1xDBOIyryh DwM3sLLrjwQPTgKgdegGN2CwsBXDwCj3wrKQ9XUT4hDT72rB3+Gtfkm09zjJL43GZiJY VgG+n/RgFb6GoDJGlKz3PZGytmrClTbwkXli0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=qyJLoCO+AIu/I1dS1vehiuu4gpeM6l2TzfOiNV1+U7CjqSKClOe+9GmZPknu5vbtTv JgxE8yktjg8NQfUUtcn2QCa0dg1RVmlIWCD2XzIWraFbpUYUzLOJRy0Ru1stnQXD2ugl UbwTb3HgioDlcRK37BmVl8BNUTNLcL4JDCw/g=
Received: by 10.141.74.17 with SMTP id b17mr3086344rvl.119.1224310944893; Fri, 17 Oct 2008 23:22:24 -0700 (PDT)
Received: by 10.140.188.5 with HTTP; Fri, 17 Oct 2008 23:22:24 -0700 (PDT)
In-Reply-To: <48F852FC.2070506@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98523>


Thanks for answers, guys.

<...>

> git asked OS X:
>
>   Does the file "\312\356\357\350\377.txt" exist?
>
> and OS X said: "Yes". Because otherwise, you would have seen the file
> listed as "deleted:" in the 'git status' call above.
>
> But then git also requested a file listing from OS X in order to list the
> untracked files. And now OS X returned the name "%CA%EE%EF%E8%FF.txt". How
> could you expect git to tell that this is the same file when OS X cannot
> decide how to name it?
>
> The solution: Do not use file names with some local (let alone Windows
> specific) encoding if you have to use the files on OS X, too.

Thank you, but this is not the solution, this is a workaround.

1. Git hooks do not work under msysgit. Thus I'm not able to prevent
people on Windows from committing weird filenames to the repo. (Please
don't start elitist discussion that people using git must do
everything conciously.)

Note also, that even if hooks would work, such files still may appear
in the repo in theory (somebody may disable hooks after all).

2. Now I have one such file. I'm managing my repo on OS X, and have no
access to other machines right now. How can I create commit that
renames the file? Git GUI manages to create commit that adds the
renamed file, but does not delete old one.

Alexander.
