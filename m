From: Marius Storm-Olsen <mstormo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 09:55:02 +0100
Message-ID: <47833A66.9080007@gmail.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <7vzlvhxpda.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801071457040.3148@woody.linux-foundation.org>
Reply-To: mstormo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>, Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 09:55:32 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCAFA-0004Gd-HC
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 09:55:32 +0100
Received: by ug-out-1516.google.com with SMTP id 1so448764uga.9
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 00:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=ExQL25sQTtjgwvuuRicbhnF9dIrPRTjlgP5WeEnHtH4=;
        b=UJysKSGmznf//QgyzVe4wuYyNh8pghQYVtnQBS8+nVfeOwmc4Ph8CZ0KjcqyJP6O8InEwfRHJw/98oP899HNksccVcwreF3YD5VdX0CrR6n21nFFj1toMi+dXgbGRil0wCfFOVaDv/UlfHnoeMT3RzOvCHofOh4hwhfMig50LUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=4LoN/kd+urORGXT7zr2tRzXyiGbdLMM6QAXYei0KUhuJuvqH2K44pgMu7nRUN9tQQFN4uRlSDuzUjxWljhmvJuw7YgHp6HcSedNi6R6Ny8VuOJfwFiHGTtQWL2INOGlbDNAc9PIBAS+L4XQ/M5B/M2WNF/aHIeBe29nnoDLfMZU=
Received: by 10.86.9.8 with SMTP id 8mr250715fgi.23.1199782506355;
        Tue, 08 Jan 2008 00:55:06 -0800 (PST)
Received: by 10.44.219.52 with SMTP id r52gr1317hsg;
	Tue, 08 Jan 2008 00:55:06 -0800 (PST)
X-Sender: mstormo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.124.20 with SMTP id b20mr50102112pyn.5.1199782505887; Tue, 08 Jan 2008 00:55:05 -0800 (PST)
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.237]) by mx.google.com with ESMTP id v28si28650631nzb.4.2008.01.08.00.55.05; Tue, 08 Jan 2008 00:55:05 -0800 (PST)
Received-SPF: pass (google.com: domain of mstormo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 72.14.214.237 as permitted sender) client-ip=72.14.214.237;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of mstormo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 72.14.214.237 as permitted sender) smtp.mail=mstormo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by hu-out-0506.google.com with SMTP id 16so1238716hue.17 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Tue, 08 Jan 2008 00:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; bh=eMU5mBqDr3d5Z7H8nKtIak1Y+FoXrgWPfaRDFGIm948=; b=IXl4rBwVO3RqpymkLIDf59WYmcdfcwMcNFwycGmdNizMbaGqy8YylYFJRqfN0JeUZD1DocaM6dypG7SgxIm9OFSydkVBEJlkHIFGFLCMGZnU0lIbG7VBKLgbRhIVbIiEpyHne8nLmiPMY+qKuLV+gX0d7Uo1M+DZJLn3R7i1ypQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; b=BOnC/aNqDyMEHvT95OJgZ/mDTGf+XsgkqG6QNqPF5rFqWAMMMZNyrxfEKWOP6+CCK3huBa8Pi+B42bBxnwArEmKONk0DOmcWncv9UrjNRqELxbcx3xWWS4/EjqciUQnPxMyXlKtSwRpDD9wyucukI/1M/X/Js1dcMM+jlDx6jYA=
Received: by 10.66.249.16 with SMTP id w16mr800394ugh.32.1199782504247; Tue, 08 Jan 2008 00:55:04 -0800 (PST)
Received: from ?10.3.4.215? ( [62.70.27.100]) by mx.google.com with ESMTPS id m1sm1727985uge.85.2008.01.08.00.55.02 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 08 Jan 2008 00:55:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LFD.1.00.0801071457040.3148-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69850>


Linus Torvalds said the following on 07.01.2008 23:58:
> 
> 
> On Mon, 7 Jan 2008, Junio C Hamano wrote:
>> So wouldn't the categorization be more like this?
> 
> Well, one thng we could do is to add a new concept, namely
> 
> 	core.autocrlf = warn
> 
> and make *that* the default.
> 
> It would do the check, but not actually convert anything, just warn about 
> it.
> 
> Then, it's up to the user to set it explicitly to "true" or "false", 
> unless they just like seeing that warning a million times ;)
> 
> That might be acceptable to most people.

I actually would want the default to be
     core.autocrlf = windows

Meaning, it would be true on Windows platforms, and warn on all 
others. That way it would work as expected in 90% of the time, namely 
that files are added to the repo with unix line endings. We could then 
add the following warning when you try to add a CRLF file on 
non-Windows platforms:

   * CRLF line endings detected for text files: <foo>, <bar>, <baz>
   Consider adding the following to a .gitattributes file to
   maintain the CRLF line endings on all platforms:
     <foo> = -crlf
     <bar> = -crlf
     <baz> = -crlf

Maybe then can we lure non-Windows users to add these required 
.gitattributes files for files that need to be CRLF on all platforms; 
instead of shoving the whole burden of maintaining a proper 
cross-platform repo onto the Windows users alone.

/me braces for the "it's your fault for working on Windows in the 
first place!" flood ;-)

Of course, setting the core.autocrlf = true|false should not show the 
warning, for users who don't care about repo portability to Windows 
anyways.

--
.marius
