From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc4
Date: Tue, 22 Jan 2008 06:50:41 +0100
Message-ID: <E4060387-3AC5-474A-9D57-15885C29702B@zib.de>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <7vsl0r3nvc.fsf@gitster.siamese.dyndns.org> <BB330DC7-9F38-4D41-85A2-D475701B6083@zib.de> <alpine.LSU.1.00.0801220121300.5731@racer.site>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 22 06:51:24 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.174])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHC2c-0007vZ-Oa
	for gcvm-msysgit@m.gmane.org; Tue, 22 Jan 2008 06:51:23 +0100
Received: by py-out-1314.google.com with SMTP id p69so6245797pyb.5
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jan 2008 21:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Hq5NH5045X3IlHNqJaETFG18KiuZi6lAeDnAPq2E374=;
        b=dcDCUYeD6X2HgYzTQSHFzIouj4F4CODsrEGQp58B7Z/oPsG47fq5nXZ2QL0xmvcJT8+kM2j1IvyzIBioPjz13tMgejnuuv8DPVWF429f5Y/1DnlTp0CT8+dtDDIdWxl0LVeIO2x/RuzpO+dKrQJeYhpoWq2oyyqpOF5p2aRPOgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=YIRjGiXZ41FOAESC0DZry5ACDdakdMylf90URtnaBqa/+9g+lM+oNsiy/fyTX02YSWKoJ2h7lqSOjA1abrKMqilEzJsMl7MdvStV9rxh7Mu/48LZ9WFph7A/SaK14mLPCN2OQp4BsYLt7Us2bPjIot5yHPxUdSDLp7CZdoVptlc=
Received: by 10.100.253.12 with SMTP id a12mr220215ani.28.1200981045732;
        Mon, 21 Jan 2008 21:50:45 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1455hsm;
	Mon, 21 Jan 2008 21:50:45 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.99.14 with SMTP id b14mr13677124pym.4.1200981045138; Mon, 21 Jan 2008 21:50:45 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h49si3288314nzf.5.2008.01.21.21.50.44; Mon, 21 Jan 2008 21:50:45 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0M5nkEZ015137; Tue, 22 Jan 2008 06:50:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db94148.pool.einsundeins.de [77.185.65.72]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0M5neYg029653 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 22 Jan 2008 06:49:45 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801220121300.5731-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71420>



On Jan 22, 2008, at 2:21 AM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 21 Jan 2008, Steffen Prohaska wrote:
>
>> I haven't pushed the branches because repo.or.cz seems to have  
>> problems.
>
> Can you elaborate?  What kind of problems?

I got DNS lookup failures and could not connect.  Now it works
and I pushed.

	Steffen
