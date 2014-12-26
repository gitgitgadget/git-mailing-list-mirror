From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/5] Fix the Visual Studio 2008 .sln generator
Date: Fri, 26 Dec 2014 14:25:40 -0000
Organization: OPDS
Message-ID: <9B2F64A2564241B59450227A41A0ACD6@PhilipOakley>
References: <1419418034-6276-1-git-send-email-philipoakley@iee.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Marius Storm-Olsen" <mstormo@gmail.com>,
	"Ramsay Jones" <ramsay@ramsay1.demon.co.uk>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Msysgit" <msysgit@googlegroups.com>
To: "GitList" <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBLG76WSAKGQEW4MSHCQ@googlegroups.com Fri Dec 26 15:24:47 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBLG76WSAKGQEW4MSHCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f61.google.com ([74.125.83.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBLG76WSAKGQEW4MSHCQ@googlegroups.com>)
	id 1Y4Vos-0002nT-Fl
	for gcvm-msysgit@m.gmane.org; Fri, 26 Dec 2014 15:24:46 +0100
Received: by mail-ee0-f61.google.com with SMTP id d17sf1071373eek.16
        for <gcvm-msysgit@m.gmane.org>; Fri, 26 Dec 2014 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=LJnnzu1ZK/4nOCX3gohTWpuQNuxwytqLQXDJqaUV7rA=;
        b=a32GZ1mQlGDUJt3TxI4mP3U5YvibxQd5MOpb/K0t7h3tmjVNZsoL5CVP4mW3ieuVaq
         hN2DoOhORCwp/pj3KyF8OkG9OqhZ+rz2wJKb0jTfNUT6X4aq5YRefclz9TcF70CPsfy4
         xjzGufmeW0c9AgQpC402eJjxcaHaaqhsmIsp8dNHO16xuAePiIVP2/QXtBW/TX1rhO2j
         SGRHZQcS25nSTt2bHzu9qDfSOH0Dm0LQhrrfRDS4UlFEwY66gwMDpXuCkbme0DNHtReC
         87Da4xbyKdwr/ls3tIZfnfHH2MmL5ncsDNYCXrghRYn0a5cYczdQ8aHQtHQVOv4RDMLI
         RIgw==
X-Received: by 10.152.42.135 with SMTP id o7mr150lal.37.1419603885990;
        Fri, 26 Dec 2014 06:24:45 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.7.100 with SMTP id i4ls1434150laa.106.gmail; Fri, 26 Dec
 2014 06:24:44 -0800 (PST)
X-Received: by 10.112.99.37 with SMTP id en5mr6937lbb.17.1419603884204;
        Fri, 26 Dec 2014 06:24:44 -0800 (PST)
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net. [62.24.128.240])
        by gmr-mx.google.com with ESMTP id f6si1473759wiv.0.2014.12.26.06.24.44
        for <msysgit@googlegroups.com>;
        Fri, 26 Dec 2014 06:24:44 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.240 as permitted sender) client-ip=62.24.128.240;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqISAKBunVQCYJmQPGdsb2JhbABcgwZSWIcbv1OFawQCgQsXAQEBAQEBBQEBAQE4IBuEBwUBAQEBAgEIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDBgENBhMIAgECAwGIEwwJukWOQAELAR+Pd4MdgRMFhC0ChHKEdE2CcoZxkBOEED4xAQEBgkABAQE
X-IPAS-Result: AqISAKBunVQCYJmQPGdsb2JhbABcgwZSWIcbv1OFawQCgQsXAQEBAQEBBQEBAQE4IBuEBwUBAQEBAgEIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcDBgENBhMIAgECAwGIEwwJukWOQAELAR+Pd4MdgRMFhC0ChHKEdE2CcoZxkBOEED4xAQEBgkABAQE
X-IronPort-AV: E=Sophos;i="5.07,647,1413241200"; 
   d="scan'208";a="480578206"
Received: from host-2-96-153-144.as13285.net (HELO PhilipOakley) ([2.96.153.144])
  by out1.ip04ir2.opaltelecom.net with SMTP; 26 Dec 2014 14:24:43 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.240 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261828>

From: "Philip Oakley" <philipoakley@iee.org>
> Potential Windows developers are likely to be using Visual Studio as
> their IDE. The tool stack required for Windows can be tortuous as it
> crosses the boundaries between platforms and philosophies. This patch
> series seeks to maintain the tools that could assist such developers.
> In particular, those tools that generate an initial Visual Studio
> project (.sln ) file.
>
> The .sln generator in contrib began to break when internationalisation
> introduced an extra -o option. This recently worsened with the 
> addition
> of invalidcontinue.obj for 'improved POSIX compatibility'.
>
> I hacked a bit when I first attempted to use the VS IDE and noticed 
> the
> i18n issue. I didn't completely solve all my issues because of further
> issues with VS2010 Express, so no patches were submitted at the time.
>
> Now, with a fresh copy of VS20008 Express, I saw the additional 
> problem
> of the addition of the invalidcontinue.obj reference causing the .sln
> generation to fail.
>
> The series has been tested against both recent git/git and 
> msysgit/git.
> Both produce good VS2008 .sln project files though only msysgit/git
> compiles without error, both using the msysgit msvc-build script.
> Those compile errors are not related to this patch series.

Now, having tried using the VS project output for some follow on work, 
I've found that the resultant .sln file is incomplete, though does 
compile fine as noted.

Investigation has shown that the 'failure' to provide a complete Git 
project would apper to have begun somewhere between v1.7.9 and v1.8.0. 
V1.7.9 has 'git', while v1.8.0 doesn't (along with other missing 
artefacts).

Looks like firther fixes are needed once the cause is determined.

>
> An initial RFC version was discussed on the msysgit list
> https://groups.google.com/forum/#!topic/msysgit/3MQ_NMNM390 or
> http://thread.gmane.org/gmane.comp.version-control.msysgit/21132.
>
> The final patch adds a poorman's --verbose by a few carefully selected
> commented out debug print statements to assist others in resolving
> future breakages.
>
> I've cc'd those who have contributed or patched the engine.pl, or
> appear to be interested via a $gmane search, who can hopefully 
> comment.
>
>
> Philip Oakley (5):
>  engine.pl: Fix i18n -o option in msvc buildsystem generator
>  engine.pl: Properly accept quoted spaces in filenames
>  engine.pl: ignore invalidcontinue.obj which is known to MSVC
>  vcbuild/readme: Improve layout and reference msvc-build script
>  engine.pl: provide more debug print statements
>
> compat/vcbuild/README          | 27 +++++++++++++++++++--------
> contrib/buildsystems/engine.pl | 27 +++++++++++++++++++++------
> 2 files changed, 40 insertions(+), 14 deletions(-)
>
> -- 

Philip 

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
