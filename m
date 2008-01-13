From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sun, 13 Jan 2008 15:41:13 +0100
Message-ID: <E02B6B93-FD6F-470B-B7E4-43A5BD8F9B54@zib.de>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Jan 13 15:40:57 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ag-out-0910.google.com ([72.14.246.186])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE419-0003Vt-SV
	for gcvm-msysgit@m.gmane.org; Sun, 13 Jan 2008 15:40:56 +0100
Received: by ag-out-0910.google.com with SMTP id 32so1907829agc.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 13 Jan 2008 06:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=kLXA3P2+muHGy5FIWVSm5ifaUdG5A1JpVX180WuIgQk=;
        b=FtGQTmOH4ZGuGHsNnIClmeFRKNi+QK9kcFtEf547rlMJNtd6BazQIs/0GDeYXcAP6g0fDsm/f6FdNHk+qluzczZwSTU9DRCJqwsJyrikVws5O1jMuBp7YhmSHSbjUvmKyhyroGtBKTErIpaw+xRV3lAHUjwB2363GuoXlr3tyV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=zuJFREAEPKayCIKbnx48/j3dA95IdbYCflCa6sIMOdg6o2KDudrxwhX+ftGDXTHWQ35UDbnUDAZuw/aN7ZR4GoF/Jw5KAjEFww9PSkzzend65+EkSOuk6VlnYOsfq8VP+gfNaLMK61Pdt0zzBm0jxqupQvE6wUNBEphTf/pIVQQ=
Received: by 10.151.8.8 with SMTP id l8mr241685ybi.2.1200235221928;
        Sun, 13 Jan 2008 06:40:21 -0800 (PST)
Received: by 10.44.112.30 with SMTP id k30gr1374hsc;
	Sun, 13 Jan 2008 06:40:21 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.197.13 with SMTP id z13mr4184315qbp.0.1200235221643; Sun, 13 Jan 2008 06:40:21 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id y6si2044142nzg.1.2008.01.13.06.40.20; Sun, 13 Jan 2008 06:40:21 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0DEeJHl013092; Sun, 13 Jan 2008 15:40:19 +0100 (CET)
Received: from [192.168.178.21] (brln-4db9329c.pool.einsundeins.de [77.185.50.156]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0DEe7oD011335 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Sun, 13 Jan 2008 15:40:18 +0100 (MET)
In-Reply-To: <7vsl13wmas.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70385>



On Jan 12, 2008, at 8:11 AM, Junio C Hamano wrote:

> The third rc for the next feature release GIT 1.5.4 is available
> at the usual places:


The msysgit setup is available at:

   http://code.google.com/p/msysgit/downloads/

	Steffen
