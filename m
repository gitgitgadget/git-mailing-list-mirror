From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 14:59:01 +0400
Message-ID: <20141008105901.GA9433@seldon>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
 <alpine.DEB.1.00.1410081139330.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	marat@slonopotamus.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCE7TAPITACRBAFS2SQQKGQEDOVD74I@googlegroups.com Wed Oct 08 12:59:14 2014
Return-path: <msysgit+bncBCE7TAPITACRBAFS2SQQKGQEDOVD74I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBAFS2SQQKGQEDOVD74I@googlegroups.com>)
	id 1Xboxd-0004jO-SJ
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 12:59:13 +0200
Received: by mail-lb0-f185.google.com with SMTP id u10sf745830lbd.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 03:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ak4PEFTNQhBjNRkA49qCvAHwI1Z8PTSgh16pwo+UqrA=;
        b=wphnz63uLmeFXaUueO5zZZ3nFFsHAW4LErEH9dVNiGbzzaw3L4XV/KpP4o2zvN46R5
         RPVor5cGubdy53okzSaHalG0W65mvT9Cx7u6vDBLJj7mxtJNN7zbiBDhrh2Uh+BnpVLA
         4dwQIotuKx5zdsd4lxOswysSIZ9aQMDjrsYQsRwBiMrkx5sIFmfAQu025MGyHMH3/xwo
         KWe55imAQV+QWyrRDRreAKLkY68zv8/AZ1Nc3pwhNp5B0XVRv6PmHWQxw7fCYZH70chC
         R4J+JoJ6M8bNbX/TzQWaRs46ZDI40AtGWYTV8tq0qln0TennwVGv8FORdp5FyK0e2RWH
         5XyA==
X-Received: by 10.152.203.200 with SMTP id ks8mr12840lac.8.1412765953600;
        Wed, 08 Oct 2014 03:59:13 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.103 with SMTP id v7ls48413lal.32.gmail; Wed, 08 Oct
 2014 03:59:11 -0700 (PDT)
X-Received: by 10.152.1.136 with SMTP id 8mr332728lam.5.1412765951695;
        Wed, 08 Oct 2014 03:59:11 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id go4si66894wib.3.2014.10.08.03.59.11
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 03:59:11 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XboxR-0002lD-GJ; Wed, 08 Oct 2014 14:59:02 +0400
In-Reply-To: <alpine.DEB.1.00.1410081139330.990@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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

On Wed, Oct 08, 2014 at 11:40:17AM +0200, Johannes Schindelin wrote:
> To make it easier to review and substantially easier to work on this patch
> series with Git, I opened a pull request on GitHub:
>
>       https://github.com/msysgit/git/pull/264
>

1. I fail to see how using a tool that doesn't send emails about review
   comments is *easier* than just sending emails.

2. Please, do not hijack patchset discussion by moving it from git@ ML to 
   GitHub comments.

3. And I repeat, my goal is to push this stuff in git.git,
   not in msysgit.git, not in git-for-windows.git, not in msys2.git, not in other
   4k+ forks on GitHub.

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
