From: Sean <seanlkml-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 17:09:44 -0500
Message-ID: <BAYC1-PASMTP14154E8108546AB0F9457FAE480@CEZ.ICE>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108205054.GN6951@dpotapov.dyndns.org> <alpine.LFD.1.00.0801081325010.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 23:10:17 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.160])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCMeE-0005O3-9U
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 23:10:14 +0100
Received: by ug-out-1516.google.com with SMTP id 1so1451313uga.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:x-originating-ip:x-originating-email:message-id:received:received:date:from:to:cc:subject:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:x-originalarrivaltime:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=fLrDl2udgfJCNYdL+4corQIuHlUHVKG9h+XNtk4Ou44=;
        b=JBwq6SCJHST2fSozY9S4zFNv/XDM0hQ2ETMp2F+BZxYuVdMG77KmWk4GrW5NZ52uBQsYi0zbIIbWPlUB3lPX3C9/uaSnRmUgR/XRfbwcn4YbPPxRFdhT6RultHMArtALv9VFwf2njy+xcCS5FRQPgUJgZnV6uOAazJRbz+vNANc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-originating-ip:x-originating-email:message-id:date:from:to:cc:subject:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:x-originalarrivaltime:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=G/l8TZyeZdSXYc/OfxgnNwvL7ZOK2krMYRz26ZZ+gCFmm/ixGQygXnq0zPgZob9yhpYR3T+JepnACcPFyZwiGCYxhNtuh/A+2T2HL7PPujFJXp0oK/eHS5imzGHB586WdfhLH7z+GAWafx+u3wt8oLVTEG5M1mMHXq8GaJP0jwY=
Received: by 10.150.181.11 with SMTP id d11mr467533ybf.7.1199830187629;
        Tue, 08 Jan 2008 14:09:47 -0800 (PST)
Received: by 10.44.112.30 with SMTP id k30gr1337hsc;
	Tue, 08 Jan 2008 14:09:47 -0800 (PST)
X-Sender: seanlkml-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.13.1 with SMTP id 1mr3632946wam.7.1199830187367; Tue, 08 Jan 2008 14:09:47 -0800 (PST)
Received: from bay0-omc1-s10.bay0.hotmail.com (bay0-omc1-s10.bay0.hotmail.com [65.54.246.82]) by mx.google.com with ESMTP id k36si5269846waf.0.2008.01.08.14.09.47; Tue, 08 Jan 2008 14:09:47 -0800 (PST)
Received-SPF: pass (google.com: domain of seanlkml-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org designates 65.54.246.82 as permitted sender) client-ip=65.54.246.82;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of seanlkml-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org designates 65.54.246.82 as permitted sender) smtp.mail=seanlkml-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org
Received: from BAYC1-PASMTP14 ([65.54.191.187]) by bay0-omc1-s10.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959); Tue, 8 Jan 2008 14:09:47 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml-rieW9WUcm8FFJ04o6PK0Fg@public.gmane.org]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP14.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668); Tue, 8 Jan 2008 14:09:46 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with smtp (Exim 4.43) id 1JCMdd-0001lQ-Fm; Tue, 08 Jan 2008 17:09:37 -0500
In-Reply-To: <alpine.LFD.1.00.0801081325010.3148-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 08 Jan 2008 22:09:46.0593 (UTC) FILETIME=[2DDEED10:01C85243]
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69928>


On Tue, 8 Jan 2008 13:31:57 -0800 (PST)
Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> So the only thing you'd need to add is to add a
> 
> 		/* No naked LF's! */
> 		if (safecrlf && stats.lf)
> 			return 0;
> 
> to that sequence too, but the thing is, having mixed line-endings isn't 
> actually all that unusual, so I think that kind of "autocrlf=safe" thing 
> is actually almost useless - because when that thing triggers, you almost 
> always *do* want to convert it to be just one way.
> 
> I've seen it multiple times when people cooperate with windows files with 
> unix tools, where unix editors often preserve old CRLF's, but write new 
> lines with just LF.
> 
> So "autocrlf=safe" would be trivial to add, but I suspect it would cause 
> more confusion than it would fix.

But isn't the entire point of this exercise to ensure that you will never
be in the situation on Linux where you checkout files that have CRLF endings?
And conversely that on Windows you will never checkout files that have LF
endings?  If so, you don't have to worry about your tools creating mixed
ending files.

The only time the above rules should be broken, is when the user explicitly
states that their tools will do-the-right-thing without such help.

Sean
