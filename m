From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [PATCH] gitk : External diff viewer.
Date: Thu, 31 Jan 2008 18:50:38 +0100
Message-ID: <F0FADF3C-E33F-4BA9-B014-312F91CFA7F2@zib.de>
References: <1201795202.11689.9.camel@bod-tarcila2.ad.mc.com>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Thomas Arcila <tarcila-s5SjKpinsOs@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Jan 31 18:51:25 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKdZM-0008Gy-6M
	for gcvm-msysgit@m.gmane.org; Thu, 31 Jan 2008 18:51:24 +0100
Received: by yw-out-2122.google.com with SMTP id 4so2407105ywc.37
        for <gcvm-msysgit@m.gmane.org>; Thu, 31 Jan 2008 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=B4gOPQhU2T9jtFhXFF1+KIK6NPOct5VHS59Kunp0xns=;
        b=xi2ZV0LSgiqT0Ulf0+O7OjvNwOuu46M2cxuvM9Z/kv7xCd5HClzQnvwi5761aqnsy/ujUsJNkblHrw0JS/RCtNGs5BiPET09kbEd8PhX3+0lSM3nkilfyQ2C45qTiO1WIyJa+rlFYQt3TO+yS6wdc8NQuIbaDKyzW7RGoSqnnIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=IjTw/0TYdqCChsy9oAqkoEimJRna/SPN2RgZCfFbpZel09vTiBGdypkyXZLpWCYXmr5zetndASZhV58lTenA6lgle7LKrlAmAEjAG7EeC7Ivy3PYWrkUeDrhLya7cYoDtNj3kN4mYO6dXTOWCEdgynQxmSWsmw5ERM8R6uJpjaw=
Received: by 10.100.168.18 with SMTP id q18mr549644ane.12.1201801852952;
        Thu, 31 Jan 2008 09:50:52 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1550hsa;
	Thu, 31 Jan 2008 09:50:52 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.126.2 with SMTP id d2mr13881488pyn.1.1201801852062; Thu, 31 Jan 2008 09:50:52 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id x46si5068014pyg.3.2008.01.31.09.50.51; Thu, 31 Jan 2008 09:50:52 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0VHndJi021977; Thu, 31 Jan 2008 18:50:50 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0VHncWo000405 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Thu, 31 Jan 2008 18:49:38 +0100 (MET)
In-Reply-To: <1201795202.11689.9.camel-+NgBfe53rIlR1FB8S1TzorOUoyqYp7Dr@public.gmane.org>
X-Mailer: Apple Mail (2.753)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72133>



On Jan 31, 2008, at 5:00 PM, Thomas Arcila wrote:

> Right click on patched file list view gives "External diff" popup  
> menu entry,
> launching selected external diff tool.
> The diff tool is configurable through Edit/Preference/External diff  
> tool.
>
> Signed-off-by: Thomas Arcila <tarcila-s5SjKpinsOs@public.gmane.org>
> ---
>
> Hi,
>
> Here is a patch to gitk that allows to run an external diff viewer.
> It can be configured in Edit/Preferences/External diff tool.
>
> To see the diff between two files:
> - select revisions to diff
> - right click on a file in the patched files list view
> - choose "External diff"
>
> Any feedback is welcome.

Various combinations of showing diffs between index, work tree, and  
commits
work for me.  I haven't yet found any problems.

	Steffen
