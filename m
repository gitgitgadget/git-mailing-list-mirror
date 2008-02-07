From: Jeremy Maitin-Shepard <jbms-D+Gtc/HYRWM@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 07 Feb 2008 16:02:26 -0500
Message-ID: <87y79wa3a5.fsf@jbms.ath.cx>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <20080207185923.GC28753@bit.office.eurotux.com> <alpine.LSU.1.00.0802071906120.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>,  Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>,  Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,  msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 22:03:34 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNDu1-0004Lo-3q
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 22:03:25 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6719549wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 13:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:from:to:cc:subject:references:x-habeas-swe-9:x-habeas-swe-8:x-habeas-swe-7:x-habeas-swe-6:x-habeas-swe-5:x-habeas-swe-4:x-habeas-swe-3:x-habeas-swe-2:x-habeas-swe-1:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Eg8Zuce8kxMufG64pkyKud3d9EH1mO/KUETZgqKqPqs=;
        b=WuwJdilExFt01SMV5FGRVYXtIAGj8NfD/ps3R8lGEMAqs1vNrabIeMOvWMqTrwDn5Vh2vktelmuUUOACP77kz2IDpoqiEqnLQ3HO7SEpOtEmfXm5LUq8RBrISfACa0XsXN+Wsh7KcISgAPlg+iBm1hFxHmESTa4RUPIDqs9E5E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:x-habeas-swe-9:x-habeas-swe-8:x-habeas-swe-7:x-habeas-swe-6:x-habeas-swe-5:x-habeas-swe-4:x-habeas-swe-3:x-habeas-swe-2:x-habeas-swe-1:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=Sp8nzr4eEVRn6gle/DYcpTGgA0CArrYC+pu7UXA1BFl4NjleQbWNZ6644/f+BpMHEZCeQz5w1SfWYE3VaegcZlAdoW1VscES8/m9YIuD5h0KZiafim2ZHwQaZK3zBH62PwQQvSaoXMf2eb9Wqom90xGM87EfWFWuaJQ35e/4oO8=
Received: by 10.115.109.1 with SMTP id l1mr826032wam.28.1202418173404;
        Thu, 07 Feb 2008 13:02:53 -0800 (PST)
Received: by 10.106.159.22 with SMTP id h22gr1670pre;
	Thu, 07 Feb 2008 13:02:53 -0800 (PST)
X-Sender: jbms-D+Gtc/HYRWM@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr25774607pym.3.1202418173173; Thu, 07 Feb 2008 13:02:53 -0800 (PST)
Received: from deleuze.hcoop.net (deleuze.hcoop.net [69.90.123.67]) by mx.google.com with ESMTP id z53si7484293pyg.1.2008.02.07.13.02.51; Thu, 07 Feb 2008 13:02:53 -0800 (PST)
Received-SPF: neutral (google.com: 69.90.123.67 is neither permitted nor denied by best guess record for domain of jbms-D+Gtc/HYRWM@public.gmane.org) client-ip=69.90.123.67;
Authentication-Results: mx.google.com; spf=neutral (google.com: 69.90.123.67 is neither permitted nor denied by best guess record for domain of jbms-D+Gtc/HYRWM@public.gmane.org) smtp.mail=jbms-D+Gtc/HYRWM@public.gmane.org
Received: from jbms.wv.cc.cmu.edu ([128.237.255.60] helo=localhost) by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.63) (envelope-from <jbms-D+Gtc/HYRWM@public.gmane.org>) id 1JNDt6-0000FJ-0Y; Thu, 07 Feb 2008 16:02:28 -0500
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <alpine.LSU.1.00.0802071906120.8543-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org> (Johannes Schindelin's message of "Thu, 7 Feb 2008 19:08:26 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73001>


Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org> writes:

> Hi,
> On Thu, 7 Feb 2008, Luciano Rocha wrote:

>> I was asking for the reasons for the installer being like it is, not for 
>> you to change your mind.

> I am sorry: I misunderstood.

> Two reasons: we stay on the safe side (because no lawyer could now 
> possible say that we forgot to present the license), and we want to give 
> the Git installer some "professional" look-and-feel ;-)

It is not unreasonable, I suppose, to display the license text in the
installer program, though I think it is sufficient to provide the
license in a simple LICENSE file, and it is hard to imagine anyone
actually wanting to read the license text while installing git.

I think it is not a good idea for a nice free software program like git
to show license text in a click-wrap way, as that will only give
credence to click-wrap licenses.

As far as the "professional" look and feel, rather than make git seem
more like the usual proprietary program (if you wanted to go that route,
perhaps you should bundle a root kit/"copy protection
mechanism"/adware/spyware like companies will often do :) ), I'd suggest
making it seem much _better_ than the usual proprietary program: the
user can look at the opportunity to install a program without having to
"agree" to onerous terms as a breath of fresh air.

As has been mentioned, installing and running the program is permitted
by fair use, and thus assuming he already has a copy of the software,
legally there is no need for the user to agree to any additional terms
before using the software.  The traditional EULA attempts to use
technical means to prevent the user from exercising his fair use rights;
in particular, it attempts to force the user to agree to certain terms
for essentially no compensation, as he already has fair use permission
to use the software anyway.  Naturally, such use of technical means is
completely antithetical to the idea of free software.

-- 
Jeremy Maitin-Shepard
