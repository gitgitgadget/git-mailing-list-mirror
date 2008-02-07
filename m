From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 09:30:20 -0800
Message-ID: <7v1w7ooes3.fsf@gitster.siamese.dyndns.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,  msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 18:31:06 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.191])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNAaW-0002bR-H9
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 18:31:05 +0100
Received: by ag-out-0910.google.com with SMTP id 32so6004890agc.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=AKT324+BoZYFD0Avr3wd4rp7hfyxdcaINp7Wk/pOAqc=;
        b=QlsqvRVXVgOXN3TZVAkJrtaj3jcwSulOIYHPHMrDpm4fON+VB18YhD0S1yi30G1B2G6Me0u1fMlJa/7XmpQ8IPz25PfeNm4kHaWz2juq/lTHGAyNImgoLkNDh2Ab5YZuTPARJF5SAK/0+yrhGh85PbE8BfRIOOT+y3k3jZ9uJ3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=HVe/HFU9qC5O1fpcXz/zzaKKXCkt3pthS8Q+L0QprNXrYMTMfhlg3rBjlw55IF+0oDGW3+jpBfWh/7b91i5XvB1hKn/ZPQVTzDNkqxr538Yl7wEI/wmmggNlkEDUoUtFT/lRSzreKMFQ5uhf5rYJZhXG49d+/6jTPgN8+8B6x3k=
Received: by 10.141.68.12 with SMTP id v12mr399933rvk.11.1202405430169;
        Thu, 07 Feb 2008 09:30:30 -0800 (PST)
Received: by 10.106.159.13 with SMTP id h13gr1656pre;
	Thu, 07 Feb 2008 09:30:30 -0800 (PST)
X-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.13.4 with SMTP id q4mr25383829pyi.7.1202405429947; Thu, 07 Feb 2008 09:30:29 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com [208.72.237.25]) by mx.google.com with ESMTP id v63si7064903pyh.2.2008.02.07.09.30.29; Thu, 07 Feb 2008 09:30:29 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) smtp.mail=gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
Received: from a-sasl-quonix (localhost [127.0.0.1]) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AB9F3EDF; Thu,  7 Feb 2008 12:30:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B280E3EDE; Thu,  7 Feb 2008 12:30:22 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802071324460.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org> (Johannes Schindelin's message of "Thu, 7 Feb 2008 13:28:06 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72980>


Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:

> Besides, if you do not like that our installer shows the GPL, just go and 
> make your own (but be sure to shell out money to your lawyer of choice to 
> confirm that the GPL allows you to do that).
>
> The Git installer of msysGit will always show the GPL, and have the user 
> accept it.

I may be missing the details because I do not do Windows myself,
but if you are discussing the "end user binary distribution"
one, then I think:

 * It is a mistake if you do not to show GPL, as you are
   redistributing GPL code in a binary form and you need to tell
   the end user his rights (e.g. he can request source for it,
   the source is found at a well known location, etc.)

 * The restriction on redistribution of modified program would
   probably not apply (unless the receiver hacks binary) to most
   casual users, so making the label say "I Accept" feels a bit
   silly (but still is technically correct).  As Nico suggested,
   "Continue" may be fine here, as long as the message already
   says "this program is distributed under this license you are
   looking at".

I recall you had another installer that gives the full
development environment for hack on "git" with a clone of the
git repository.  I do not know if you still offer that
installer, but "I Accept" would be very appropriate for that
one.
