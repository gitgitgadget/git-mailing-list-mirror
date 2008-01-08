From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 13:31:57 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801081325010.3148@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108205054.GN6951@dpotapov.dyndns.org>
Reply-To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 22:45:54 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.169])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCMGY-00043P-80
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 22:45:49 +0100
Received: by py-out-1314.google.com with SMTP id p69so2375770pyb.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 13:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=O8x5jJCVL3SnQ87VWOOWZaYGKRiad9E2i6UHnhG7U7Y=;
        b=Th673tz1un7RkJAm6sDi42LxKFxwi1CW5TWt8dCMHWXJDMgZCCTloy3P/knvC6htKFulhJt1+ruCkqfK/hWxSxAY/FNfBj1RxGo05NR1qPv6qq4eUpI+NkwkEegr/989T17wII1UhpJ2rnoVhY1MfL6/Cz6lCSc3oRW16wzsHZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-spam-status:x-spam-checker-version:x-mimedefang-filter:x-scanned-by:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=MfQmqXCM7uI/pRAUZt1sGArRvD53v2Jah9clkUcrNC57X4j82gX6rueG9L1W/CXgRtqUIiJcYJ2htDLH3/WnbabNht6SvaBrhhr2nKpavoBct7Hrawtv4rlhL/g7w6TszONLQaqkGzvo1yvHHpsvWlR8WY3O+npj0WUS9+U4yno=
Received: by 10.141.146.4 with SMTP id y4mr2449rvn.1.1199828661404;
        Tue, 08 Jan 2008 13:44:21 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1335hsm;
	Tue, 08 Jan 2008 13:44:21 -0800 (PST)
X-Sender: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.197.13 with SMTP id z13mr48312009qbp.0.1199828661041; Tue, 08 Jan 2008 13:44:21 -0800 (PST)
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org [207.189.120.14]) by mx.google.com with ESMTP id 20si29242548nzu.0.2008.01.08.13.44.19; Tue, 08 Jan 2008 13:44:21 -0800 (PST)
Received-SPF: pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) client-ip=207.189.120.14;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org designates 207.189.120.14 as permitted sender) smtp.mail=torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08LW5Pg031191 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 8 Jan 2008 13:32:06 -0800
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m08LVvZw032420; Tue, 8 Jan 2008 13:32:01 -0800
In-Reply-To: <20080108205054.GN6951-EQL4cN526mwi5CQI31g/s0B+6BGkLq7r@public.gmane.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69926>




On Tue, 8 Jan 2008, Dmitry Potapov wrote:
> 
> Perhaps, this option can be called core.autocrlf=safe

We already do half of that:

        if (action == CRLF_GUESS) {
                /*
                 * We're currently not going to even try to convert stuff
                 * that has bare CR characters. Does anybody do that crazy
                 * stuff?
                 */
                if (stats.cr != stats.crlf)
                        return 0;

but we don't check that there are no "naked" LF characters.

So the only thing you'd need to add is to add a

		/* No naked LF's! */
		if (safecrlf && stats.lf)
			return 0;

to that sequence too, but the thing is, having mixed line-endings isn't 
actually all that unusual, so I think that kind of "autocrlf=safe" thing 
is actually almost useless - because when that thing triggers, you almost 
always *do* want to convert it to be just one way.

I've seen it multiple times when people cooperate with windows files with 
unix tools, where unix editors often preserve old CRLF's, but write new 
lines with just LF.

So "autocrlf=safe" would be trivial to add, but I suspect it would cause 
more confusion than it would fix.

		Linus
