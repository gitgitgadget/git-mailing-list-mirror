From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 03/17] (msvc-build) Vcproj.pm: remove duplicate GUID
Date: Sat, 27 Jun 2015 23:05:41 -0400
Message-ID: <CAPig+cTpJ2cz49guBFOHpOsP1UEip=JV-c2fPyjfdSegzZACJQ@mail.gmail.com>
References: <1435190633-2208-1-git-send-email-philipoakley@iee.org>
	<1435190633-2208-4-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GitList <git@vger.kernel.org>, MsysGitList <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBD2JJCMYYEGBBBOJXWWAKGQESTSJGUQ@googlegroups.com Sun Jun 28 05:05:46 2015
Return-path: <msysgit+bncBD2JJCMYYEGBBBOJXWWAKGQESTSJGUQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vn0-f57.google.com ([209.85.216.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2JJCMYYEGBBBOJXWWAKGQESTSJGUQ@googlegroups.com>)
	id 1Z92ud-0007UI-1F
	for gcvm-msysgit@m.gmane.org; Sun, 28 Jun 2015 05:05:43 +0200
Received: by vnav203 with SMTP id v203sf34759435vna.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 27 Jun 2015 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=DyzXdFKZUlxPGFRNRqMdvP6qwGMW1n4jYccFMlbhYM4=;
        b=UX0AsT7JSww07TWGPO7Mex8i8zXQT2uH+n2KEAVurTMDbvChkI56yQ58GX+rCMxGYn
         IKMA4/NIySKYRruIS4Xq5S9y7ITAibnvJb079CcXFJni66KCno38YHpqlHnu6zgMyZr5
         x9fididnOZ30OeIlkaahrk9ZEE04dxQTMrjQmYmk7Izz852fx9nUQCyIWsH5zNL7Cwv9
         h4z4sWakWmz4K0S8CXUkG+aLslAOV9qz+CGJORTj9DR5FTN/H5klT9i3NwwX/WLThi/j
         c0EZqfRR86rpA/76WmM5cJ1EnaeD/GglD4hozRsxDgPQ9MnkJMxoXHAZdcdHgIbf0RP8
         VIkA==
X-Received: by 10.50.67.100 with SMTP id m4mr83375igt.12.1435460741969;
        Sat, 27 Jun 2015 20:05:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.46.13 with SMTP id i13ls1701432ioo.43.gmail; Sat, 27 Jun
 2015 20:05:41 -0700 (PDT)
X-Received: by 10.43.5.136 with SMTP id og8mr12794767icb.1.1435460741433;
        Sat, 27 Jun 2015 20:05:41 -0700 (PDT)
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com. [2607:f8b0:4002:c07::22c])
        by gmr-mx.google.com with ESMTPS id x125si910699ywb.0.2015.06.27.20.05.41
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2015 20:05:41 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::22c as permitted sender) client-ip=2607:f8b0:4002:c07::22c;
Received: by mail-yk0-x22c.google.com with SMTP id y1so89466515ykd.2
        for <msysgit@googlegroups.com>; Sat, 27 Jun 2015 20:05:41 -0700 (PDT)
X-Received: by 10.170.97.9 with SMTP id o9mr11059852yka.84.1435460741285; Sat,
 27 Jun 2015 20:05:41 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.37.36.214 with HTTP; Sat, 27 Jun 2015 20:05:41 -0700 (PDT)
In-Reply-To: <1435190633-2208-4-git-send-email-philipoakley@iee.org>
X-Original-Sender: sunshine@sunshineco.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::22c
 as permitted sender) smtp.mail=ericsunshine@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272865>

On Wed, Jun 24, 2015 at 8:03 PM, Philip Oakley <philipoakley@iee.org> wrote:
> Delete the duplicated GUID from the generation code for the Visual Studio
> .sln project file.
>
> The duplicate GUID tended to be allocated to test-svn-fe, which was then
> ignored by Visual Studio / MSVC, and it's omission from the build never

s/it's/its/

> noticed.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  contrib/buildsystems/Generators/Vcproj.pm | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
> index cfa74ad..1b01d58 100644
> --- a/contrib/buildsystems/Generators/Vcproj.pm
> +++ b/contrib/buildsystems/Generators/Vcproj.pm
> @@ -52,7 +52,6 @@ my @GUIDS = (
>      "{00785268-A9CC-4E40-AC29-BAC0019159CE}",
>      "{4C06F56A-DCDB-46A6-B67C-02339935CF12}",
>      "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
> -    "{3A62D3FD-519E-4EC9-8171-D2C1BFEA022F}",
>      "{9392EB58-D7BA-410B-B1F0-B2FAA6BC89A7}",
>      "{2ACAB2D5-E0CE-4027-BCA0-D78B2D7A6C66}",
>      "{86E216C3-43CE-481A-BCB2-BE5E62850635}",
> --
> 2.3.1

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
