From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Crash on context menu
Date: Thu, 26 Dec 2013 14:43:19 +0100
Message-ID: <CABPQNSYXL2ZUmRB5KUY2c5BjBwwXsgtkNMcSm3b3Xzner+6vWw@mail.gmail.com>
References: <CAMPNTL3vrSUSbMP4-NsA=38KBM6iS9o9_Ywrzh1V_i42JmYFrQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: George Bateman <georgebateman16@gmail.com>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBDR53PPJ7YHRBIHF6CKQKGQEQJLJJHQ@googlegroups.com Thu Dec 26 14:44:03 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBIHF6CKQKGQEQJLJJHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBIHF6CKQKGQEQJLJJHQ@googlegroups.com>)
	id 1VwBEH-0001hV-HE
	for gcvm-msysgit@m.gmane.org; Thu, 26 Dec 2013 14:44:01 +0100
Received: by mail-oa0-f58.google.com with SMTP id k1sf1735451oag.23
        for <gcvm-msysgit@m.gmane.org>; Thu, 26 Dec 2013 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=hJ+uNkvejDvqNA1ky6XNKegZOlj+Ejme83Cukdt2zGQ=;
        b=HYZH1NWYfJz2D+L5Tjjphxs87r1Ej41P9TEu6mpto95ceops6PQSqj6ykIwXxh5wl+
         t4PEAOL2/2oSBkFlfdZGMpQp26YZWsmNIFgaG+ci/DGJ0ZpLMkJo1tsZizlOJs5s0KU2
         jEfCYuD1hH/IBU+pF9uv2CmWWq3aBqY7CJbE1iVCm1zMcsf68r29ErlY6uuLMsOu6/r2
         ICL3FgR8PUhY03DKWJx3AS80KocXExLMe/YFTKoHMk29UdpNfz+vtylSxhSEgwUjs5ou
         pOoduw3QhHwT6hcCOiZiyE0mT/KIMdPbCJiWCM8aIpxMtN2XUUAsJDbJLjqK+JidEWJn
         tEhA==
X-Received: by 10.50.6.130 with SMTP id b2mr519864iga.10.1388065440516;
        Thu, 26 Dec 2013 05:44:00 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.16.66 with SMTP id fu2ls6212290igd.6.canary; Thu, 26 Dec
 2013 05:43:59 -0800 (PST)
X-Received: by 10.67.14.70 with SMTP id fe6mr16809770pad.15.1388065439816;
        Thu, 26 Dec 2013 05:43:59 -0800 (PST)
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com [2607:f8b0:4001:c05::22a])
        by gmr-mx.google.com with ESMTPS id d9si9534042yhl.2.2013.12.26.05.43.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 05:43:59 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a as permitted sender) client-ip=2607:f8b0:4001:c05::22a;
Received: by mail-ig0-f170.google.com with SMTP id k19so27378818igc.1
        for <msysgit@googlegroups.com>; Thu, 26 Dec 2013 05:43:59 -0800 (PST)
X-Received: by 10.50.238.196 with SMTP id vm4mr34930222igc.43.1388065439250;
 Thu, 26 Dec 2013 05:43:59 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Thu, 26 Dec 2013 05:43:19 -0800 (PST)
In-Reply-To: <CAMPNTL3vrSUSbMP4-NsA=38KBM6iS9o9_Ywrzh1V_i42JmYFrQ@mail.gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22a
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239694>

On Thu, Dec 26, 2013 at 2:16 PM, George Bateman
<georgebateman16@gmail.com> wrote:
> Win7 SP1; Git identifies itself as version 1.8.4-preview20130916.
> I copied the Git Bash shortcut from the start menu to the root of a
> Git repository (no remote part). I use the advanced context menu. For
> other files in the directory, it works fine, but hovering over the Git
> GUI option of the Bash shortcut's menu causes a hang and this error:
> Problem signature:
>   Problem Event Name:    APPCRASH
>   Application Name:    explorer.exe
>   Application Version:    6.1.7601.17567
>   Application Timestamp:    4d672ee4
>   Fault Module Name:    git_shell_ext64.dll
>   Fault Module Version:    0.1.0.0
>   Fault Module Timestamp:    5236e807
>   Exception Code:    c0000005
>   Exception Offset:    0000000000005952
>   OS Version:    6.1.7601.2.1.0.768.3
>   Locale ID:    2057
>   Additional Information 1:    e0e1
>   Additional Information 2:    e0e1a815a0aa94764feb60e78ef36122
>   Additional Information 3:    adad
>   Additional Information 4:    adad544d8612f37837c12844e48b8ca2
>
> It seems odd that  it occurs on hover, but nothing else - time or
> other menu items - trigger it.

This is a problem with git-cheetah, and not git itself, so the
question is probably better suited at the msysGit mailing list, as
git-cheetah is mostly developed there.

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
