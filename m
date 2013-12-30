From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.8.5.2 (preview)
Date: Tue, 31 Dec 2013 00:57:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1312310043240.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBYMQRCLAKGQEBIX7JFA@googlegroups.com Tue Dec 31 00:57:22 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBYMQRCLAKGQEBIX7JFA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f55.google.com ([209.85.214.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBYMQRCLAKGQEBIX7JFA@googlegroups.com>)
	id 1Vxmi2-0002Hg-N9
	for gcvm-msysgit@m.gmane.org; Tue, 31 Dec 2013 00:57:22 +0100
Received: by mail-bk0-f55.google.com with SMTP id v15sf1065571bkz.10
        for <gcvm-msysgit@m.gmane.org>; Mon, 30 Dec 2013 15:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=AhVJk6lFc/T/7y1ylLP8eXVvMZXQpKjuij9Pr+7kWUc=;
        b=Kv0lAURXYhKkRP8Tm/bsb+HeU/0Vyuup3/tUWFhSZ3kU6vd3MrIWQnhyfqkQJFxU1u
         x8/QKXpwZutWYjJnAKs4GH52JW8cCKYwL0Geqg119nT17WYZi7LAry2vC1CKoBydT6ff
         hv7M9YbUtfv0/IGFHLfAl35YZCklVvBA07//AUqslXoDeOqk+RYAVUbrVWpQ4FYlDB0Y
         GeJcb9fKfKZtWIQlIFGK0u7FU7eVbunXJ7ltBCHcw+QBwERT5KF7yefLZbY/iwCSKJYz
         5ojNVQbZ7chLqmgTbusTPrYVpXidqueQ1O1ZLOPFBE4wC5642ThLhLJtEZi/DhnaEtDe
         rMoQ==
X-Received: by 10.180.90.38 with SMTP id bt6mr309858wib.18.1388447842224;
        Mon, 30 Dec 2013 15:57:22 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.10.42 with SMTP id f10ls1106289wib.48.gmail; Mon, 30 Dec
 2013 15:57:21 -0800 (PST)
X-Received: by 10.204.69.203 with SMTP id a11mr13457502bkj.0.1388447841290;
        Mon, 30 Dec 2013 15:57:21 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.21])
        by gmr-mx.google.com with ESMTPS id b3si2323844eez.0.2013.12.30.15.57.21
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2013 15:57:21 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as permitted sender) client-ip=212.227.17.21;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Ldcv0-1VX0jK3Np4-00ikYG
 for <msysgit@googlegroups.com>; Tue, 31 Dec 2013 00:57:20 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:0K6jqPRoC/xFcMtPY2BekHAuyBndtvsPZvIIFcfZBDP52KLwN5J
 5Lm99Joo+z4ujZ/YVOLqZvfDajlu1ZGC5SIgHxy6FwDbxx+nNEGydG4hrYj5HiAwkd6Cccv
 SFjvrox6gcJNdfLAzJhen9jilP7461qJeNo5i7EdT5bU0Co7ljAT70PZd32EEmXNCtgXe2p
 +yW5ZmManlD6Uj/9LdO7A==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.21 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239831>

Dear fans of Git,

this mail brings to you the good news that Git for Windows is available in
a new version: 1.8.5.2-preview20131230

Many, many thanks go to the tireless developers working on this
particularly hard port of Git.

Changes since Git-1.8.4-preview20130916

New Features

- Comes with Git 1.8.5.2 plus Windows-specific patches.

- Windows-specific patches are now grouped into pseudo-branches which
  should make future development more robust despite the fact that we have
  had less than stellar success getting the Windows-specific patches accepted
  by upstream git.git.

- Works around more path length limitations (pull request #86)

- Has an optional stat() cache toggled via core.fscache (pull request #107)

Bugfixes

- Lots of installer fixes

- git-cmd: Handle home directory on a different drive correctly (pull
  request #146)

- git-cmd: add a helper to work with the ssh agent (pull request #135)

- Git-Cheetah: prevent duplicate menu entries (pull request #7)

- No longer replaces dos2unix with hd2u (a more powerful, but slightly
  incompatible version of dos2unix)

In keeping with the fine tradition of making a release on the eve of a
holiday, and immediately going on vacation, it is my pleasure to wish you
all a happy new year,
Johannes

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
For more options, visit https://groups.google.com/groups/opt_out.
