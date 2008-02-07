From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Thu, 7 Feb 2008 18:01:26 +0100
Message-ID: <FBE31353-CEB6-4563-AE5F-866D23D129EC@zib.de>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <CFB8A272-863C-4758-91F7-E9669D70A200@zib.de> <20080207123108.GA12009@bit.office.eurotux.com> <alpine.LSU.1.00.0802071255110.8543@racer.site> <20080207130715.GA14000@bit.office.eurotux.com> <alpine.LFD.1.00.0802070949460.2732@xanadu.home> <20080207155946.GA20459@bit.office.eurotux.com>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico-mo2vmkxb4K0@public.gmane.org>, Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>, Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Luciano Rocha <luciano-YWehAnL2kLNBDgjK7y7TUQ@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Feb 07 18:12:14 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNAHb-0002pm-AQ
	for gcvm-msysgit@m.gmane.org; Thu, 07 Feb 2008 18:11:33 +0100
Received: by wr-out-0708.google.com with SMTP id 56so5862374wra.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 07 Feb 2008 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=0v6DaXZoV220ODsdrcT9eKziX457mD7WzXpbqtQTyGc=;
        b=T5SaE5YoOQ+cM+M0jOBGPVaqrSmkrCJtaVR7WIFPE44cEw2KSEJweyOAP7Rblfe0AnHVoDihBqMjim5lF1/yvTQGKGWbvU2QcG0nKA1RRcmBi7DE262f+8hcq87ZoNjGt4CCIZwT7lEUufksTuCPOanAInU8sdWGlUoQ49GeZGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=ExlOL9pH40cN1ojmq1AK8WTzepPva+pzK+rZciqodMwY13tfdMstSQSUyJIDUNryY4vsEWWQVaAoMMjNW/Qe9x5iTy7U+TdLYTzNBATDpGx0NEXEhdwK/7hD4B/8Ip0uBy3o7CIVIlO1T3J587am6vic9s4bz8CvFAaGY2Nl+FQ=
Received: by 10.100.168.18 with SMTP id q18mr974680ane.12.1202404236684;
        Thu, 07 Feb 2008 09:10:36 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1654prf;
	Thu, 07 Feb 2008 09:10:36 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.35.108.12 with SMTP id k12mr25394914pym.3.1202404231640; Thu, 07 Feb 2008 09:10:31 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id x46si6974186pyg.3.2008.02.07.09.10.30; Thu, 07 Feb 2008 09:10:31 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m17H0ScZ009672; Thu, 7 Feb 2008 18:00:28 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m17H0RlZ013191 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Thu, 7 Feb 2008 18:00:27 +0100 (MET)
In-Reply-To: <20080207155946.GA20459-oEplIgxCSygGFt9iVWuREaMaJEuR8uiQ@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72978>



On Feb 7, 2008, at 4:59 PM, Luciano Rocha wrote:

>> They nevertheless must be made aware of the rules they have to  
>> follow in
>> case the idea of redistributing it crosses their mind.
>
> I don't dispute that, only that I can't continue with the install  
> unless
> I click on "I Accept" to the GNU GPL.

Simple question: Do you accept it or not?

	Steffen
