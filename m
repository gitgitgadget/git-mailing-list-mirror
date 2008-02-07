From: Michael Poole <mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 09:04:46 -0500
Message-ID: <8763x07thd.fsf@graviton.dyn.troilus.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <86k5lguce2.fsf@lola.quinscape.zz>
Reply-To: mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,  msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: David Kastrup <dak-mXXj517/zsQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 15:07:20 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.166])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN7NR-0006Lx-H6
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 15:05:50 +0100
Received: by ug-out-1516.google.com with SMTP id 1so136354uga.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=pO8SJrEMiYbQ99SIk+RK2xq6bu9ZoCNSPazwK8orUcM=;
        b=5PzIliFqe4MikjdBTpL2LOLyKmFn9XwBWOJiwQXlJGuAeMWmjyQy46cztFOaGsfbs5C677O2uSHw7/TnnSMtYWhncowtZr29EfEE5x0oTTnp6Fg3HiPphoQ40tZbN4odsjajzph82RZ1Cuc1lvt0EEgQow1Z6kOweLI2gFVfLn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=eaKI5ygQ1wsa4Q/AdWao7ZJhmmmqdV7+l5WqZej2WGFrwoZ8g7rmV/EHdKAHEuAiSoNY+5vesxz2u+bv7eh++0BBWUfpecJ2nudnzhf2biHltvYJPHtr5QtHljSz2VyBr9LEATc29uGliP9xs0vv1p74u9266mKOOQESmXGHNs8=
Received: by 10.150.145.20 with SMTP id s20mr461020ybd.14.1202393089096;
        Thu, 07 Feb 2008 06:04:49 -0800 (PST)
Received: by 10.107.2.32 with SMTP id e32gr1642pri;
	Thu, 07 Feb 2008 06:04:48 -0800 (PST)
X-Sender: mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr25063691pyk.0.1202393088677; Thu, 07 Feb 2008 06:04:48 -0800 (PST)
Received: from sanosuke.troilus.org ([75.145.205.121]) by mx.google.com with ESMTP id v63si6613599pyh.2.2008.02.07.06.04.46; Thu, 07 Feb 2008 06:04:48 -0800 (PST)
Received-SPF: neutral (google.com: 75.145.205.121 is neither permitted nor denied by best guess record for domain of mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org) client-ip=75.145.205.121;
Authentication-Results: mx.google.com; spf=neutral (google.com: 75.145.205.121 is neither permitted nor denied by best guess record for domain of mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org) smtp.mail=mdpoole-IZmAEv5cUt1AfugRpC6u6w@public.gmane.org
Received: by sanosuke.troilus.org (Postfix, from userid 1000) id 15FD289C0F0; Thu,  7 Feb 2008 09:04:46 -0500 (EST)
In-Reply-To: <86k5lguce2.fsf-Gv3ZRPJT63HkqtzbHXq1RqVXKuFTiq87@public.gmane.org> (David Kastrup's message of "Thu\, 07 Feb 2008 14\:25\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72947>


David Kastrup writes:

> Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:
>
>> On Thu, 7 Feb 2008, Luciano Rocha wrote:
>>
>>> On Sat, Feb 02, 2008 at 11:42:11PM +0100, Steffen Prohaska wrote:
>>> > 
>>> >  On Feb 2, 2008, at 5:34 AM, Junio C Hamano wrote:
>>> > 
>>> > > The latest feature release GIT 1.5.4 is available at the usual
>>> > > places:
>>> > 
>>> >  The msysgit setup is available at:
>>> > 
>>> >    http://code.google.com/p/msysgit/downloads/
>>> > 
>>> 
>>> Why do I have to accept the GPL to install msysgit?
>>
>> Because that's the only license you have to use git.
>
> Uh no.  The right to use git is "fair use": if you have acquired a copy
> of a copyrighted work through a legal channel, you have prima facie a
> certain set of rights.  Conventional software "licenses" try to make you
> give up many of these rights which is why the recipient needs to agree
> to those licenses (which are actually contracts rather than licenses).

The concept of "fair use" of copyrighted works does not exist (per se)
in Europe, Japan, or a number of other countries.  The USA may be the
only place to have that doctrine.

British courts, for instance, have held that copying a program into
RAM for the purposes of executing it is a right reserved under
copyright law.  In the US, 17 USC 117(c) and (d) were added after a
court held (in MAI Sys. Corp. v. Peak Computer) that a computer repair
company violated copyright of software that automatically started on a
computer it was asked to repair -- by simply allowing the computer to
boot and execute that program automatically.

As the GPL itself notes, you are not required to accept it, but
nothing else grants you the right to perform actions reserved to
copyright holders with respect to the work.  Asking end users to
accept the GPL has good effect in countries besides the US, and has no
obvious harm in the US.

Michael Poole
