From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc2
Date: Fri, 28 Dec 2007 11:43:53 +0100
Message-ID: <AAB76121-7F18-4506-809F-EFCAAD76F8BC@zib.de>
References: <7v1w98lsg3.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
To: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Dec 28 11:43:22 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.173])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8CgO-0005TV-DZ
	for gcvm-msysgit@m.gmane.org; Fri, 28 Dec 2007 11:43:16 +0100
Received: by py-out-1314.google.com with SMTP id p69so894179pyb.5
        for <gcvm-msysgit@m.gmane.org>; Fri, 28 Dec 2007 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=xxCMrsQR1ccVPS2mohybF5DCnt3fgbwpWEuLOd8qOMM=;
        b=IKd8en8QZE9YihSuL8KgJHWrE58/ikwxUiMMkU9XG27fvgKUlU3LHiLAjs1CuAHJJWwZrBhMmRjV0p9D7o8oeuIXXLd0MDyy8E4+lgpO/+J/olkmREWM0olxJXx7NfMpcITzrygXfIOtb0Pp3Gqe2HBiyV0vuvToDrIch+uWkXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=F/pAhYWik+/nl8CW4Me4zCZgJrGkeh2tUr6Kls7YR4iEOAkt0sFCn7Dp95HJyAczwRrzAiB2s5AfAhA9dMeKHuQfHyVWVWrY686ygMItgjkTfm0ZKPqHRWLDzp4CTuo8xUk7oswJQg2XbxrsFazXli110PnJOT/WpcDSdcEy0Tw=
Received: by 10.35.64.7 with SMTP id r7mr393060pyk.2.1198838571548;
        Fri, 28 Dec 2007 02:42:51 -0800 (PST)
Received: by 10.107.114.37 with SMTP id r37gr1291prm;
	Fri, 28 Dec 2007 02:42:51 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.64.76.15 with SMTP id y15mr20576090qba.1.1198838570998; Fri, 28 Dec 2007 02:42:50 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id x35si13273773nzg.2.2007.12.28.02.42.49; Fri, 28 Dec 2007 02:42:50 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBSAgm7q007176; Fri, 28 Dec 2007 11:42:48 +0100 (CET)
Received: from [192.168.178.22] (p5499C94F.dip.t-dialin.net [84.153.201.79]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBSAgkMB019398 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 28 Dec 2007 11:42:47 +0100 (MET)
In-Reply-To: <7v1w98lsg3.fsf-jO8aZxhGsIagbBziECNbOZn29agUkmeCHZ5vskTnxNA@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69280>



On Dec 27, 2007, at 4:36 AM, Junio C Hamano wrote:

> GIT 1.5.4-rc2 is available at the usual places:


The msysgit installer is now available at

    http://code.google.com/p/msysgit/downloads

	Steffen
