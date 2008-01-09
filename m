From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 13:32:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091330340.31053@racer.site>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <B655B6FF-9377-434A-A979-2E758771B0FA@zib.de> <alpine.LSU.1.00.0801091100401.31053@racer.site> <019B1C82-27BF-4B6B-981D-5498D31B5DD3@zib.de>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 14:32:38 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCb2o-0001aw-UH
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 14:32:35 +0100
Received: by wa-out-0708.google.com with SMTP id n36so1988794wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=9Sd/JICc6hZOCT0LSs62RUUKiEhabMIWz/7Iemhz5Dg=;
        b=ezqmF4QrPV2KN5sAtzx41lkX/i0LKrUXZryzjvtNtLeXfd+MwBmZYKGiNcrVHyUtWCF5AuN1xyi/IzTBKpmbLKdlaqNvsmhNCFvNPBUymLjNVusG97A68xJfb3xEWplvoe3RQxzxhldKrmPz4YepBWVWovy5uQl/mVBApRh2Mmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=B3w9YgiuBiXktiMn2pYXjyhF4yy7VL+HDQkXRnhqzzSDwogJelskIi+G4CE6J3ej1+U5bzQ+rc4iKrvIsZuIdp+Q6Gg4JblHAnqK1AV9552F+k+TDdZdftINgpCfS0B0oMtOVEUuly+UgrlF2GHcN2q604nDEkP2bEPbCzInB10=
Received: by 10.140.250.14 with SMTP id x14mr793431rvh.28.1199885527823;
        Wed, 09 Jan 2008 05:32:07 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1347hsa;
	Wed, 09 Jan 2008 05:32:07 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.14.4 with SMTP id r4mr53154378pyi.2.1199885527481; Wed, 09 Jan 2008 05:32:07 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si476310pye.0.2008.01.09.05.32.06; Wed, 09 Jan 2008 05:32:07 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 09 Jan 2008 13:32:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74] by mail.gmx.net (mp018) with SMTP; 09 Jan 2008 14:32:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/U4o9XLSPUwkqnlEoImONOc6u6ZqlUA4zR6j0z1H gJ1GcVWy6/Chc+
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <019B1C82-27BF-4B6B-981D-5498D31B5DD3-wjoc1KHpMeg@public.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69989>


Hi,

On Wed, 9 Jan 2008, Steffen Prohaska wrote:

> On Jan 9, 2008, at 12:03 PM, Johannes Schindelin wrote:
> 
> > -- snip --
> > *.am -crlf
> > -- snap --
> > 
> > (Did I guess right about the file extension? But why do you want to 
> > check in huge 3D stacks? Ah, of course, for test cases.)
> 
> Yes, thanks ;)
> 
> For now, this is the right thing to do.  However, our file format and 
> the application does not depend on the extension.  A a long term 
> solution, I'll fix our file format header to include '\0' if the file is 
> binary.

Of course, that would help the binary detection of both subversion and 
git, but it would break 3rd party readers of the format :-(

Thanks for the heads-up,
Dscho
