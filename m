From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 14:53:30 +0100
Message-ID: <08627A28-85DE-4E58-9DBA-9463A0D1DC1C@zib.de>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 14:53:10 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.245])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN7Be-0002CY-5a
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 14:53:10 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6365484wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 05:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=xCdTiaW3IlnphzpGqMqjuTkSRgg8dnSv5AV7x2FicL4=;
        b=R39kF737BswB+m4YZM9rDg/paLY61Y/30d1ZDLYMG9daXtcAHnjafH3beKVquyJcS6kEwOm67DRyqSr6UVC76yAgm9jzokiKs8z+TKhHAUlSJNjhXVL+sOZGFHvTpVjbTkT9RmbpbA4sJtU+5HwD1VVYsfsUdZQ5GhdZPNdjPP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=X0o61TkKvRzggL0LqwDQmoZY7i+DFrXwaiGoPVoKAEpybmhK5I8zw0l4NE94HoOtjYuhbE7I5tOPTRu603kfIEJ111/vAY/fRuOQfTXAtLUTqzySGcltqbEBHeEtUqLqVWyd8IFhLJcHV2YjfsXYPgXT4B0apf7OBucb3zjSXbY=
Received: by 10.115.48.12 with SMTP id a12mr804166wak.10.1202392357545;
        Thu, 07 Feb 2008 05:52:37 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1641pro;
	Thu, 07 Feb 2008 05:52:37 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr25012494pyi.7.1202392357270; Thu, 07 Feb 2008 05:52:37 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id z53si6578551pyg.1.2008.02.07.05.52.36; Thu, 07 Feb 2008 05:52:37 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m17DqQrZ010760; Thu, 7 Feb 2008 14:52:27 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m17DofXw024857 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Thu, 7 Feb 2008 14:52:26 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0802071324460.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72946>



On Feb 7, 2008, at 2:28 PM, Johannes Schindelin wrote:

> The Git installer of msysGit will always show the GPL, and have the  
> user
> accept it.

I agree.

	Steffen
