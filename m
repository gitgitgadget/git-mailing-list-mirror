From: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 22:58:39 +0300
Message-ID: <20080207195839.GN30368@dpotapov.dyndns.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com>
Reply-To: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 20:59:31 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.171])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNCu1-0003UJ-3L
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 20:59:21 +0100
Received: by py-out-1314.google.com with SMTP id p69so2511639pyb.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=AdqBYbaNsTueFEXPx4Ozt2xvmrkD3YsVapZAzYQRWL8=;
        b=OK680T4uxzQIpDx0LFb3rUPHbs86LS0PYbYXZPDWbU0Md8Dkp6HuPYfAUr4KCSltRfe60TjqevBb7hcSPEPYdJZ7znwJKWJyD4X/o/59Xc3xe1La5Fe+FVv/47l9dE17THW90ej3FfpA0I8T9Y6X/KRSwzPklYk1Fy5eAh1Hk20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=tUuH2vhfFPZif+ttpMYcekOKA2cnGux7RZ/Si0baOEtvw7rlgQMPRwFXQBuT76u4Powzhv56gnrH02hqG2gJJlJwsCnkuh4lnfmlDUwyfsCvJR7qdxhZdvLbtDDCluCwNnDYRj3ldi3P3hkby6UDOSomTn4WwhQ9xhXhXGiQIlc=
Received: by 10.141.176.6 with SMTP id d6mr1035rvp.15.1202414326299;
        Thu, 07 Feb 2008 11:58:46 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1666pro;
	Thu, 07 Feb 2008 11:58:46 -0800 (PST)
X-Sender: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr25636856pyj.6.1202414326109; Thu, 07 Feb 2008 11:58:46 -0800 (PST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155]) by mx.google.com with ESMTP id x46si7324431pyg.3.2008.02.07.11.58.44; Thu, 07 Feb 2008 11:58:46 -0800 (PST)
Received-SPF: pass (google.com: domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 72.14.220.155 as permitted sender) client-ip=72.14.220.155;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 72.14.220.155 as permitted sender) smtp.mail=dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id e21so5074693fga.16 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 07 Feb 2008 11:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; bh=3nisEht7izvrCJ08n0EB5MK7S9LNLNwMYS/PQiUVObU=; b=B6pUT6Ru51WLk9Q/QnZEa1i4V3Zx6iKnRBf9LcsoeESVpvdgQ6ZCgws7ELY/rCGKOzQ4I89JEvcUjiSm9ZcU2ZZ9k8r/tls21gL4YvG/D8CHeU9IoT7oATO8Yw54Tc554ve+GI2aBSMJ2U0jGOiE4ljysj2Rga6B7uhp9DaKbH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; b=JVEgZrA0sL55G1O3u5d70Ink66QOYYeZEy7AZbB6A1BzcR0XlrT2BPoy4ul0nY/gFMGbHZwJth/lpVXV/OiIzbVZWY7uUwUaDlLgyCBZan2q1XKv37qdYF3gh8fO74RtTYx3zPSN4S0nUg6KVOUBf5XW88VdSK43E3+ygqJP27s=
Received: by 10.86.62.3 with SMTP id k3mr10819082fga.24.1202414323549; Thu, 07 Feb 2008 11:58:43 -0800 (PST)
Received: from localhost ( [85.141.191.183]) by mx.google.com with ESMTPS id d4sm5552198fga.2.2008.02.07.11.58.41 (version=TLSv1/SSLv3 cipher=OTHER); Thu, 07 Feb 2008 11:58:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080207123108.GA12009-oEplIgxCSygGFt9iVWuREaMaJEuR8uiQ@public.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72994>


On Thu, Feb 07, 2008 at 12:31:09PM +0000, Luciano Rocha wrote:
> 
> Why do I have to accept the GPL to install msysgit?
> 
> Only the "NO WARRANTY ..." should be required, GPL is only required for
> distribution (and you could make that information available at install).
> 

Section 1 of the GPL requires to "give any other recipients of the
Program a copy of this License along with the Program." AFAIK, showing
the License during installation is the traditional way to do so on
Windows. Please, note that the GPL clearly states that distribution is
possible "provided that you conspicuously and appropriately publish on
each copy an appropriate copyright notice and disclaimer of warranty."
IANAL, but it appears to me that if an installer that does not follow
the traditional way (for the target system) of publishing the copyright
notice, may be found in violation of the later requirement, and thus
any such distribution may deem as unlawful.

So, if you think about creating your own installer for Git, don't forget
to consult to your lawyer...

Dmitry
