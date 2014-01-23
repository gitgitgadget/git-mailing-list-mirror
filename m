From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix compilation of Windows
 resource file
Date: Thu, 23 Jan 2014 12:02:37 +0000
Message-ID: <CABNJ2GJRsqsr5+ga3-oKVU_H-HtsH+R14fBaVwV8jJcExkxr4g@mail.gmail.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
	<52DF6B6C.4020708@viscovery.net>
	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
	<52DFF4E8.8060605@viscovery.net>
	<xmqqppnjyl10.fsf@gitster.dls.corp.google.com>
	<xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>
	<52E0C4BA.4080405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>, Junio C Hamano <gitster@pobox.com>, 
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, GIT Mailing-list <git@vger.kernel.org>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: msysgit+bncBDRPLLPZ44IBBX4JQSLQKGQEMTTQZ2Y@googlegroups.com Thu Jan 23 13:02:40 2014
Return-path: <msysgit+bncBDRPLLPZ44IBBX4JQSLQKGQEMTTQZ2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDRPLLPZ44IBBX4JQSLQKGQEMTTQZ2Y@googlegroups.com>)
	id 1W6IzY-0007TY-FM
	for gcvm-msysgit@m.gmane.org; Thu, 23 Jan 2014 13:02:40 +0100
Received: by mail-wg0-f59.google.com with SMTP id n12sf163966wgh.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Jan 2014 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=ldxdF3wmqEv1tr7Xsf+q14kRT+pw+a+eKlFKzIt7wnw=;
        b=krcmi1veGXWuIvNnQA/TbKdqMR9jHJxA0PL9GvVYpy0RSdhhLF4Uyrl01KNL3VDhmI
         uX47Iz+E/Eor5MebwVIilPX7KzqkHZL0DxSDgnQniiixuUpycccERerjwNDa2/e9sHF7
         poGN9RG3npGCUyvn78wTl4V95TCFbC7alBWsmEOPW+kROwxoepwgpPAUAkdRKJhHd0uM
         8YMsFtRawozwUVDCTpJfhh00n/2qECclibYqfwG8Dmt+0y12kiL4zbDrhbozX9DZKRqR
         +n7mCHiZa2caoeEKvH5FmGB6zhet4QvQfk5FTR1YcqIZ+Gz2/aaVvye3USx6Y/j3key+
         zl8w==
X-Received: by 10.152.209.69 with SMTP id mk5mr12318lac.17.1390478560152;
        Thu, 23 Jan 2014 04:02:40 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.6.12 with SMTP id cq12ls11969lad.97.gmail; Thu, 23 Jan
 2014 04:02:39 -0800 (PST)
X-Received: by 10.112.56.100 with SMTP id z4mr3284272lbp.0.1390478558999;
        Thu, 23 Jan 2014 04:02:38 -0800 (PST)
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com [2607:f8b0:400e:c01::230])
        by gmr-mx.google.com with ESMTPS id z12si1432613bkg.3.2014.01.23.04.02.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 04:02:38 -0800 (PST)
Received-SPF: pass (google.com: domain of patthoyts@gmail.com designates 2607:f8b0:400e:c01::230 as permitted sender) client-ip=2607:f8b0:400e:c01::230;
Received: by mail-pb0-f48.google.com with SMTP id rr13so1744244pbb.21
        for <msysgit@googlegroups.com>; Thu, 23 Jan 2014 04:02:37 -0800 (PST)
X-Received: by 10.68.4.194 with SMTP id m2mr7704546pbm.19.1390478557226; Thu,
 23 Jan 2014 04:02:37 -0800 (PST)
Received: by 10.68.133.202 with HTTP; Thu, 23 Jan 2014 04:02:37 -0800 (PST)
In-Reply-To: <52E0C4BA.4080405@viscovery.net>
X-Original-Sender: patthoyts@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of patthoyts@gmail.com designates 2607:f8b0:400e:c01::230
 as permitted sender) smtp.mail=patthoyts@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240909>

On 23 January 2014 07:28, Johannes Sixt <j.sixt@viscovery.net> wrote:
> From: Johannes Sixt <j6t@kdbg.org>
>
> If the git version number consists of less than three period
> separated numbers, then the Windows resource file compilation
> issues a syntax error:
>
>   $ touch git.rc
>   $ make V=1 git.res
>   GIT_VERSION = 1.9.rc0
>   windres -O coff \
>             -DMAJOR=1 -DMINOR=9 -DPATCH=rc0 \
>             -DGIT_VERSION="\\\"1.9.rc0\\\"" git.rc -o git.res
>   C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
>   make: *** [git.res] Error 1
>   $
>
> Note that -DPATCH=rc0.
>
> The values passed via -DMAJOR=, -DMINOR=, and -DPATCH= are used in
> FILEVERSION and PRODUCTVERSION statements, which expect up to four numeric
> values. These version numbers are intended for machine consumption. They
> are typically inspected by installers to decide whether a file to be
> installed is newer than one that exists on the system, but are not used
> for much else.
>
> We can be pretty certain that there are no tools that look at these
> version numbers, not even the installer of Git for Windows does.
> Therefore, to fix the syntax error, fill in only the first two numbers,
> which we are guaranteed to find in Git version numbers.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  That "not even the installer of Git for Windows uses" the FILEVERSION
>  numbers is a bold statement of mine (I did not check). If I am wrong,
>  this approach for a fix is not viable, and a better fix would be
>  needed. Otherwise, an Acked-By would be appreciated so that we can
>  have this fix in upstream ASAP.
>
>  Makefile | 2 +-
>  git.rc   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b4af1e2..99b2b89 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>
>  git.res: git.rc GIT-VERSION-FILE
>         $(QUIET_RC)$(RC) \
> -         $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
> +         $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>           -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>
>  ifndef NO_PERL
> diff --git a/git.rc b/git.rc
> index bce6db9..33aafb7 100644
> --- a/git.rc
> +++ b/git.rc
> @@ -1,6 +1,6 @@
>  1 VERSIONINFO
> -FILEVERSION     MAJOR,MINOR,PATCH,0
> -PRODUCTVERSION  MAJOR,MINOR,PATCH,0
> +FILEVERSION     MAJOR,MINOR,0,0
> +PRODUCTVERSION  MAJOR,MINOR,0,0
>  BEGIN
>    BLOCK "StringFileInfo"
>    BEGIN
> --
> 1.9.rc0.1179.g5088b55
>
This was put in as a response to
https://github.com/msysgit/git/issues/5 where a request was made to be
able to check the version without actually executing the file. Given
that the majority of versions has the same first two digits this
becomes fairly useless without the patchlevel digit. So it would be
preferable to try to maintain all three digits. The following should
do this:

GIT_VERSION=1.9.rc0
all:
    echo $(join -DMAJOR= -DMINOR= -DPATCH=, \
        $(wordlist 1,3,$(filter-out rc%,$(subst -, ,$(subst .,
,$(GIT_VERSION)))) 0 0))

This removes any rc* parts and appends a couple of zeros so that all
missing elements should appear as 0 in the final list.

Pat Thoyts

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
