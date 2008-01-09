From: Abdelrazak Younes <younes.a-GANU6spQydw@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 09 Jan 2008 09:43:12 +0100
Message-ID: <fm21f2$18e$1@ger.gmane.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108205054.GN6951@dpotapov.dyndns.org> <alpine.LFD.1.00.0801081325010.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Jan 09 09:55:17 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCWiN-0004Tn-6J
	for gcvm-msysgit@m.gmane.org; Wed, 09 Jan 2008 09:55:12 +0100
Received: by wr-out-0708.google.com with SMTP id 56so1694790wra.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 09 Jan 2008 00:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=tfUS503YVcNheKmlgQXWOQhLwCYl2FJ51kjQovpEPmg=;
        b=6niNqXQqXQzvt0k7qWbPZsU3Oc343Ml2fTBo1GnnYha/7lh1U9GhlBaesdYdMuPjOqKYFZkpRiBNsvSOlOekKCJbdmrRpjFYcbE/1gU722/B6PSXO0OXyRvj8PV+sCUAmQ4BhIAz0jHmviLTR3kz84AG8xQSErFDFV+VjmAENgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-injected-via-gmane:to:from:subject:date:lines:message-id:references:mime-version:content-type:content-transfer-encoding:x-complaints-to:x-gmane-nntp-posting-host:user-agent:in-reply-to:cc:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=5oBdiaa5VaY8ahaECF/6hQawYvprqUisNlnWpmDNjR/q2V79SvLx7GDU3gPSHkzicn1oa8KJhDZDTQPEpnUpxT1tB0ZqIp9dNV0xE/ja45/cInMYlOEaulVoKzlDmNZyOSaFdLDxefqh4kRU4qedK45toBT/Gd/4XkuqdhWJE4Q=
Received: by 10.100.142.4 with SMTP id p4mr719363and.18.1199868204516;
        Wed, 09 Jan 2008 00:43:24 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1342hsm;
	Wed, 09 Jan 2008 00:43:24 -0800 (PST)
X-Sender: gcvm-msysgit@m.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.126.2 with SMTP id d2mr52679435pyn.1.1199868204255; Wed, 09 Jan 2008 00:43:24 -0800 (PST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2]) by mx.google.com with ESMTP id h49si29483261nzf.5.2008.01.09.00.43.23; Wed, 09 Jan 2008 00:43:24 -0800 (PST)
Received-SPF: pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) client-ip=80.91.229.2;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gcvm-msysgit@m.gmane.org designates 80.91.229.2 as permitted sender) smtp.mail=gcvm-msysgit@m.gmane.org
Received: from list by ciao.gmane.org with local (Exim 4.43) id 1JCWWu-0006Qn-Lv for msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; Wed, 09 Jan 2008 08:43:20 +0000
Received: from matrix-eth-s4p3c0.eurocontrol.fr ([192.93.23.254]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 09 Jan 2008 08:43:20 +0000
Received: from younes.a by matrix-eth-s4p3c0.eurocontrol.fr with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 09 Jan 2008 08:43:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet-dbVV3NMTNubNLxjTenLetw@public.gmane.org
X-Gmane-NNTP-Posting-Host: matrix-eth-s4p3c0.eurocontrol.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LFD.1.00.0801081325010.3148-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69969>


Linus Torvalds wrote:
> 
> 
> On Tue, 8 Jan 2008, Dmitry Potapov wrote:
>> Perhaps, this option can be called core.autocrlf=safe
> 
> We already do half of that:
> 
>         if (action == CRLF_GUESS) {
>                 /*
>                  * We're currently not going to even try to convert stuff
>                  * that has bare CR characters. Does anybody do that crazy
>                  * stuff?
>                  */
>                 if (stats.cr != stats.crlf)
>                         return 0;
> 
> but we don't check that there are no "naked" LF characters.
> 
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

Sorry for the irruption in this discussion but as a potential git user 
for cross-platform development I'd like to share my experience/opinion, 
hope you don't mind.

I am investigating the use of git for our cross-platform project which 
uses svn currently. In our project, we mark manually *all* source file 
(*.h and *.cpp) with 'eol-style=native'. This way, if some editor on 
Windows added some CRLF in such marked file, svn will refuse to commit 
this file until you clean it up. This means that all C/C++/python files 
uses LF eol exclusively on all platforms. I believe this is the only 
sane way to do cross-platform development.

Now, marking any new file manually is cumbersome and some developers 
often forget to do it. I would like to be able mark all files with a 
given extension (.c, .cpp, .h) with "LF only". This way, Windows only 
files (like visual studio projects) can stay with CRLF. It would be 
fantastic if git could do that.

> 
> I've seen it multiple times when people cooperate with windows files with 
> unix tools, where unix editors often preserve old CRLF's, but write new 
> lines with just LF.

Multiple versions of Visual studio do just this indeed.

Abdel.
