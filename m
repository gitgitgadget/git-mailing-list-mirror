From: Daniel Barkalow <barkalow-o/mKjEDNO/Bg9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC] Distributing Windows binary package compiled with
 non gpl code
Date: Thu, 27 Dec 2007 19:05:00 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0712271846380.13593@iabervon.org>
References: <e5bfff550712271032q25d135e7y47d68337e937d401@mail.gmail.com> <alpine.LNX.1.00.0712271647130.13593@iabervon.org> <fl1bcn$k2h$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Dec 28 01:05:49 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J82j9-00061e-VD
	for gcvm-msysgit@m.gmane.org; Fri, 28 Dec 2007 01:05:46 +0100
Received: by wa-out-0708.google.com with SMTP id n36so196344wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Dec 2007 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=wQGj4wpnT/t/mwNTG/g4t3uCrILhHvwBG8XCp7K9WW8=;
        b=pQtZ/d2w0ugm/oHqFBrGsQxepdKtHGnWYB2gZ3Zrma2n6oJ/zdpexXfdnOJqQ/QphvuMKnhjKajWEa1bhJrj+GPyfqHgLM/Celrsh7oenzEAcAbmZ2hgGMPtDDM32pQz8erBPFCIgv+6JVdHb5cZ8IMay0S7Ocz2GFapwP3Hn8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=RZ/X5x/mWrbG/MUynplkj3XIwelDL9Ti3gjyThEqAnwOrcGXwCiu+MQtg29E2I5WPpJKqetcNH5zQ7unI1btiPQvs6oG2Hj5bSCgThP1D2B0ofxGfcAAqnYQvMe9qEd/Mv3VJyJF8c3h6Fml+z+lOPg8HGXqbsjXbh7y4UqgIM4=
Received: by 10.142.213.9 with SMTP id l9mr279762wfg.16.1198800302462;
        Thu, 27 Dec 2007 16:05:02 -0800 (PST)
Received: by 10.106.179.39 with SMTP id b39gr1289prf;
	Thu, 27 Dec 2007 16:05:02 -0800 (PST)
X-Sender: barkalow-o/mKjEDNO/Bg9hUCZPvPmw@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.82.147.6 with SMTP id u6mr158832bud.22.1198800302239; Thu, 27 Dec 2007 16:05:02 -0800 (PST)
Received: from iabervon.org (iabervon.org [66.92.72.58]) by mx.google.com with ESMTP id v28si10152748nzb.4.2007.12.27.16.05.01; Thu, 27 Dec 2007 16:05:02 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of barkalow-o/mKjEDNO/Bg9hUCZPvPmw@public.gmane.org designates 66.92.72.58 as permitted sender) client-ip=66.92.72.58;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of barkalow-o/mKjEDNO/Bg9hUCZPvPmw@public.gmane.org designates 66.92.72.58 as permitted sender) smtp.mail=barkalow-o/mKjEDNO/Bg9hUCZPvPmw@public.gmane.org
Received: (qmail 22493 invoked by uid 1000); 28 Dec 2007 00:05:00 -0000
Received: from localhost (sendmail-bs-savSHZN5Fh8qMp+WYRx65w@public.gmane.org) by localhost with SMTP; 28 Dec 2007 00:05:00 -0000
In-Reply-To: <fl1bcn$k2h$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69274>


On Fri, 28 Dec 2007, Abdelrazak Younes wrote:

> Daniel Barkalow wrote:
> > On Thu, 27 Dec 2007, Marco Costalba wrote:
> > 
> > > Packaged together with qgit.exe there are the necessary Micorsoft
> > > Visual C dll's. Is this a problem for someone?
> 
> My two cents below; I hope you don't mind my interference.

Not at all.

> > I'd actually be more concerned about whether you can (or should) distribute
> > GPL code compiled with a proprietary compiler;
> 
> This is the exact same situation as with other proprietary platforms (Solaris,
> HPUx, etc). You should not make a difference for Windows IMHO. Besides, many
> open source projects have no problem at all with MSVC.

The difference I see is that the project's build system can use the system 
toolchain without caring whether it's a proprietary one or an open source 
one. That is, you can call $CC or $LD based on the interface standard, and 
it doesn't fundamentally matter whether you've got a proprietary compiler 
or not (of course, you'll get a different result, but that's true of 
different compiler versions anyway, and build timestamps and machine and 
user name will be different, etc). MSVC's build system interface is 
particular to itself.

> > people who get the binaries and the source still couldn't edit the source
> > and generate a corresponding binary, because they don't necessarily have the
> > build environment you used.
> 
> This particular tool is free (as in beer) to download and use.

It probably actually falls under the "system software" exception, in that 
case (when distributing source, you have to include everything needed to 
build the source, except for normal system software, which you can assume 
the recipient has).

In any case, not an actual problem; it's just that distributing 
side-by-side (the original question) is even more clearly not a problem, 
in my opinion.

	-Daniel
*This .sig left intentionally blank*
