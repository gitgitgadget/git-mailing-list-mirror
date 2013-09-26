From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #08; Wed, 25)
Date: Thu, 26 Sep 2013 17:00:21 +0800
Message-ID: <CANYiYbH924SoWGdNP-f4iZxQxfR=JAywmap__m7FoEqMAYo-GA@mail.gmail.com>
References: <20130925234121.GD9464@google.com>
	<5243CFCD.6090604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Jonathan Nieder <jrnieder@gmail.com>, Git List <git@vger.kernel.org>, 
	Johannes Sixt <j6t@kdbg.org>, Tvangeste <i.4m.l33t@yandex.ru>, 
	Karsten Blees <karsten.blees@gmail.com>, msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBDM2Z447YYCBBJXPR6JAKGQEX5IOSVI@googlegroups.com Thu Sep 26 11:00:24 2013
Return-path: <msysgit+bncBDM2Z447YYCBBJXPR6JAKGQEX5IOSVI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDM2Z447YYCBBJXPR6JAKGQEX5IOSVI@googlegroups.com>)
	id 1VP7Qt-0005wP-MQ
	for gcvm-msysgit@m.gmane.org; Thu, 26 Sep 2013 11:00:23 +0200
Received: by mail-lb0-f191.google.com with SMTP id u14sf106238lbd.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 26 Sep 2013 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=grqo4rT8msgMDhrklzeo+eregM/1fQg7eVGTs3xf93c=;
        b=mFQUazDl3hDjr9QDlan0We2PU34nVWAhxSgbcbSZAjCxOVi0iGHlYZ4flWO72G/fsA
         Gnc7fffuOYf5K91WfXWQfafguExX8eixn7MtqpBvmEf1+LYoLQCP0U9kkdbDLSqWAW7c
         ZUt6bWmFl8czzXBBnd3JhmxaQl5Ym8bjVWg0cvAWHmtgbQXgJOkZfpFP6rMLRzx3qyld
         gQFtgEeM+SWthUCvDVqHXtGFEksEFXFSg4JB66UzgJ/HtlmztVNCSeF9MuURPBugLeu/
         myoMB29kyURS18tj7af5H75XWI6hbJaQf03564THcf3k0/2AXNXeD846l1iGKXwvS2KO
         YF8Q==
X-Received: by 10.180.188.3 with SMTP id fw3mr745625wic.11.1380186023374;
        Thu, 26 Sep 2013 02:00:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.198.170 with SMTP id jd10ls586934wic.35.gmail; Thu, 26 Sep
 2013 02:00:21 -0700 (PDT)
X-Received: by 10.180.109.19 with SMTP id ho19mr11635754wib.7.1380186021818;
        Thu, 26 Sep 2013 02:00:21 -0700 (PDT)
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com [2a00:1450:400c:c05::22a])
        by gmr-mx.google.com with ESMTPS id gt5si105902wib.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 02:00:21 -0700 (PDT)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 2a00:1450:400c:c05::22a as permitted sender) client-ip=2a00:1450:400c:c05::22a;
Received: by mail-wi0-f170.google.com with SMTP id cb5so6418297wib.5
        for <msysgit@googlegroups.com>; Thu, 26 Sep 2013 02:00:21 -0700 (PDT)
X-Received: by 10.180.12.45 with SMTP id v13mr26256139wib.57.1380186021716;
 Thu, 26 Sep 2013 02:00:21 -0700 (PDT)
Received: by 10.216.122.202 with HTTP; Thu, 26 Sep 2013 02:00:21 -0700 (PDT)
In-Reply-To: <5243CFCD.6090604@web.de>
X-Original-Sender: worldhello.net@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of worldhello.net@gmail.com designates
 2a00:1450:400c:c05::22a as permitted sender) smtp.mail=worldhello.net@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235406>

2013/9/26 Torsten B=F6gershausen <tboegi@web.de>:
>> * jx/relative-path-regression-fix (2013-09-20) 3 commits
>>  - Use simpler relative_path when set_git_dir
>>  - relative_path should honor dos-driver-prefix
>>  - test: use unambigous leading path (/foo) for mingw
>>
>>  Waiting for the review to settle.
> Is this V3, which is both fixing a regression
> and adding support for UNC path ?

No, it's not V3, but is V4 (same like v2, but there are minor updates for
test cases and commit logs). See:

 * http://thread.gmane.org/gmane.comp.version-control.git/234434/focus=3D23=
5047

You may already read my reply:

 * http://thread.gmane.org/gmane.comp.version-control.git/234434/focus=3D23=
5044

>
> My understanding is that V2
> commit 5a515ecc086dd8d0b74b0aff1248f4d1dc87f556
> jx/relative-path-regression-fix
> git://github.com/gitster/git.git
>
>
> is only fixing the regression and
> could be merged into next, master and possibly maint.
>

Yes, but commit 5a515ec is precisely V4.

--=20
Jiang Xin

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
