From: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: safecrlf not in 1.5.4
Date: Mon, 14 Jan 2008 12:04:56 +0300
Message-ID: <20080114090456.GZ2963@dpotapov.dyndns.org>
References: <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <31687420-EB17-4651-AD6C-07213311ABDA@zib.de> <7vejcklv84.fsf@gitster.siamese.dyndns.org>
Reply-To: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Mark Levedahl <mlevedahl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 14 10:06:09 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.247])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JELGG-0007tC-ED
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jan 2008 10:05:53 +0100
Received: by wr-out-0708.google.com with SMTP id 56so11247871wra.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Jan 2008 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:x-dcc-stream-metrics:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=oH0VsDx8Jc2FhbU/MsURfFBTjNOKafxtQw17TdpIZ+0=;
        b=D1HEC0gFZ3ki3cNtt/msMaXDjC3FJDILUReIHzi31cUmudC0sTFocojuEPu7WUlSG4/jfpAjvb0Pg6VKl60RX5LHAUaR8L+3/B7K/SmuK1XtP9rHr6zW51IWlvmAT+fq9VIQFNamGuyGQCHUE3ZSpL7OnAbjzkUMnOtxguie7Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:x-dcc-stream-metrics:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=mjqTcawSQJCT58rIuu2TX7UD9+50Kn7Nj312RmAQlPNz8lu9V9y7k/8PnRuUmg2OMR1I71ETYsCXKgAIFs6IhjAY/h8fXY/g+iMTsddZkMkOnh50Mw3Mh5OGeXdzZwr1BaAbBwRhuHAOwPlEnMXY9cmjvAbf98BOxcMYVRv21UI=
Received: by 10.100.125.12 with SMTP id x12mr391744anc.23.1200301501070;
        Mon, 14 Jan 2008 01:05:01 -0800 (PST)
Received: by 10.44.13.45 with SMTP id 45gr1380hsm;
	Mon, 14 Jan 2008 01:05:01 -0800 (PST)
X-Sender: dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.126.2 with SMTP id d2mr10162042pyn.1.1200301500656; Mon, 14 Jan 2008 01:05:00 -0800 (PST)
Received: from smtp03.mtu.ru (smtp03.mtu.ru [62.5.255.50]) by mx.google.com with ESMTP id h71si2493939nzf.3.2008.01.14.01.04.58; Mon, 14 Jan 2008 01:05:00 -0800 (PST)
Received-SPF: neutral (google.com: 62.5.255.50 is neither permitted nor denied by domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) client-ip=62.5.255.50;
Authentication-Results: mx.google.com; spf=neutral (google.com: 62.5.255.50 is neither permitted nor denied by domain of dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org) smtp.mail=dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1]) by smtp03.mtu.ru (Postfix) with ESMTP id 123381870D18; Mon, 14 Jan 2008 12:04:57 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-237-183.pppoe.mtu-net.ru [85.141.237.183]) by smtp03.mtu.ru (Postfix) with ESMTP id 780AD1870CE0; Mon, 14 Jan 2008 12:04:56 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63) (envelope-from <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) id 1JELFY-0006kA-9Q; Mon, 14 Jan 2008 12:04:56 +0300
Content-Disposition: inline
In-Reply-To: <7vejcklv84.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70449>


On Sun, Jan 13, 2008 at 11:30:51PM -0800, Junio C Hamano wrote:
> 
> But we could end up having a short cycle for 1.5.5 if we agree
> that the lack of crlf=safe is a severe bug that is worth fixing
> post 1.5.4.

Hopefully, the cycle for 1.5.5 will be a bit shorter than 1.5.4, because
1.5.4 seems to have the longest development cycle of all versions, and
it already contains almost as much changes as three previous versions
("git diff v1.5.3 master" is almost as big as "git diff v1.5.0 v1.5.3").

Dmitry
