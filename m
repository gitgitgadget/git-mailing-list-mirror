From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 16:01:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801081601180.3148@woody.linux-foundation.org>
References: <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108205054.GN6951@dpotapov.dyndns.org> <alpine.LFD.1.00.0801081325010.3148@woody.linux-foundation.org> <20080108225138.GA23240@dpotapov.dyndns.org>
Reply-To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 01:04:01 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.185])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCOQJ-00029v-BJ
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 01:04:00 +0100
Received: by ag-out-0910.google.com with SMTP id 32so3762602agc.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 16:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=OrF6/Y0Uo4sSg/9mO+ej0WI7RfHtMXoYdF4GA+dGiJg=;
        b=ZKlqPtPFxOga9+RloSXkioIlckbIZp0kGTNY7/7UKt70YQUNZrN2Gp3aA7cTdygsLYbv+wFqtyQuSc4b3BhBNcLrS0xwC6zZt276jjZMOqaeBtYdS2/A0edFKu7Uy08voVxwWlewurxXYXvvzXjUSvEtGamw1Cr2nyCiCi4V4/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=LeQvjRp8cCYqQXdTtDSMRvGfkdoOTccVWNDgkBMNtw5LkVLMKxUtObh2OSSSymuuUK8beX2qvcchVagQkdqxqhFo/bd5aMzpIVgCDRXKwjPo82mRUV0eWnFoIUDLajOztdYe8esrnPcKhIzP1s32hrS5JEhY5ozog+03hmacVgM=
Received: by 10.100.189.10 with SMTP id m10mr689681anf.22.1199837006168;
        Tue, 08 Jan 2008 16:03:26 -0800 (PST)
Received: by 10.44.112.30 with SMTP id k30gr1340hsc;
	Tue, 08 Jan 2008 16:03:26 -0800 (PST)
X-Sender: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.66.2 with SMTP id o2mr391294waa.18.1199837004798; Tue, 08 Jan 2008 16:03:24 -0800 (PST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14]) by mx.google.com with ESMTP id k36si5520721waf.0.2008.01.08.16.03.24; Tue, 08 Jan 2008 16:03:24 -0800 (PST)
Received-SPF: pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) client-ip=207.189.120.14;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) smtp.mail=torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m09024tj008680 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 8 Jan 2008 16:02:05 -0800
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0901waJ006639; Tue, 8 Jan 2008 16:01:59 -0800
In-Reply-To: <20080108225138.GA23240-EQL4cN526mwi5CQI31g/s0B+6BGkLq7r@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.423 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_52
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69938>




On Wed, 9 Jan 2008, Dmitry Potapov wrote:
> 
> It seems the check for named LF should be:
> 		if (safecrlf && stats.lf == stats.crlf)

No. If there was a crlf, then we won't increment the lf count.

(Not that I tested it, but that's how it was supposed to work)

		Linus
