From: Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 14:12:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801111409400.2497@ds9.cixit.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>  <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>  <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org>  <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>  <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0801091041570.31053@racer.site> <Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se>  <alpine.LSU.1.00.0801101155140.31053@racer.site>  <Pine.LNX.4.64.0801101424580.11922@ds9.cixit.se> <eaa105840801100631p6b95ed86j153d70244d474b03@mail.gmail.com>
Reply-To: peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Peter Harris <git-o5dc/4CFiiM09hOznCs0S0B+6BGkLq7r@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Jan 11 14:13:26 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.170])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDJhO-0000pc-7b
	for gcvm-msysgit@m.gmane.org; Fri, 11 Jan 2008 14:13:26 +0100
Received: by py-out-1314.google.com with SMTP id b29so1847806pyh.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jan 2008 05:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authentication-warning:date:from:to:cc:subject:in-reply-to:message-id:references:accept:x-warning:x-rating:organization:mime-version:content-type:x-greylist:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ZmxcqLfU6OFIPjIUMv6yZiywxIh+opQ2thNu/1MN2yY=;
        b=YnVP47ZGugXDmGPX3JjfGtoQMNMQ/GhBbP3mtK51YhwhSrH7hBVyavpnh4WrNlza+cGbuaGgzXlRYgqh3c9vfc8JqRXqbvsbPWORLbIAxoyubfAFn3KqlRvF48dYQdz0Fp63mZ3N2KyVG3G6kO6u6RdLxCAfs6csZtDBa9m2te4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authentication-warning:date:from:to:cc:subject:in-reply-to:message-id:references:accept:x-warning:x-rating:organization:mime-version:content-type:x-greylist:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=i5pGChD25wHu3Yp7hl+6RyNtFXhb442+ZgrxR5+Ehxb4x0jA9y6sxe4YlWT3OQLIK4jyS/qg8jbArvq11W1b7GdTqz0eaOnUKX1zG145hfywwlEk7aKmL35+5Qf4tEHrDPFo85Bq0DMVricVtoq33vyN3zPiOf4ySNHmJ8XKENc=
Received: by 10.151.8.8 with SMTP id l8mr116691ybi.1.1200057178770;
        Fri, 11 Jan 2008 05:12:58 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1369hsm;
	Fri, 11 Jan 2008 05:12:58 -0800 (PST)
X-Sender: peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.109.1 with SMTP id h1mr426141wac.9.1200057178470; Fri, 11 Jan 2008 05:12:58 -0800 (PST)
Received: from ds9.cixit.se (ds9.cixit.se [193.15.169.228]) by mx.google.com with ESMTP id 20si934779nzu.0.2008.01.11.05.12.57; Fri, 11 Jan 2008 05:12:58 -0800 (PST)
Received-SPF: pass (google.com: domain of peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org designates 193.15.169.228 as permitted sender) client-ip=193.15.169.228;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org designates 193.15.169.228 as permitted sender) smtp.mail=peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org
Received: from ds9.cixit.se (peter@localhost [127.0.0.1]) by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0BDCPZZ004974 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 11 Jan 2008 14:12:25 +0100
Received: from localhost (peter@localhost) by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0BDCJRI004966; Fri, 11 Jan 2008 14:12:19 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <eaa105840801100631p6b95ed86j153d70244d474b03-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 11 Jan 2008 14:12:25 +0100 (CET)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70157>


Peter Harris:

> > I meant to say that any software that claims to be Windows software
> > should handle, and produce, CRLF line breaks in text files.

> Including zip/unzip?

Yup (zip -l, unzip -a).

> How about tar? rsync? 

Sure.

> NFS and SMB copies from network shares?

I'd say that might not be as obvious, but it would be nice to have,
yes. A typed network file system that stores text as character streams
and binary data as octet streams.

-- 
\\// Peter - http://www.softwolves.pp.se/
