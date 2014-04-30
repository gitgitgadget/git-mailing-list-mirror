From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Wed, 30 Apr 2014 15:08:14 +0200
Message-ID: <CABPQNSbvoYfUp6ZG8kMPPX5rcDetUCqunOGO2cX-yhPsGkCOTg@mail.gmail.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>, Pat Thoyts <patthoyts@gmail.com>, 
	Marat Radchenko <marat@slonopotamus.org>, tuomas.silvola@knowit.fi, 
	msysGit <msysgit@googlegroups.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	Dave Borowitz <dborowitz@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBZXLQONQKGQEXQ33WTQ@googlegroups.com Wed Apr 30 15:09:03 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBZXLQONQKGQEXQ33WTQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f57.google.com ([209.85.219.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBZXLQONQKGQEXQ33WTQ@googlegroups.com>)
	id 1WfUFt-0007Ah-C4
	for gcvm-msysgit@m.gmane.org; Wed, 30 Apr 2014 15:08:57 +0200
Received: by mail-oa0-f57.google.com with SMTP id l6sf375335oag.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=IBhamcF0+N2sj5KZwIqHstv8YKJuCJPLGaPdcXHUpHs=;
        b=k5+S0tQjI/MxLz/4KxhRdKTk9ARvYj7jjIcUsJ4X/3oPLooGVN8OjQPlTbOmntYQr6
         /uemiozUIMwFb9bX25wFaSiVm3BDppjHASurynyEfxe0u1t2F/KQnJGR29RIGrneSIhx
         Rd8cu2Scquwd5sPTGsoZjoFThE6jvSXgbvBZ7ngKHGL0Bv1TAMIc3XcSSyIouFR90MYs
         DRIhBPOMWsHOguMvFmpT+Q6vdUAJYwXfRTogYK4Ct0nGzErfzwITUFKYFowVIa2vdewZ
         RhE0Dj+y8mx9JbCCVoqIFHwB9c7PR4TEVaOJIwWV0YjGoZh/Er95N+wrq3eKmMCXNn6c
         YUOw==
X-Received: by 10.50.36.10 with SMTP id m10mr104430igj.12.1398863335660;
        Wed, 30 Apr 2014 06:08:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.27.8 with SMTP id p8ls2624673igg.31.canary; Wed, 30 Apr
 2014 06:08:54 -0700 (PDT)
X-Received: by 10.43.117.71 with SMTP id fl7mr2131729icc.24.1398863334651;
        Wed, 30 Apr 2014 06:08:54 -0700 (PDT)
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com [2607:f8b0:4001:c03::22a])
        by gmr-mx.google.com with ESMTPS id rg8si457027igc.0.2014.04.30.06.08.54
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 06:08:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22a as permitted sender) client-ip=2607:f8b0:4001:c03::22a;
Received: by mail-ie0-x22a.google.com with SMTP id rd18so1842948iec.1
        for <msysgit@googlegroups.com>; Wed, 30 Apr 2014 06:08:54 -0700 (PDT)
X-Received: by 10.50.36.66 with SMTP id o2mr4465688igj.24.1398863334362; Wed,
 30 Apr 2014 06:08:54 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 30 Apr 2014 06:08:14 -0700 (PDT)
In-Reply-To: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22a
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247711>

On Mon, Apr 28, 2014 at 6:29 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> MinGW builds of cURL does not ship with curl-config unless built
> with the autoconf based build system, which is not the practice
> recommended by the documentation. MsysGit has had issues with
> binaries of that sort, so it has switched away from autoconf-based
> cURL-builds.
>
> Unfortunately, broke pushing over WebDAV on Windows, because
> http-push.c depends on cURL's multi-threaded API, which we could
> not determine the presence of any more.
>
> Since troublesome curl-versions are ancient, and not even present
> in RedHat 5, let's just assume cURL is capable instead of doing a
> non-robust check.
>
> Instead, add a check for curl_multi_init to our configure-script,
> for those on ancient system. They probably already need to do the
> configure-dance anyway.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

Junio,

this patch still applies, and is required on Git for Windows for
http-push to work, even after f3f11fa ("Makefile: default to -lcurl
when no CURL_CONFIG or CURLDIR").

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
