From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: Re: [PATCH v2] config: preserve config file permissions
 on edits
Date: Mon, 19 May 2014 10:59:24 -0500
Message-ID: <537A2A5C.8040706@gmail.com>
References: <20140505215853.GA23299@dcvr.yhbt.net> <20140506001714.GA29049@dcvr.yhbt.net> <5379AF29.4000508@viscovery.net> <CABPQNSZMExeXXMEUNE9HneK1rfXeLoK=vHZkm38xKt_2VctjXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Eric Wong <normalperson@yhbt.net>, Junio C Hamano <gitster@pobox.com>, 
 GIT Mailing-list <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com, Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDJ6D36VRQEBB2GU5CNQKGQE2ZIDGAY@googlegroups.com Mon May 19 17:59:38 2014
Return-path: <msysgit+bncBDJ6D36VRQEBB2GU5CNQKGQE2ZIDGAY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f183.google.com ([209.85.220.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDJ6D36VRQEBB2GU5CNQKGQE2ZIDGAY@googlegroups.com>)
	id 1WmPyT-0004Fj-C1
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 17:59:37 +0200
Received: by mail-vc0-f183.google.com with SMTP id lf12sf2406778vcb.10
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ww2JdMhcESmwyIY3ctMfc5koPQbhYa5zWfZDCxMAX28=;
        b=KiviJR1HkniNso4o0aNu5mveZgD5+niQQMqLETbDnYwlsifb8caJkxQ1+hey84hbQq
         Qb3Vrbq+q+VE1HehnZuFaZUgAOvaKyA8grP6YJdUBzvxeEbeJX7FD3nkFtvB2YuIfbZ3
         7VbyNc/TigagTuABhVOMYmuzUicOKPshMMEVDkthBgcSVacPY0rpZpF7ixEgM92tfVFC
         +PTvNKzBy/0Go6TbB4jRbo7X+oDE2eP3upHvl6QL9tCVatyo2mNqL3wTm7aSxG99rSJa
         7xJ7W/zxd9+jysA92PgTDiVU+ei4P1R9UX5DYI9UdVo+68N77XjCKQS/u9/H0eU15UPw
         fbUA==
X-Received: by 10.140.91.40 with SMTP id y37mr26954qgd.37.1400515176572;
        Mon, 19 May 2014 08:59:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.43.35 with SMTP id d32ls1928189qga.87.gmail; Mon, 19 May
 2014 08:59:25 -0700 (PDT)
X-Received: by 10.236.69.74 with SMTP id m50mr14369080yhd.0.1400515165408;
        Mon, 19 May 2014 08:59:25 -0700 (PDT)
Received: from mail-ob0-x231.google.com (mail-ob0-x231.google.com [2607:f8b0:4003:c01::231])
        by gmr-mx.google.com with ESMTPS id b5si682637igl.0.2014.05.19.08.59.25
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 08:59:25 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 2607:f8b0:4003:c01::231 as permitted sender) client-ip=2607:f8b0:4003:c01::231;
Received: by mail-ob0-f177.google.com with SMTP id wp4so6198462obc.22
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 08:59:25 -0700 (PDT)
X-Received: by 10.60.63.66 with SMTP id e2mr11514888oes.34.1400515165073;
        Mon, 19 May 2014 08:59:25 -0700 (PDT)
Received: from [10.3.3.224] ([199.227.34.94])
        by mx.google.com with ESMTPSA id sm4sm32620182obc.3.2014.05.19.08.59.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 08:59:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CABPQNSZMExeXXMEUNE9HneK1rfXeLoK=vHZkm38xKt_2VctjXQ@mail.gmail.com>
X-Original-Sender: mstormo@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of mstormo@gmail.com designates 2607:f8b0:4003:c01::231
 as permitted sender) smtp.mail=mstormo@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249592>

On 5/19/2014 2:44 AM, Erik Faye-Lund wrote:
> On Mon, May 19, 2014 at 9:13 AM, Johannes Sixt <j.sixt@viscovery.net>
> wrote:
>> I'm not proficient enough to add any ACL fiddling to fchmod that
>> would be required by the above change, whose purpose is to be
>> strict about permissions. Nor am I interested (who the heck is
>> sharing a Windows box anyway? ;-)
>
> Since we use MSVCRT's chmod implementation directly which only
> checks for S_IWRITE,and Get/SetFileAttributes to simply set or clear
> the FILE_ATTRIBUTE_READONLY-flag, perhaps we could do the same
> except using Get/SetFileInformationByHandle instead? That takes us in
> a better direction, IMO. Adding full ACL support seems like a bigger
> project.
>
> If there's no objection, I'll sketch up a patch for that...

IMO, try to stay away from full ACL support, as ACL is slow as hell.
If it's only triggered in edge cases, that's fine, but be sure not to 
add any ACL in the main call-paths as it will surely kill performance.

The major speedup which was done by circumventing MSYS/Cygwin standard 
posix implementations was bypassing much of the ACL slowness.

-- 
.marius

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
