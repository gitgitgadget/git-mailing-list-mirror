From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Sat, 5 Jul 2014 17:48:49 +0700
Message-ID: <CACsJy8AXAusNHb5GJgrcbgzXY-1_ER2CNmah=vkJzOgPHMHudA@mail.gmail.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBC2ZN5PHQUMBBMFQ36OQKGQESKH62SI@googlegroups.com Sat Jul 05 12:49:23 2014
Return-path: <msysgit+bncBC2ZN5PHQUMBBMFQ36OQKGQESKH62SI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f183.google.com ([209.85.128.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBMFQ36OQKGQESKH62SI@googlegroups.com>)
	id 1X3NX0-0003X2-GR
	for gcvm-msysgit@m.gmane.org; Sat, 05 Jul 2014 12:49:22 +0200
Received: by mail-ve0-f183.google.com with SMTP id jx11sf642907veb.10
        for <gcvm-msysgit@m.gmane.org>; Sat, 05 Jul 2014 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=T0QAihAdTIiSzSAZAkulXPTFkkj8lx0HyVKCMFjA0Co=;
        b=GliVJwrVK9L5rzcL/KIkxgf5xQJwvIPqvFfTMH8ZVakfKcWmy5aF6zWGRuaJfBnQYy
         In5+t/dIvnDQFuy7ZwOxoweFW7KdlrIp3XsqOyycgB2YcbhXacDL5Y9dvSRfoDINqQD6
         DInjGt1tIZhrtQmxuzd9npVE9Aao6Z3F+TZc48YPxoy1bwTR+CrpsmviB0c4+pd6m3tC
         kvptgKEpV2eH/f5zR0N2ZzTLKU7R1Gx5eJzd0kqOQHDgVgTJbxJ1GfsSB0JBfMCpqFPq
         LjZFTqV4BJ0pdKCfHhNvBdzAol++3evWqVRBIeB/SZvH0sbtZL6AoHdVcI6U2KZuHR9H
         ZdlA==
X-Received: by 10.182.91.37 with SMTP id cb5mr78182obb.0.1404557361427;
        Sat, 05 Jul 2014 03:49:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.196.65 with SMTP id ik1ls484154obc.52.gmail; Sat, 05 Jul
 2014 03:49:20 -0700 (PDT)
X-Received: by 10.182.58.71 with SMTP id o7mr8465183obq.3.1404557360099;
        Sat, 05 Jul 2014 03:49:20 -0700 (PDT)
Received: from mail-qa0-x231.google.com (mail-qa0-x231.google.com [2607:f8b0:400d:c00::231])
        by gmr-mx.google.com with ESMTPS id he4si4086031qcb.0.2014.07.05.03.49.20
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Jul 2014 03:49:20 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::231 as permitted sender) client-ip=2607:f8b0:400d:c00::231;
Received: by mail-qa0-f49.google.com with SMTP id w8so1962039qac.8
        for <msysgit@googlegroups.com>; Sat, 05 Jul 2014 03:49:20 -0700 (PDT)
X-Received: by 10.140.91.164 with SMTP id z33mr25731443qgd.65.1404557360018;
 Sat, 05 Jul 2014 03:49:20 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sat, 5 Jul 2014 03:48:49 -0700 (PDT)
In-Reply-To: <53B72DD5.6020603@gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::231
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252916>

On Sat, Jul 5, 2014 at 5:42 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> 'git status' segfaults if a directory is longer than PATH_MAX, because
> processing .gitignore files in prep_exclude() writes past the end of a
> PATH_MAX-bounded buffer.
>
> Remove the limitation by using strbuf instead.
>
> Note: this fix just 'abuses' strbuf as string allocator, len is always 0.
> prep_exclude() can probably be simplified using more strbuf APIs.

FYI I had a similar patch [1] that attempted to lazily strbuf_init()
instead so that strbuf_ API could be used.

[1] http://article.gmane.org/gmane.comp.version-control.git/248310
-- 
Duy

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
