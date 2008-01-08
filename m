From: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 12:29:57 -0500
Message-ID: <20080108172957.GG22155@fieldses.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
Reply-To: bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 18:30:41 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.164])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCIHf-0003sQ-CA
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 18:30:40 +0100
Received: by ug-out-1516.google.com with SMTP id 1so1082857uga.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=RkOuarIVp0QJrJR8Vab+Fr9qKVD263Xs/PuTXkEk5Aw=;
        b=ug0VKvxd7oovuBhs2cITA41hUdF6uPZUL39a1vOl8hKelmtipU8kzTx9owYyhrYoqEO73o4bmNYL/E08m3SliUMLN9MXQ/lOKKbmUEZnF/e/eeMufOJT7xRRUN+FQRKRPp2yUfZu89q5teoc5XZ2YaHO/DDC27Ie01HRp0uaITg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=tGZBbiPyut4TNuSKHoeUOOQHdHN4UIeR9zKO3kSinx/qAFF1/wuKBfSWqifflOm2CxVTV1LHg6kEDThtHv70YO/e27bMaQpPiOktNkO+GRWoPe2NF3Mpdb1f3i5prCg2cXhJFINxbV8NTJFUdQJTWmDl8a8Ay5EJSY+u8X1XZqg=
Received: by 10.82.169.4 with SMTP id r4mr41973bue.7.1199813412834;
        Tue, 08 Jan 2008 09:30:12 -0800 (PST)
Received: by 10.44.69.72 with SMTP id r72gr1320hsa;
	Tue, 08 Jan 2008 09:30:12 -0800 (PST)
X-Sender: bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.64.21.6 with SMTP id 6mr47838478qbu.6.1199813412048; Tue, 08 Jan 2008 09:30:12 -0800 (PST)
Received: from fieldses.org (mail.fieldses.org [66.93.2.214]) by mx.google.com with ESMTP id h49si29001890nzf.5.2008.01.08.09.30.11; Tue, 08 Jan 2008 09:30:12 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org designates 66.93.2.214 as permitted sender) client-ip=66.93.2.214;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org designates 66.93.2.214 as permitted sender) smtp.mail=bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org
Received: from bfields by fieldses.org with local (Exim 4.68) (envelope-from <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>) id 1JCIGz-0000Rr-NL; Tue, 08 Jan 2008 12:29:57 -0500
Content-Disposition: inline
In-Reply-To: <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134-wjoc1KHpMeg@public.gmane.org>
User-Agent: Mutt/1.5.17 (2007-12-11)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69895>


On Mon, Jan 07, 2008 at 10:40:56PM +0100, Steffen Prohaska wrote:
> Eventually I gave in and even voted for "Git does not modify
> content unless explicitly requested otherwise".
> 
> Here's the full discussion:
> 
> http://code.google.com/p/msysgit/issues/detail?id=21
> 
> I believe the main question is which type of projects we would like
> to support by our default.  For real cross-platform projects that will
> be checked out on Windows and Unix we should choose
> "core.autocrlf true" as our default.  But if our default are native
> Windows projects that will never be checked out on Unix, then we
> should not set core.autocrlf by default.

If the policy really depends on the project, then surely the default
behavior should be determined by information carried in the project
itself (e.g., the .gitattributes)?

For that reason it strikes me as a mistake to ignore the crlf attribute
by default (assuming that is indeed the current behavior; apologies for
not checking).  If crlf is set then I think it should be assumed that
crlf conversion should be done unless that has been explicitly turned
off somehow.

--b.
