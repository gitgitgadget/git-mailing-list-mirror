From: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: git checkout bug on Win7 x64
Date: Fri, 11 Jan 2013 13:54:59 +0400
Message-ID: <20130111135459.8f3d10614ca052045b2982f2@domain007.com>
References: <CAJ52sWnm23pLibG24PZm0UB=_tk7JahNx0c53E1udJG4D3yvvQ@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Ishayahu Lastov <meoc-it-JGs/UdohzUI@public.gmane.org>
X-From: git-users+bncBCWKX34CSUCBB5WCX6DQKGQEUOA2XII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Jan 11 10:55:22 2013
Return-path: <git-users+bncBCWKX34CSUCBB5WCX6DQKGQEUOA2XII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCWKX34CSUCBB5WCX6DQKGQEUOA2XII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TtbKa-00086h-Ir
	for gcggu-git-users@m.gmane.org; Fri, 11 Jan 2013 10:55:20 +0100
Received: by mail-la0-f58.google.com with SMTP id ej20sf502190lab.23
        for <gcggu-git-users@m.gmane.org>; Fri, 11 Jan 2013 01:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf:date:from
         :to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:x-google-group-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Lm8CmvAruEMG5dvJpwW54lb3ntwjFC1zrT90wZllFks=;
        b=KKg430dN3vZwn9OhLnAuXIdx1WWQPQrxRqiHMqYeBkwvPHqz8W2PFAI8gbehq7XZ/c
         rDyFC/sP+cxzpjvji3LiV3f/Iq/W9rCS123Mz0LKpK40vGPb1I0b6e9GobgcOxJDxYNS
         B8FgHRff7mas9CVUJjzMPFARxVxQ19Rj0Qrs+OqrJzH2Eg8/KYk5eJ+hprDsbgFIofNi
         yc9sO6NQjb7VIrxPHVNPXuFJDC5uXQ0TsSCuF4ze+/tlPGBxakHT6wwN1Yt1YpRxLOZ1
         GAs3EfV6QNWvhoxrTYZ8vcPvRaVLYFQK2L 
X-Received: by 10.180.99.231 with SMTP id et7mr2020619wib.8.1357898104399;
        Fri, 11 Jan 2013 01:55:04 -0800 (PST)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.180.88.2 with SMTP id bc2ls132086wib.40.canary; Fri, 11 Jan
 2013 01:55:02 -0800 (PST)
X-Received: by 10.204.128.201 with SMTP id l9mr3973505bks.8.1357898102189;
        Fri, 11 Jan 2013 01:55:02 -0800 (PST)
X-Received: by 10.204.128.201 with SMTP id l9mr3973504bks.8.1357898102169;
        Fri, 11 Jan 2013 01:55:02 -0800 (PST)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id e21si377847bkv.2.2013.01.11.01.55.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 01:55:02 -0800 (PST)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) client-ip=84.204.203.130;
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r0B9t0DY003289;
	Fri, 11 Jan 2013 13:55:01 +0400
In-Reply-To: <CAJ52sWnm23pLibG24PZm0UB=_tk7JahNx0c53E1udJG4D3yvvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Original-Sender: flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 84.204.203.130 is neither permitted nor denied by best guess
 record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) smtp.mail=flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en-US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en-US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en-US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en-US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213188>

On Fri, 11 Jan 2013 11:30:01 +0400
Ishayahu Lastov <meoc-it-JGs/UdohzUI@public.gmane.org> wrote:

[...]
> As I understand after last "git checkout" in "git status" I should see
> that I gave no changes. It looks like an bug, isn't it?

Looks like an EOL-conversion problem rather typical to Windows, see
http://stackoverflow.com/a/2016426/720999

-- 
