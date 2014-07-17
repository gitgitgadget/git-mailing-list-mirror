From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 21:00:00 +0200
Message-ID: <20140717190000.GA18960@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
 <53C8115D.8040505@gmail.com>
 <xmqqfvhzq22x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBCU63DXMWULRBMN2UCPAKGQEFU2EBLQ@googlegroups.com Thu Jul 17 21:00:03 2014
Return-path: <msysgit+bncBCU63DXMWULRBMN2UCPAKGQEFU2EBLQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMN2UCPAKGQEFU2EBLQ@googlegroups.com>)
	id 1X7quP-000700-Rg
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 21:00:01 +0200
Received: by mail-wg0-f64.google.com with SMTP id m15sf289059wgh.29
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=4EBI/gE4O6SurlE63FqAzQHiQ1BFj2o0EWJW+fdLHpk=;
        b=FxBc23SVZRJkRv/GYdI1KGVrTUohM7Et1LRb7kRCOt6SFLt4F8aEZgm87EmmWXDymX
         3Bn2aerXIpCgjbHSdUTXtORgqdKnOYmx3fYLpF/SRDcqEN/4yO9BKkeoltBfgKGFhHiu
         Dl3Fzj8xA3yZjIEdfl4uXaiek5vV+NTbuKNIpkm9SB9LLkvGDbItpq/EYL3kFcWHcOxU
         Xfpdmk0H1QG5ZnFOJk533GMfM4BsqsDx/iJDhf8X64lPW1/H+08WNACE1gf3cJ7I5D/m
         wd+wfkv/uCZUxroBBiZz/Mzx2qcVgBTz35TFkj3JtWDSaKa0BJbU5HSxoN+nJV6dQqLf
         Ho+w==
X-Received: by 10.152.4.136 with SMTP id k8mr21525lak.19.1405623601570;
        Thu, 17 Jul 2014 12:00:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.8.100 with SMTP id q4ls222653laa.63.gmail; Thu, 17 Jul
 2014 12:00:00 -0700 (PDT)
X-Received: by 10.112.133.227 with SMTP id pf3mr2211lbb.24.1405623600566;
        Thu, 17 Jul 2014 12:00:00 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id mx7si1109881wic.1.2014.07.17.12.00.00
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 12:00:00 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 547931C0188; Thu, 17 Jul 2014 21:00:00 +0200 (CEST)
In-Reply-To: <xmqqfvhzq22x.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253771>

Hi,

> Karsten Blees <karsten.blees@gmail.com> writes:
> > I believe we prefer moving code to the right place over forward
> > declarations (IIRC I got bashed for the latter in one of the first rounds
> > of this patch series). If only to justify 'git-blame -M' :-D

indeed, my position is the same, generally.

But it turned out that the current ordering is sane, mostly works as it is,
and I needed _only one_ fwd decl to make things compile.  This is why I
decided to have things arranged this way.

If anyone thinks the resulting ordering is not OK, they can propose
one re-order patch on top of this series.

Junio wrote:
> OK, so the series may need further re-polishing of the polishing
> done by Stepan last-minute before sending them out.  I'll still

No, it was not last minute work.  It was done several weeks ago, after some
planning, etc.  It's my best.  Corrections welcome, though.

Stepan

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
