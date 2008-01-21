From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc4
Date: Mon, 21 Jan 2008 23:22:22 +0100
Message-ID: <BB330DC7-9F38-4D41-85A2-D475701B6083@zib.de>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org> <7vsl0r3nvc.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Jan 21 23:22:10 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.187])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH51r-0004bN-RU
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jan 2008 23:22:09 +0100
Received: by ag-out-0910.google.com with SMTP id 32so2643766agc.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jan 2008 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=UKnQATcxbMjE8W3ss3H1CgRw6RSJl4ujBd+9PJ42F6Y=;
        b=GFHMZJBFx48+Kr1O/qXLOk7A/Dcg2se/wWS4CKGR/g5dDCzZ5SOc9KPan5dCGqwUjf5NemKGneUpHHvUvjKW3mVwwdMIhsVdzZTD5yc+IV4xsiYB0q9xhXUWa/bwQPecZHXAEHvd6X6hFSQ93pfWQZOKW12WyuJTAY4ZcW7wnuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=j7a/Ej9JOOK6jjRBuxYfRvt1VOywfTVt6swlXUbXHaPibmPtKWJGwOsLI4FSPC6Fll16tjBbNCHATbAxKJ6XrpC2GRC1TA360B2/9wlCm5J9bR1UbL2mlIbCSoFiw6rLvCL1bi/afQe8mzBfrfWzxYcgc3O4sfxJQ5LBAhm3tpI=
Received: by 10.151.6.2 with SMTP id j2mr237563ybi.22.1200954084165;
        Mon, 21 Jan 2008 14:21:24 -0800 (PST)
Received: by 10.106.73.1 with SMTP id v1gr1447pra;
	Mon, 21 Jan 2008 14:21:24 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.12.9 with SMTP id 9mr1634661wal.19.1200954083516; Mon, 21 Jan 2008 14:21:23 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id h49si3119785nzf.5.2008.01.21.14.21.22; Mon, 21 Jan 2008 14:21:23 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0LMLLHM003056; Mon, 21 Jan 2008 23:21:21 +0100 (CET)
Received: from [192.168.178.21] (brln-4db939bb.pool.einsundeins.de [77.185.57.187]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0LMLJfQ023319 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Mon, 21 Jan 2008 23:21:20 +0100 (MET)
In-Reply-To: <7vsl0r3nvc.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71358>



On Jan 21, 2008, at 3:37 AM, Junio C Hamano wrote:

> The fourth rc for the next feature release GIT 1.5.4 is available
> at the usual places:

The matching msysgit setup is available at

   http://code.google.com/p/msysgit/downloads/

Commands that are not yet supported on Windows are no longer
included in the setup.  If you find any commands that should
not be included, please report this to the msysgit list.

I haven't pushed the branches because repo.or.cz seems to have
problems.

	Steffen
