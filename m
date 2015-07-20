From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/16] engine.pl: ignore invalidcontinue.obj
 which is known to MSVC
Date: Sun, 19 Jul 2015 21:54:45 -0400
Message-ID: <CAPig+cRYPVg-YOvUvH=7QViDRChG1Lvwt84-3z8ERjBMVdrvnw@mail.gmail.com>
References: <1437336497-4072-1-git-send-email-philipoakley@iee.org>
	<1437336497-4072-9-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	MsysGit List <msysgit@googlegroups.com>, Yue Lin Ho <b8732003@student.nsysu.edu.tw>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBD2JJCMYYEGBBZNJWGWQKGQE6CADBWQ@googlegroups.com Mon Jul 20 03:54:48 2015
Return-path: <msysgit+bncBD2JJCMYYEGBBZNJWGWQKGQE6CADBWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oi0-f64.google.com ([209.85.218.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD2JJCMYYEGBBZNJWGWQKGQE6CADBWQ@googlegroups.com>)
	id 1ZH0I3-0008RS-Iq
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jul 2015 03:54:47 +0200
Received: by oihq81 with SMTP id q81sf54435321oih.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 19 Jul 2015 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=VDtLbYu74qtSng07JMDpMmPKFG/M3Mt9DMVLnmML6X4=;
        b=VuA0gewkk+ToThdlfDTVmP2Lh8B87gwF+aBLQYAsYuIshPUOTKWh5gnkzabKiDy/F0
         WZhjPJ83DBCAiZSzhW/Mdolh9PbYf+f3XozmscbdGCVR7TkS5kVFNEzlv30YDmJ31M83
         +YVASeED7IN4bxesX+DO9llusetZRnFSd/EuJL3oQztzXMcOvP5qAlj1hLNNVQn+zs75
         RDL4enRx1wvtzMybQmvbN83qIygv8ONqEBgpYE3FErfYup1Z20rBIXqjSXfe4TT6psIF
         0ZSbLTfFuyHypmWx52Lo/Xef+Ubc3++SZGMtcotP2EwlVXlpvUO3SQpMZWKlFAaaglk4
         hHPA==
X-Received: by 10.50.25.199 with SMTP id e7mr119527igg.16.1437357286167;
        Sun, 19 Jul 2015 18:54:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.142.2 with SMTP id rs2ls1071328igb.26.canary; Sun, 19 Jul
 2015 18:54:45 -0700 (PDT)
X-Received: by 10.66.184.132 with SMTP id eu4mr19746447pac.15.1437357285572;
        Sun, 19 Jul 2015 18:54:45 -0700 (PDT)
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com. [2607:f8b0:4002:c07::22c])
        by gmr-mx.google.com with ESMTPS id s127si1728668ywc.6.2015.07.19.18.54.45
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2015 18:54:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::22c as permitted sender) client-ip=2607:f8b0:4002:c07::22c;
Received: by mail-yk0-x22c.google.com with SMTP id u72so129043460ykd.2
        for <msysgit@googlegroups.com>; Sun, 19 Jul 2015 18:54:45 -0700 (PDT)
X-Received: by 10.13.207.1 with SMTP id r1mr26234934ywd.166.1437357285460;
 Sun, 19 Jul 2015 18:54:45 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.37.12.129 with HTTP; Sun, 19 Jul 2015 18:54:45 -0700 (PDT)
In-Reply-To: <1437336497-4072-9-git-send-email-philipoakley@iee.org>
X-Original-Sender: sunshine@sunshineco.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of ericsunshine@gmail.com designates 2607:f8b0:4002:c07::22c
 as permitted sender) smtp.mail=ericsunshine@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274304>

On Sun, Jul 19, 2015 at 4:08 PM, Philip Oakley <philipoakley@iee.org> wrote:
> Commit 4b623d8 (MSVC: link in invalidcontinue.obj for better
> POSIX compatibility, 2014-03-29) is not processed correctly
> by the buildsystem. Ignore it.

What does "not processed correctly" mean? For a person reading the
commit message, but lacking your experience with this, "not processed
correctly" seems akin to "it doesn't work"[1]. Can the commit message
provide a bit more detail?

[1]: http://www.chiark.greenend.org.uk/~sgtatham/bugs.html

> Also split the .o and .obj processing; 'make' does not produce .obj
> files. Only substitute filenames ending with .o when generating the
> source .c filename.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  contrib/buildsystems/engine.pl | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
> index 60c7a7d..9db3d43 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -289,7 +289,7 @@ sub handleLibLine
>  #    exit(1);
>      foreach (@objfiles) {
>          my $sourcefile = $_;
> -        $sourcefile =~ s/\.o/.c/;
> +        $sourcefile =~ s/\.o$/.c/;
>          push(@sources, $sourcefile);
>          push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
>          push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
> @@ -333,8 +333,12 @@ sub handleLinkLine
>          } elsif ($part =~ /\.(a|lib)$/) {
>              $part =~ s/\.a$/.lib/;
>              push(@libs, $part);
> -        } elsif ($part =~ /\.(o|obj)$/) {
> +        } elsif ($part eq 'invalidcontinue.obj') {
> +            # ignore - known to MSVC
> +        } elsif ($part =~ /\.o$/) {
>              push(@objfiles, $part);
> +        } elsif ($part =~ /\.obj$/) {
> +            # do nothing, 'make' should not be producing .obj, only .o files
>          } else {
>              die "Unhandled link option @ line $lineno: $part";
>          }
> @@ -343,7 +347,7 @@ sub handleLinkLine
>  #    exit(1);
>      foreach (@objfiles) {
>          my $sourcefile = $_;
> -        $sourcefile =~ s/\.o/.c/;
> +        $sourcefile =~ s/\.o$/.c/;
>          push(@sources, $sourcefile);
>          push(@cflags, @{$compile_options{"${sourcefile}_CFLAGS"}});
>          push(@defines, @{$compile_options{"${sourcefile}_DEFINES"}});
> --
> 2.4.2.windows.1.5.gd32afb6

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
