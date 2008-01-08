From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 21:20:24 +0100
Message-ID: <E258DB7F-21BD-4432-88BD-43E52B4A226E@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <7vbq7wrsb6.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 21:20:50 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKwK-0004UC-8U
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 21:20:48 +0100
Received: by ug-out-1516.google.com with SMTP id 1so1344273uga.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=UhlNTVWJk12oQl3h5NlcrUHrEDFeinRHPbNO9twugo4=;
        b=jxIumRb4Df5nIfTDUT1a6X3YJ7+NZ+clsdXSbA2DeAXuCWE6qh3N/8XRK9zr/WpeYkFQ7qm0YbC2rY3uovRMVgoCyWpkFBJqQFYVjdXBgce5THBgGqkWuYLebpa/sfDUx7NfmIkxtesoIv1vO0+wYPoboov3ZTS7Okk2H3tzQys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=0duhEvPEPViqf6A5WRVuLneGJVixznPF6Gh/2blkiUdFsY3Y7pgaN8/WTJyfmTVsiZOjwaiaHFfUGKkTmRaSlnwjwRn0hCi7ylZFqlhzXbFRDowoYW8U2LnKVfpBtYqUcGeN8dcvDJmrznJjVWPc0Y9dLP0DPvQBiv0tS5ImPdM=
Received: by 10.82.160.19 with SMTP id i19mr44296bue.11.1199823621757;
        Tue, 08 Jan 2008 12:20:21 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1330hsa;
	Tue, 08 Jan 2008 12:20:21 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.37.18 with SMTP id p18mr51630713pyj.6.1199823621409; Tue, 08 Jan 2008 12:20:21 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h71si29197624nzf.3.2008.01.08.12.20.20; Tue, 08 Jan 2008 12:20:21 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m08KJJN9002772; Tue, 8 Jan 2008 21:20:19 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m08KJI2b011352 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Tue, 8 Jan 2008 21:19:18 +0100 (MET)
In-Reply-To: <7vbq7wrsb6.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69913>



On Jan 8, 2008, at 9:11 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska-wjoc1KHpMeg-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org> writes:
>
> 	By the way, is it your setting that mangles people's
> 	e-mail addresses?  If it is, is it possible for you to
> 	configure it to stop doing that?

No.  I have no idea where these mangled addresses come from.
I did never see such addresses before.

I thought I replaced all the mangled addresses in my last reply.

I this mail wrong, too?

	Steffen
