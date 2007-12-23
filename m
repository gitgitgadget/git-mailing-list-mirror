From: "Marco Costalba" <mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: how to detect git.exe directory?
Date: Sun, 23 Dec 2007 17:53:17 +0100
Message-ID: <e5bfff550712230853u1bc0160ap936c2d0a6fe0203b@mail.gmail.com>
References: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com> <200712231735.00336.johannes.sixt@telecom.at>
Reply-To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "Git Mailing List" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Johannes Sixt" <johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Dec 23 17:53:48 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.250])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6U5C-0004lV-8G
	for gcvm-msysgit@m.gmane.org; Sun, 23 Dec 2007 17:53:48 +0100
Received: by wa-out-0708.google.com with SMTP id n36so649889wag.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Dec 2007 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=1+1Dp+O1s5dbOjs7en/W5NmoSTwcnkRNG+RuYfAzUBk=;
        b=02ByBmJ93uW/NARMEGjtYwfRMswqBGmgwR3nPWrJGXf15K8XdE72N2/DyDVOb6s/OCZRj4AIytPREJtD5hvG1JG1COyF9ndn8Kchx5L1/ujYVPJbLLJagxzXOR/lOHTuTmtxuvbDBWIo3yIWQYcgE9PAp1/yV5h7sQ5+56SOzD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=UcDehoabgwHS4KbLnf5xkcMOoWVgnSmkqdPQEPUWb0YJjKMXxaEpoqTjhSYFvfXXX/ys9xyQ0hCesGGMPps9DVh26aHEUrJ/GU2/d1KPrs1MQLSfvnjMheAmpuCm+99DEqs6oqpBmc26OV099CrgZeG8dbPZGD7lDblP6GnVR9s=
Received: by 10.114.78.1 with SMTP id a1mr113271wab.6.1198428800309;
        Sun, 23 Dec 2007 08:53:20 -0800 (PST)
Received: by 10.107.115.27 with SMTP id s27gr1277prm;
	Sun, 23 Dec 2007 08:53:20 -0800 (PST)
X-Sender: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.241.20 with SMTP id o20mr1602740wah.8.1198428800086; Sun, 23 Dec 2007 08:53:20 -0800 (PST)
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189]) by mx.google.com with ESMTP id k36si3413753waf.0.2007.12.23.08.53.18; Sun, 23 Dec 2007 08:53:20 -0800 (PST)
Received-SPF: pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.189 as permitted sender) client-ip=209.85.198.189;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.198.189 as permitted sender) smtp.mail=mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0910.google.com with SMTP id k15so834426rvb.45 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 23 Dec 2007 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=uSCQdQne8ujEfkRLpheXDVLnej0mP/fj60EyMICLOfY=; b=WT7HyDVbfr72n9mfXwcZ49mkA++/tJly9qMlQGthyaVUv2bEdC/DDpOWto8cwgjKI2TvWEzd7+Y6WdW4KSTxa1ya0HVUh0I4hqXbl8bJMLdj2gJH70dLPvm8hA023j13LiEDmxYoVY6RxuUCxt8BvlxCuGeJa8iBsDH0lIHPiX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=nsrcoO1UsumSXBHC/l5X4A2aB1d2EaL60OgJ/JG8gJ1882KDJl1aEBO6H+nhNx9bbSbD8Y6aw5HysSRfS4P9QTpPETtm0caFs4uqShm2cwr/HKHaWwqMYwfkxNblHkQjhvVyrC8dK7FojleCMQEaM78A6ZXlN9Z2FZAlRqSoeUc=
Received: by 10.141.83.15 with SMTP id k15mr1893618rvl.120.1198428797786; Sun, 23 Dec 2007 08:53:17 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 23 Dec 2007 08:53:17 -0800 (PST)
In-Reply-To: <200712231735.00336.johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org>
Content-Disposition: inline
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69186>


On Dec 23, 2007 5:35 PM, Johannes Sixt <johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org> wrote:
> On Sunday 23 December 2007 17:25, Marco Costalba wrote:
> > To easy the user and allowing to call qgit.exe double clicking on a
> > nice desktop icon I need a way to know where git.exe is installed *at
> > runtime*.
> >
> > So my question is: "What is the preferred way to detect git directory
> > at runtime for msysgit files?"
> >
> > - environment variable ??
> >
> > - windows registry ??
> >
> > - others ?
>
> Running
>
>         git --exec-path
>
> should get you close to it. But I have to question why you need that path.
>

What I'm looking for is git.exe itself. If I run "git --exec-path" I
get something along the lines "git executable not found..."

I don't use dashed command inside qgit, so I run "git log ..." not
"git-log ...", but the git.exe should be known to qgit or in path.

Hope it's clear.

Thanks
Marco
