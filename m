From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 11:59:03 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802071157360.2896@woody.linux-foundation.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org>
Reply-To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 21:00:36 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.185])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNCv6-0003wD-1A
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 21:00:28 +0100
Received: by ag-out-0910.google.com with SMTP id 32so6199441agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 11:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=a90ymjIZ91CJ1xPfy/Oi8SKtHnq4m8dPiT7DQhV4MZk=;
        b=trj73BE0y8hjbXjNqIOqoozt1qzYLDHe43NnXr1156xcazSimQ/tkKeVlduLXaHGmqf3LDOyFNlmN9HWqQLx6E5qMPJ7juoFOXKSO7mEX+cCskLbNP+j2ZAMgm80UE/7NxinZvtT1XkyWIrHXXcoUyzU4cgwaYimfYNDugLlFbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=wi6a4JlfUDofr7NnBd495WOJscUfhSXtTXyLhxARaGCmsYw1lf0x7YwCJtWFucGlq4BFT8G2B4/kV2hXIZ0/oMvlQbifkuGSy3DVTndK2iGa0rTnw9Xc+2J7C6q/T7//ldGehfy/Ge+90DPNWUA8zSsSbUvKsGvIo4rJTCprw1A=
Received: by 10.142.154.20 with SMTP id b20mr1063wfe.21.1202414395371;
        Thu, 07 Feb 2008 11:59:55 -0800 (PST)
Received: by 10.107.168.22 with SMTP id v22gr1667pro;
	Thu, 07 Feb 2008 11:59:55 -0800 (PST)
X-Sender: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr5583523pyn.5.1202414395143; Thu, 07 Feb 2008 11:59:55 -0800 (PST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14]) by mx.google.com with ESMTP id a28si7332973pye.0.2008.02.07.11.59.54; Thu, 07 Feb 2008 11:59:55 -0800 (PST)
Received-SPF: pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) client-ip=207.189.120.14;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) smtp.mail=torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17Jx4KQ001945 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 7 Feb 2008 11:59:05 -0800
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17Jx3M3018973; Thu, 7 Feb 2008 11:59:03 -0800
In-Reply-To: <7vprv8mu2k.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.214 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72995>




On Thu, 7 Feb 2008, Junio C Hamano wrote:
> 
> I think removing the license dialog is a bad idea.  You need to
> tell the end-user about his rights, and one of the things is
> that he can get source to git under the terms of GPLv2.  The bug
> is not about showing the license, but is about refusing to
> install unless the end user agrees with it.

Yeah. Why not just rather than the whole ok/cancel discussion, go with a 
single button saying "good for me!" and be done with it.

IOW, the license thing should be considered *informational* rather than a 
choice. Because to a user, that's exactly what the GPL is. 

		Linus
