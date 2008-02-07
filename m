From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 14:48:26 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802071433461.2896@woody.linux-foundation.org>
References: <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org> <20080207202357.GO30368@dpotapov.dyndns.org> <57518fd10802071349w50446803q249cbda0e2998bc5@mail.gmail.com> <20080207221837.GQ30368@dpotapov.dyndns.org>
Reply-To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan del Strother <maillist-3GLpx8vVthx0ubjbjo6WXg@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 23:49:48 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNFYy-0004vT-6k
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 23:49:48 +0100
Received: by yw-out-2122.google.com with SMTP id 4so5212542ywc.37
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=XTnyzF5EazrsByU+ds2PyRcG1HY5PE8r0G3BhhkURKY=;
        b=ZAKVixzbqOirbKb42NLO0QcpZGxUVtbpwNnwURqDNa0lo9rPdFfUqsRDMYPIrNyvdDY5W3S9g2gcqwAaVtTnatTP/GdxYaVhv5pMXmhh2z/9RW9HYjfcwJbr0H23cvTy9XuhfyCO5R31RSRgG/0yxWLYTmV+GsBfwO9x5K1NGyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=uRoh29IljMrQe/+fpRsgEtlcpZ6yGU/qjwQiPKw40oKvmImqxjipBklwJQg1CQsn6wCaMutK+YMV5TRnd2NP4Mrf+gUVlnAupIpCfBl88eFKoZbkkE+2mmj2T694j9rhMQKT90EsQi7ryXI7f41lFcS9hCrn9GA4yxPqayi82Sc=
Received: by 10.150.96.10 with SMTP id t10mr515163ybb.10.1202424555985;
        Thu, 07 Feb 2008 14:49:15 -0800 (PST)
Received: by 10.106.78.1 with SMTP id a1gr1674prb;
	Thu, 07 Feb 2008 14:49:15 -0800 (PST)
X-Sender: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr25921166pyi.7.1202424555704; Thu, 07 Feb 2008 14:49:15 -0800 (PST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14]) by mx.google.com with ESMTP id z53si7690814pyg.1.2008.02.07.14.49.15; Thu, 07 Feb 2008 14:49:15 -0800 (PST)
Received-SPF: pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) client-ip=207.189.120.14;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) smtp.mail=torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17MmRjI009217 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 7 Feb 2008 14:48:28 -0800
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m17MmQ3o026837; Thu, 7 Feb 2008 14:48:26 -0800
In-Reply-To: <20080207221837.GQ30368-EQL4cN526mwi5CQI31g/s0B+6BGkLq7r@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.213 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73015>




On Fri, 8 Feb 2008, Dmitry Potapov wrote:
> 
> Unfortunately, I don't know much about OS X and the packet manager
> you mentioned, but from common sense, I would say you should place
> the copyright notice at the place where users traditionally can find
> it when install other programs on that platform...

Well, the rule in the license is "provided that you conspicuously and 
appropriately publish on each copy an appropriate copyright notice and 
disclaimer of warranty".

What exactly that means is not something people generally agree about. 
What some consider "conspicuous", others consider very much "rude and 
inappropriate", so "conspicuously and appropriately" is simply something 
that people have to find a balance for.

In general, your common sense interpretation is probably the best legal 
one too: place the copyright notice about as conspicuously as the user 
would be expect it to be placed.

On traditional UNIX platforms (including Linux), that tends to be "make it 
a README file or perhaps note it in the man-pages". On OS X and Windows, 
what is considered appropriate is probably different.

There is definitely no *requirement* of annoying pop-up click-throughs. In 
fact, I would say that something like that would be wholly in-appropriate 
and not at all in the spirit of the GPL on UNIX, where people expect 
installation to not be an interactive process.

[ Related side note: but at the same time, if a developer actually starts 
  adding those kinds of pop-ups, it's sometimes arguably against the GPL 
  to remove them!

  See 2(c), which says that you have to announce the license when an 
  interactive program is run *if* the announcement was there originally!

  So I actually would encourage people who do GPL'd programs to never add 
  those kinds of annoying interactive license notices, because they can be 
  hard to remove legally! ]

In short: it's a cultural issue which way you want to go, but some care 
should be taken. I come from a Unix background, so I find graphical 
installs be really really annoying, and if I see a popup, I just *hate* 
it. I'd consider it obnoxious and irritating as hell. But I suspect that 
Windows people really do expect it.

				Linus
