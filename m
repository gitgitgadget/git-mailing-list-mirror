From: Eyvind Bernhardsen <eyvind-git-A1zFcjaSW2ZTqyR7fV3oUw@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 14:23:52 +0100
Message-ID: <5157060E-A310-456B-96DE-7F9DF7CE7D05@orakel.ntnu.no>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 14:24:41 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.169])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6k2-0000iM-JL
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 14:24:40 +0100
Received: by py-out-1314.google.com with SMTP id p69so1690781pyb.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 05:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=j7M8IBVGYIgJcDTTPEQuwxwYGaElNa51Vrfx4X+7xtQ=;
        b=G/RwQITypPsa3vRUnd3gkdqJ3qWFbSmlioHPH4XYh3B6utr74U9CwKhsm/EJl6/TCirucoF1S+Xsc2CpERH4wT8fDkgxRxk2Bklb44HUEIbci2wY6mjU1H0D+Fzq8FjNPxJIgejKjOLpTFA1INXGQW1LD8WHyF5YMUWhd4cPRN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=gs1SGs/cfUJt2sb+3bSm11tYqbVbPoGOWS0eI/oPtGWeF2hBTBi5y+e5oCErxBaPcuWtdSHKeLwmD/tX9qXFHHfRlt6CRIYe6XRngVk0avRIXUhzlArim/4L7ivS82648ga05COCK9JxKBcKSCWs75rOQXCjtF1ZLYdYH2uYaXQ=
Received: by 10.141.176.6 with SMTP id d6mr388464rvp.15.1202390634681;
        Thu, 07 Feb 2008 05:23:54 -0800 (PST)
Received: by 10.106.243.37 with SMTP id q37gr1638prh;
	Thu, 07 Feb 2008 05:23:54 -0800 (PST)
X-Sender: eyvind-git-A1zFcjaSW2ZTqyR7fV3oUw@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.99.14 with SMTP id b14mr24983520pym.4.1202390634426; Thu, 07 Feb 2008 05:23:54 -0800 (PST)
Received: from eyvind.bernhardsens.net (97.84-49-228.nextgentel.com [84.49.228.97]) by mx.google.com with ESMTP id x46si6507566pyg.3.2008.02.07.05.23.53; Thu, 07 Feb 2008 05:23:54 -0800 (PST)
Received-SPF: neutral (google.com: 84.49.228.97 is neither permitted nor denied by best guess record for domain of eyvind-git-A1zFcjaSW2ZTqyR7fV3oUw@public.gmane.org) client-ip=84.49.228.97;
Authentication-Results: mx.google.com; spf=neutral (google.com: 84.49.228.97 is neither permitted nor denied by best guess record for domain of eyvind-git-A1zFcjaSW2ZTqyR7fV3oUw@public.gmane.org) smtp.mail=eyvind-git-A1zFcjaSW2ZTqyR7fV3oUw@public.gmane.org
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by eyvind.bernhardsens.net (Postfix) with ESMTP id 926F064EE29; Thu,  7 Feb 2008 14:23:52 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0802071255110.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
X-Mailer: Apple Mail (2.915)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72939>


On 7. feb.. 2008, at 13.55, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 7 Feb 2008, Luciano Rocha wrote:
>
>> Why do I have to accept the GPL to install msysgit?
>
> Because that's the only license you have to use git.

I think his point is that you don't need to "accept" anything to be  
allowed to use GPLed software. Presenting the GPL as a click-through  
licence on installation implies that you should read it carefully to  
see what limits are imposed on you, when in fact the GPL explicitly  
allows you to "run the program, for any purpose" (http://www.gnu.org/philosophy/free-sw.html 
).

> Get over it, or use another SCM,
> Dscho "who hates license wars"

No war for you!

Eyvind Bernhardsen
