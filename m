From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 22:03:35 +0100
Message-ID: <41A4384C-1D8D-4111-8C2C-90B6E8F6364C@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108190952.GK22155@fieldses.org> <7vir24rtfp.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org> <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801091041570.31053@racer.site> <7vmyrehhkd.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801092047190.
 31053@racer.site>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>, Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 22:04:13 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCi5t-0000vJ-0e
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 22:04:13 +0100
Received: by wa-out-0708.google.com with SMTP id n36so2341621wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=EBwS2SX8FZM5f9ZfzgaoFBCnEMBc7gka35oZWRPGMHc=;
        b=U/bIV1tY2arEu69C/uKvFlRu2Cvo/XO1B/bungkerCAGpFoj1cWxb/vBkxlJJWPVcX4A3OnRkwIjp3myWE5ZwwpL/qdEYbzdu1bNkibOhZL9+7U+V08ONzmDnh9RqDQMNpqei8Z4NJpdsCb4poUEFaOTcrX6c27oyS+B6Bv3IX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=i/Yjh189J7pGJOzr3z2E97MbK7TgarPHsQC3rU+JUl7sOatE4nj7KZZesN9nd3r+VHEbii6nDGyiOkrV/i6DXkNnzDwZrFApi6OcuxfGdFn4MyfTzc+R/Dy9egWC9jZj1eVH7yNgy/ykIL2hAh1n4ElN8b/rK9xM2IM6K1Gl4E4=
Received: by 10.115.110.6 with SMTP id n6mr846255wam.12.1199912624948;
        Wed, 09 Jan 2008 13:03:44 -0800 (PST)
Received: by 10.44.53.58 with SMTP id b58gr1351hsa;
	Wed, 09 Jan 2008 13:03:44 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.64.76.15 with SMTP id y15mr49792053qba.1.1199912624749; Wed, 09 Jan 2008 13:03:44 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id x35si29985784nzg.2.2008.01.09.13.03.43; Wed, 09 Jan 2008 13:03:44 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m09L2VeB022846; Wed, 9 Jan 2008 22:02:31 +0100 (CET)
Received: from [192.168.178.21] (brln-4db82c5e.pool.einsundeins.de [77.184.44.94]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m09L2U7p008904 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Wed, 9 Jan 2008 22:02:30 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801092047190.31053-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70015>



On Jan 9, 2008, at 9:50 PM, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 9 Jan 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:
>>
>>> Junio wrote:
>>>
>>>> Perhaps we can do something similar to core.filemode?  Create a  
>>>> file
>>>> that we would need to create anyway in "text" mode, and read it  
>>>> back
>>>> in "binary" mode to see what stdio did?
>>>
>>> The problem is that MinGW behaves sanely, i.e. it does not output  
>>> CRLF
>>> but only LF.
>>
>> Won't that behaviour be viewed rather as "insanely" from majority of
>> Windows users?
>
> I think the truth is that CRLF was a mistake.  Nobody wants to take  
> the
> blame for it, obviously, but more and more Windows tools just grok  
> LF-only
> text.
>
> The question is: what to do with those that cannot grok LF-only  
> text.  I
> imagine that the best compromise for now would be to have  
> crlf=true, with
> poor souls like Steffen having to set the gitattributes accordingly.

I could live with that but unfortunately this alone does not
solve all of the real-world problems happening during cross-
platform development.  At least the problem of code copied from
Windows to Unix and committed there should be addressed, too.
Maybe the default on Unix should be crlf=input?  I'm wondering
what Linux developer would say about this?

I am against changing the default of msysgit now.  First I'd like
to wait how the "crlf=safe" discussion evolves.

	Steffen
