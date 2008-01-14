From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: safecrlf not in 1.5.4
Date: Mon, 14 Jan 2008 09:29:04 +0100
Message-ID: <E4FD5B11-F61A-4838-B9AD-1E6F6C2B0AD6@zib.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <31687420-EB17-4651-AD6C-07213311ABDA@zib.de> <
 7vejcklv84.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Mark Levedahl <mlevedahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 14 09:28:45 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.170])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEKgW-00063q-0Z
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jan 2008 09:28:44 +0100
Received: by py-out-1314.google.com with SMTP id b29so7488204pyh.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Jan 2008 00:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=6SUqRRrHI+d6XF6zqhBunPtnb/HwJ3J/K+Jvikuj7KQ=;
        b=WuHoMMvAloaDG+usrhsUrOEs8R0tkXL6VbrBi0e1h+MmKq+CNYdUTavzwEdt1Dk3AtPR2B0NtxFXn8g9t9ZyV2xC9tBZlS3W004VD3c+ojeiM3nU+4NzK1PciEOrAbZKpo/vRDC78igaYOOLQg6OWT1CcaVPVHKuwy7bCcxftBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=YlmloOz1EZbd0sL8r6fhLlwKLZQ0BVgX4qBxldMZOUWdjgKGf4OsY2QlPyf2AX6L7nK+luQaf4gUbDcAxYngCejSFuj9rED/T2DiKTp7XpSZLbGwN5dpJgaIlRxBkKOyGa5EiRbqlIebJFUY0pTEqEHQ8SMcBIcgB+cNaIrR6TQ=
Received: by 10.151.6.2 with SMTP id j2mr286091ybi.23.1200299285938;
        Mon, 14 Jan 2008 00:28:05 -0800 (PST)
Received: by 10.44.187.4 with SMTP id k4gr1379hsf;
	Mon, 14 Jan 2008 00:28:05 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.99.14 with SMTP id b14mr10103806pym.4.1200299285607; Mon, 14 Jan 2008 00:28:05 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id v28si2488787nzb.4.2008.01.14.00.28.04; Mon, 14 Jan 2008 00:28:05 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0E8S1rn009901; Mon, 14 Jan 2008 09:28:01 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0E8S0ZW026160 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Mon, 14 Jan 2008 09:28:00 +0100 (MET)
In-Reply-To: <7vejcklv84.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70448>



On Jan 14, 2008, at 8:30 AM, Junio C Hamano wrote:

>
> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:
>
>> Do you see a chance to have safecrlf in 1.5.4.1?
>
> By definition of 'maint', 1.5.4.X are to fix bugs in the
> features that are in 1.5.4, so the answer is no.

I expected this answer.


> But we could end up having a short cycle for 1.5.5 if we agree
> that the lack of crlf=safe is a severe bug that is worth fixing
> post 1.5.4.
>
> Currently I am not convinced that the lack of crlf=safe is a
> severe and urgent bug worth "fixing" for 1.5.4.  I see it as a
> new feature, a different variant of crlf behaviour we will be
> introducing for audience who are not satisfied with existing the
> crlf variants.


So I should try harder to find better arguments.  But this has
time until the 1.5.4 release is out.  For now, I am being quiet.

(Well, I'll continue to improve the safecrlf patch and most
likely will send it to the list, too.  But I don't expect to find
it anywhere in your repo before 1.5.4.)

	Steffen
