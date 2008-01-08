From: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 01:51:38 +0300
Message-ID: <20080108225138.GA23240@dpotapov.dyndns.org>
References: <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108205054.GN6951@dpotapov.dyndns.org> <alpine.LFD.1.00.0801081325010.3148@woody.linux-foundation.org>
Reply-To: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 23:55:33 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCNM4-00055M-He
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 23:55:32 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1649897wag.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:x-dcc-stream-metrics:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=1VCaHH5hpenx2noXUyT2n702kSvHxOk1lRay8k00Ru8=;
        b=OBeIbKtMppX6NFnyoPBqhYSZ7BRQtjsInTiiQGzLX16l6UKcDkB/mmRop7cxJaUWWsN52uTbxf7LTx1toDZ3P2gByDjTOdLFKCFkMbeyZpiXd6WDOY6uI/KxXooTaT9vpGu5yuQ/6LIloDU5HcZ0PCVmf/+1xwQYFybdBij7XPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:x-dcc-stream-metrics:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=dqaS7VuqoORD1uNf6Lo9I6vMsedLyWh1kMCdJTEij2SHpgA42S4FkS1GijHHmgsCeqFpv08G5T+pzgIDraXpYB5ffCfQX0YklLxq3OKMlxWrHiL+s8coczd+lTCokA794J4/IzjxQsB+i02r9ncA5zy3CUInqzSrPYKe9AvMjNU=
Received: by 10.114.78.1 with SMTP id a1mr821856wab.6.1199832905071;
        Tue, 08 Jan 2008 14:55:05 -0800 (PST)
Received: by 10.44.69.72 with SMTP id r72gr1339hsa;
	Tue, 08 Jan 2008 14:55:04 -0800 (PST)
X-Sender: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.237.15 with SMTP id o15mr48484933qbr.3.1199832904336; Tue, 08 Jan 2008 14:55:04 -0800 (PST)
Received: from smtp01.mtu.ru (smtp01.mtu.ru [62.5.255.48]) by mx.google.com with ESMTP id 20si29278072nzu.0.2008.01.08.14.55.03; Tue, 08 Jan 2008 14:55:04 -0800 (PST)
Received-SPF: neutral (google.com: 62.5.255.48 is neither permitted nor denied by domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) client-ip=62.5.255.48;
Authentication-Results: mx.google.com; spf=neutral (google.com: 62.5.255.48 is neither permitted nor denied by domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) smtp.mail=dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Received: from smtp01.mtu.ru (localhost [127.0.0.1]) by smtp01.mtu.ru (Postfix) with ESMTP id 097CEAE9ECA; Wed,  9 Jan 2008 01:53:03 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-189-183.pppoe.mtu-net.ru [85.141.189.183]) by smtp01.mtu.ru (Postfix) with ESMTP id 96CBDAE9002; Wed,  9 Jan 2008 01:51:31 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63) (envelope-from <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) id 1JCNII-00069A-4t; Wed, 09 Jan 2008 01:51:38 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801081325010.3148-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp01.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69933>


On Tue, Jan 08, 2008 at 01:31:57PM -0800, Linus Torvalds wrote:
> 
> but we don't check that there are no "naked" LF characters.

But my idea was about checking for "naked" LF, because if there is at
least one naked LF, then you will get a _different_ file than you
put into the repository.

> 
> So the only thing you'd need to add is to add a
> 
> 		/* No naked LF's! */
> 		if (safecrlf && stats.lf)

It seems the check for named LF should be:
		if (safecrlf && stats.lf == stats.crlf)

> 			return 0;

Unfortunately, you cannot return 0 here, because if there is
no CRLF, the opposite conversation cannot tell apart when all
CRLF were successfully converted to LF, and when there was no
conversation at all. So, the only thing to do here is to die()
saying this file should be either marked as binary or EOL in
the text must be corrected.

> 
> to that sequence too, but the thing is, having mixed line-endings isn't 
> actually all that unusual, so I think that kind of "autocrlf=safe" thing 
> is actually almost useless - because when that thing triggers, you almost 
> always *do* want to convert it to be just one way.

I agree that in most cases, you *do* want to covert, but the idea of the
"safe" mode is to protect you from the possibility (whatever small it
is) when you do not want to convert, because it is a _binary_ file, but
is_binary heuristic was wrong.

> I've seen it multiple times when people cooperate with windows files with 
> unix tools, where unix editors often preserve old CRLF's, but write new 
> lines with just LF.
> 
> So "autocrlf=safe" would be trivial to add, but I suspect it would cause 
> more confusion than it would fix.

The idea of "autocrlf=safe" is always to be on the safe side. Those who
prefer automatic correction of EOL can use "autocrlf=true". Besides,
checking EOL is somewhat similar checking whitespaces. Git allows you
either have --whitespace=error or --whitespace=strip, so it is reasonable
to have the same choice about EOL. I may choose either the "safe" mode,
which will only error out, or I can have the "true" mode, which corrects
EOLs on-fly.

Dmitry
