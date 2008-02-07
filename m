From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 21:58:12 +0100
Message-ID: <4C918ADB-6FF5-458E-AC81-5683850E1FE4@zib.de>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LSU.1.00.0802071324460.8543@racer.site> <7v1w7ooes3.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802071831520.8543@racer.site> <7vprv8mu2k.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802071157360.2896@woody.linux-foundation.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Sebastian Schuberth <sschuberth-b1n3U3u3AEZwaa3ho+uhNwC/G2K4zDHf@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 21:58:29 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.250])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNDpD-0002J1-1m
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 21:58:28 +0100
Received: by wr-out-0708.google.com with SMTP id 56so6654888wra.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 12:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=12FvMrqqmdzWuYh55AvX4fldQxYksgxqE/vV4YSgXSg=;
        b=0vphaHC7VyS0nGN0WNI29T/WLEy+iDOS4CYPQNttRjm/FPz/VwkBdaMsrBWFeK3pUsH5HxrVnRAPTmjNnBBP7CLs87jwrGDN5ZzOEZQSun4SWTTRkxtz6muMo1zVNHrQjHClTQT3mIBjRQ4xJW/DhGkEWss2khya0CAq+/XFTFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=NpfayMlw7KwSVe7yjYHEQjzhenmu3NfGzhgb2PPATOvumoD4dUWF4B8KcFDcvUIW/gPV0vLfqSvTtq7AXgPwpyTjpOucXRCVkIVm+o+mg/DmO9QmdUewI8Cg1nKugXJAHPdInaMt0zEoDgLEyqwY9qpr7V7S6BfHkRRhNmLokBM=
Received: by 10.100.207.5 with SMTP id e5mr3621ang.17.1202417850155;
        Thu, 07 Feb 2008 12:57:30 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1669prf;
	Thu, 07 Feb 2008 12:57:30 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.59.5 with SMTP id m5mr25743968pyk.0.1202417849823; Thu, 07 Feb 2008 12:57:29 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id a28si7451881pye.0.2008.02.07.12.57.28; Thu, 07 Feb 2008 12:57:29 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m17KvFhF012709; Thu, 7 Feb 2008 21:57:19 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m17KvE39015113 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Thu, 7 Feb 2008 21:57:14 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0802071157360.2896-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73000>



On Feb 7, 2008, at 8:59 PM, Linus Torvalds wrote:
>
> On Thu, 7 Feb 2008, Junio C Hamano wrote:
>>
>> I think removing the license dialog is a bad idea.  You need to
>> tell the end-user about his rights, and one of the things is
>> that he can get source to git under the terms of GPLv2.  The bug
>> is not about showing the license, but is about refusing to
>> install unless the end user agrees with it.
>
> Yeah. Why not just rather than the whole ok/cancel discussion, go  
> with a
> single button saying "good for me!" and be done with it.
>
> IOW, the license thing should be considered *informational* rather  
> than a
> choice. Because to a user, that's exactly what the GPL is.

Ok, if there are no further objections, we'll do that.

Sebastian,
can we easily modify the license dialog with Inno Setup?
The license should be displayed and a single click should
be sufficient to "continue".

	Steffen
