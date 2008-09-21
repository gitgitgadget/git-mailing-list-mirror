From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: Git-1.6.0.2-preview20080921 on Windows
Date: Sun, 21 Sep 2008 22:19:59 +0400
Message-ID: <bb6f213e0809211119t3c2bc6e8x3342bd33bef38916@mail.gmail.com>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
Reply-To: ANGavrilov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Sep 21 20:21:14 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.242])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhTYW-0006Z5-9k
	for gcvm-msysgit@m.gmane.org; Sun, 21 Sep 2008 20:21:12 +0200
Received: by wa-out-0708.google.com with SMTP id n36so3069832wag.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 21 Sep 2008 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Zk+g/t7OprhbnXYtIeTl2liVS1aXnyweZRL0rw0PFa8=;
        b=lcRMwACe/3PRczSYA6eZJrh/WdvW9HPbWWFnX/AZh/JGKLmVhoVPdnmMVJnhk9jN2I
         LEXaEnO1BpXjfnTWJIqipHWIgyrF/g/cehGUGSgc0rSATCLQdY3035vqrzrwViZHpUSZ
         9vIOE+DLiuEl7xN/F0e/nfD8HuyzUHz4slX64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:references:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=y21Viam8pBZstl4oDyzXfSqVemUw7ddNZRgMdc71PWbqSw3/+JV53rjR+maAtA6nWs
         +TBv6Wx0Ppbtssn7Z+NR2cGCNNSvvg3R/wmHzoQ8cf+1CyQIwMjTkX2S+NXP8lS2Djiu
         iEFfYwVQs93mWMXjImMgt/H1aEkI5xoSaYpyI=
Received: by 10.141.175.5 with SMTP id c5mr154841rvp.22.1222021201335;
        Sun, 21 Sep 2008 11:20:01 -0700 (PDT)
Received: by 10.107.67.19 with SMTP id u19gr2943prk.0;
	Sun, 21 Sep 2008 11:20:01 -0700 (PDT)
X-Sender: angavrilov@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.151.100.17 with SMTP id c17mr3489700ybm.21.1222021200844; Sun, 21 Sep 2008 11:20:00 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152]) by mx.google.com with ESMTP id 39si6468043yxd.2.2008.09.21.11.19.59; Sun, 21 Sep 2008 11:20:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.152 as permitted sender) client-ip=72.14.220.152;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.152 as permitted sender) smtp.mail=angavrilov@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id d23so1522262fga.14 for <msysgit@googlegroups.com>; Sun, 21 Sep 2008 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=DTCYA/VuSKrtk09/8laAwUZSbvJb2PpDLNxdbPwH7cI=; b=t6KuvieofFa/GJH9TeX3iDFnkekpQXXAx57z6H1BZ5E2LyvWClsKhoJI8/p5Lrz1YM V1zHa9JwT7wEl5endtz4MioAwPXiadfHYni35TTSZJuKsEl4z66DUyZILXr/zFcGmOyw F932ltQUNdDLQvvTJ6Hygf2ZZzsMVcEQ5xRAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=Set7BrPYC9ZkaoGlPs9J1plxcoPi3WNhSteM3gMNe2g2M7e1tLPj1iS6qJ5p5+9Ugs lJ+0lb8rMU1kz4YodQCLgmy50eG4Xc2DNaEyIlmkWIMvHQOwcHnybWSHVRrvdAxUW/RE H3B7yhYskFbQNIMqhssWwWUcHVMLlWeR0krAU=
Received: by 10.103.243.9 with SMTP id v9mr2028642mur.44.1222021199083; Sun, 21 Sep 2008 11:19:59 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Sun, 21 Sep 2008 11:19:59 -0700 (PDT)
In-Reply-To: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96418>


On Sun, Sep 21, 2008 at 9:30 PM, Steffen Prohaska <prohaska@zib.de> wrote:
> Git-1.6.0.2-preview20080921 for Windows is available at
>
>    http://code.google.com/p/msysgit/downloads
>
> The version installed is based on Junio's current 'maint' (cc185a6a8a)
> plus the patch series I sent today, see
>
>   http://article.gmane.org/gmane.comp.version-control.git/92605
>
> The new installer is not yet featured on the msysgit homepage, because
> the installer contains the new "libexec/git-core" layout, which has not
> been tested much.  I'll wait a few days to see if the new layout works.
> If hear nothing bad, I'll move the "Featured" flag to 1.6.0.2.

You forgot to merge my build of the Cygwin kill utility for MSys.
Available here:

http://repo.or.cz/w/msysgit.git?a=log;h=refs/heads/mob


Also, when I start git-gui from an empty repository, or try to amend
the root commit, I get:


Assertion failed: argv0_path, file exec_cmd.c, line 15

This application has requested the Runtime to terminate it in an unusual way.
Please contact the application's support team for more information.
Assertion failed: argv0_path, file exec_cmd.c, line 15

This application has requested the Runtime to terminate it in an unusual way.
Please contact the application's support team for more information.
    while executing
"exec {C:/Program Files/Git/libexec/git-core/git-mktree.exe} << {}"
    ("eval" body line 1)
    invoked from within
"eval exec $opt $cmdp $args"
    (procedure "git" line 23)
    invoked from within
"git mktree << {}"
    (procedure "PARENT" line 9)
    invoked from within
"PARENT"
    (procedure "rescan_stage2" line 25)
    invoked from within
"rescan_stage2 filebf7840 ui_ready"


I get the same error if I simply run 'git mktree' as well.

Alexander
