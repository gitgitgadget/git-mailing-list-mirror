From: Johannes Sixt <johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org>
Subject: Re: how to detect git.exe directory?
Date: Sun, 23 Dec 2007 17:35:00 +0100
Message-ID: <200712231735.00336.johannes.sixt@telecom.at>
References: <e5bfff550712230825o5e73bd3dm31057847106b8722@mail.gmail.com>
Reply-To: johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "Git Mailing List" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: mcostalba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Dec 23 17:35:27 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6TnS-0008QJ-Ht
	for gcvm-msysgit@m.gmane.org; Sun, 23 Dec 2007 17:35:26 +0100
Received: by wr-out-0708.google.com with SMTP id 56so7443508wra.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 23 Dec 2007 08:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=y88wf5ApJ+JM2yKwOaf1S9hIyK0+sp8moGPqN1NS/XA=;
        b=Rcjo6KuF0syVK35QoN9e91LV5+Wljcyfi+xp9l02zpxGl7XKvhAtWhBGPskNfvmYsEzwj68VfisPlAAXTP2RkCdP0Qx3KKL6JpfvSrZbwAyHt6jW3LboXiU/BgZDI8FwHqwOVRZLiPqj0+NIwfHPS5ZeFms+tHXGJBwdWOFx4R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=lpgnJcJCQaVLFFnx9dxG/6VlybfUOcfKpUjYIfoHcOoweM+VJQ4TFe5XT95NQ7CcdWVmGQBoGZ/gqwH7mi6Gvf2VzV2+3W0xseUI4H7+h6SSBjEQH9KQt1yeZhc+kb60EhlJeA8kDakUqmkhGgPFF6Ou/1w1Y1YvpNE9tt7jOBg=
Received: by 10.100.151.5 with SMTP id y5mr78400and.20.1198427703486;
        Sun, 23 Dec 2007 08:35:03 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1276pro;
	Sun, 23 Dec 2007 08:35:03 -0800 (PST)
X-Sender: johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.140.225.19 with SMTP id x19mr983354rvg.7.1198427703335; Sun, 23 Dec 2007 08:35:03 -0800 (PST)
Received: from smtp5.srv.eunet.at (smtp5.srv.eunet.at [193.154.160.227]) by mx.google.com with ESMTP id h49si6216204nzf.5.2007.12.23.08.35.02; Sun, 23 Dec 2007 08:35:03 -0800 (PST)
Received-SPF: neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org) client-ip=193.154.160.227;
Authentication-Results: mx.google.com; spf=neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org) smtp.mail=johannes.sixt-dl2ejS2iUSazZXS1Dc/lvw@public.gmane.org
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19]) by smtp5.srv.eunet.at (Postfix) with ESMTP id 675ED13ADC6; Sun, 23 Dec 2007 17:35:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by dx.sixt.local (Postfix) with ESMTP id 1C0814CC1A; Sun, 23 Dec 2007 17:35:01 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <e5bfff550712230825o5e73bd3dm31057847106b8722-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69185>


On Sunday 23 December 2007 17:25, Marco Costalba wrote:
> To easy the user and allowing to call qgit.exe double clicking on a
> nice desktop icon I need a way to know where git.exe is installed *at
> runtime*.
>
> So my question is: "What is the preferred way to detect git directory
> at runtime for msysgit files?"
>
> - environment variable ??
>
> - windows registry ??
>
> - others ?

Running

	git --exec-path

should get you close to it. But I have to question why you need that path.

-- Hannes
