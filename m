X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS15169 209.85.128.0/17
X-Spam-Status: No, score=2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_SORBS_WEB,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Path: news.gmane.org!not-for-mail
From: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Newsgroups: gmane.comp.version-control.git.user,gmane.comp.version-control.git
Subject: Re: [PATCH] build: add default configuration
Date: Wed, 18 Sep 2013 21:30:28 -0500
Message-ID: <ab38a1b5-e354-4e32-8ede-46a401ef8053.maildroid@localhost>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
 <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
 <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
NNTP-Posting-Host: plane.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
X-Trace: ger.gmane.org 1379557834 11672 80.91.229.3 (19 Sep 2013 02:30:34 GMT)
X-Complaints-To: usenet@ger.gmane.org
NNTP-Posting-Date: Thu, 19 Sep 2013 02:30:34 +0000 (UTC)
Cc: git@vger.kernel.org,git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Original-X-From: git-users+bncBD6J3AEPVABRBSWD5GIQKGQE24WZAVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Sep 19 04:30:37 2013
Return-path: <git-users+bncBD6J3AEPVABRBSWD5GIQKGQE24WZAVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-qc0-f184.google.com ([209.85.216.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBD6J3AEPVABRBSWD5GIQKGQE24WZAVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VMU0r-0007Bp-Ab
	for gcggu-git-users@m.gmane.org; Thu, 19 Sep 2013 04:30:37 +0200
Received: by mail-qc0-f184.google.com with SMTP id e20sf2300896qcy.21
        for <gcggu-git-users@m.gmane.org>; Wed, 18 Sep 2013 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=QkeI4IrAhLBn9gNbUTC3jdPcc27r39DpAlArFOg7CxM=;
        b=HRvHdQ9fgV5iJoR6JOjTIqu/GznUqcADlVHkb/67Yj1zqobu76OsoCXQp6M4EvTf3n
         ZyI3OLpkZBAl1DJWFGNIGjfbGE8hoKxKRu2pjnJ5QJ9yRJwH//EmUkGB47ijMcdDZBA3
         Wx0A+dtDJVsxDQLS36jc8whsBAFILQKP5lIZEJcLJawOj+Ct4M8JX01WJxhZyv1Huy6M
         a8H5TcAhjMvYgJCcgkZsU9Z6G6L7+vfyVCehIbO1OG39hMk1+WKydJOcEK46odlsOH8j
         u7qZioDyLgFCKM7zNAgTcNFMhMcrSgDW4rAQfFFNrjZ4rmdDyX3h2IjCOS4DbkPEBsST
         OcEA==
X-Received: by 10.49.74.234 with SMTP id x10mr239072qev.13.1379557836467;
        Wed, 18 Sep 2013 19:30:36 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.49.58.148 with SMTP id r20ls3808716qeq.3.gmail; Wed, 18 Sep
 2013 19:30:34 -0700 (PDT)
X-Received: by 10.236.209.103 with SMTP id r67mr17214918yho.35.1379557834678;
        Wed, 18 Sep 2013 19:30:34 -0700 (PDT)
Received: from mail-ye0-x22e.google.com (mail-ye0-x22e.google.com [2607:f8b0:4002:c04::22e])
        by gmr-mx.google.com with ESMTPS id a49si776326yhc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 19:30:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c04::22e as permitted sender) client-ip=2607:f8b0:4002:c04::22e;
Received: by mail-ye0-f174.google.com with SMTP id q4so3202988yen.33
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 18 Sep 2013 19:30:34 -0700 (PDT)
X-Received: by 10.236.139.198 with SMTP id c46mr87073yhj.78.1379557834420;
        Wed, 18 Sep 2013 19:30:34 -0700 (PDT)
Received: from com.flipdogsolutions ([200.10.66.132])
        by mx.google.com with ESMTPSA id r1sm7560799yhf.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 19:30:33 -0700 (PDT)
In-Reply-To: <CAMP44s35_emnh9Kce433oy1JW66xB2vaN5f5OO7VF1XqoO=YGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Original-Sender: davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c04::22e as
 permitted sender) smtp.mail=davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users>
Original-Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Xref: news.gmane.org gmane.comp.version-control.git.user:6118 gmane.comp.version-control.git:235000
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git.user/6118>
X-Mailing-List: git@vger.kernel.org

>On Wed, Sep 18, 2013 at 1:13 PM, David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> Will this not conflict with folks that supply their own gitconfig?

> You mean people that provide their own ETC_GITCONFIG? If you mean
distributions, their packaging would override /etc/gitconfig, if you
mean people that have already a /etc/gitconfig, packaging systems
usually save the old one so they can solve the conflict manually (e.g.
/etc/gitconfig.pacsave). So no, it would not conflict.

Yuck. Yes, that one. I package my own /etc/gitconfig (as we have long advertised as the "way to do it") and asking users to manually fix up thousands of machines is a bad idea. 

Yes, thousands.  We're much past 30,000 cores at the moment. 

>> I like the idea. Docs?  Also, should this not be done in the C side so that we don't waste time reading the config, and also prevent users from overriding these?

> But we want them to be easily readable, and possibly allow
distributions to easily modify them.

In that case I take it back -- I dont like that approach.  We want consistency, not divergence. This encourages the former. 
-- 
David

