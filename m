From: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc4
Date: Tue, 22 Jan 2008 01:21:56 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801220121300.5731@racer.site>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <7vsl0r3nvc.fsf@gitster.siamese.dyndns.org> <BB330DC7-9F38-4D41-85A2-D475701B6083@zib.de>
Reply-To: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,  Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 22 02:22:30 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.185])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7qP-0005RA-KE
	for gcvm-msysgit@m.gmane.org; Tue, 22 Jan 2008 02:22:29 +0100
Received: by ag-out-0910.google.com with SMTP id 32so108166agc.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jan 2008 17:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=0r1AUjqf2qczxr62kb7v5/eeAqEILRt8wt1z7gGapds=;
        b=NUAKhthZiyhMic7Gzk/X3mJ+84w5xbmXdAX0eUCzK96CkAUCoCrg8OAu0FYUGZKMYUcZx9qjnMHE8fo8eZwOoI0r78A2FVqEhO0jOge24ny8HJs+2IWr0ymo1vgWY77F+yRIKWRgLhX7KeGwh/rfmvRKuddkffefE193TGNxNwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type:x-y-gmx-trusted:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=idfUW+DBd9kqKvTuySYAnxvtOsYdolmPHSoNtkDPUkXjLNUoEOLEedGMC5sXpCLPuu65I2Kv1bfiLjIy7MhZhNEMujCK9o5noRO2j4nybVn3b5D/h8BOujDQWrYxlg0EW1dqJfUBDv31fLfYUcGs1cXx6xWojKGwPNxvHafW9hE=
Received: by 10.100.138.4 with SMTP id l4mr453626and.2.1200964919722;
        Mon, 21 Jan 2008 17:21:59 -0800 (PST)
Received: by 10.44.219.52 with SMTP id r52gr1450hsg;
	Mon, 21 Jan 2008 17:21:59 -0800 (PST)
X-Sender: Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.14.4 with SMTP id r4mr13409900pyi.2.1200964919293; Mon, 21 Jan 2008 17:21:59 -0800 (PST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id a28si4922178pye.0.2008.01.21.17.21.58; Mon, 21 Jan 2008 17:21:59 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org
Received: (qmail invoked by alias); 22 Jan 2008 01:21:57 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40] by mail.gmx.net (mp057) with SMTP; 22 Jan 2008 02:21:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CBSUaWAJCLW7TE9JaALQCLdp7ZwSMEnYGNz0I2v ZemGPC7znDx8S4
X-X-Sender: gene099-OGWIkrnhIhzN0uC3ymp8PA@public.gmane.org
In-Reply-To: <BB330DC7-9F38-4D41-85A2-D475701B6083-wjoc1KHpMeg@public.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71393>


Hi,

On Mon, 21 Jan 2008, Steffen Prohaska wrote:

> I haven't pushed the branches because repo.or.cz seems to have problems.

Can you elaborate?  What kind of problems?

Ciao,
Dscho
