From: "Philip Oakley" <philipoakley-7KbaBNvhQFM@public.gmane.org>
Subject: Re: Cannot set the commit-message editor
Date: Fri, 21 Nov 2014 17:48:20 -0000
Organization: OPDS
Message-ID: <F248C92A32904678A4E8E158A3518AA3@PhilipOakley>
References: <CAOmRNZ4uJEoxroyCRUSDwSC3OAMKTSO0s91_uFDaUit3k8eJLg@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Git Users" <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "Fahad Ashfaque" <fahadash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: git-users+bncBDSOTWHYX4PBBZXVXWRQKGQEVASLHUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Nov 21 18:48:26 2014
Return-path: <git-users+bncBDSOTWHYX4PBBZXVXWRQKGQEVASLHUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-la0-f60.google.com ([209.85.215.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDSOTWHYX4PBBZXVXWRQKGQEVASLHUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1XrsJm-000168-3U
	for gcggu-git-users@m.gmane.org; Fri, 21 Nov 2014 18:48:26 +0100
Received: by mail-la0-f60.google.com with SMTP id pv20sf462937lab.5
        for <gcggu-git-users@m.gmane.org>; Fri, 21 Nov 2014 09:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=9FdRVuAOY5qZiJbdXOruBFFCne/jckT/TMDQvM2aXTQ=;
        b=GoPOyaExqg2ok0pouQBWTJ3oRnyaApS3Ewc7A0iCcB9oNpIAJltAs/KU6Pypr5vEtL
         0LphrMDewTnCthHrk2odA3Z+NVqJLygi60lIQ32DYwp4XrPHlhaZy1UC5DqkDRMETxHU
         5DOatVkURNvn92uSjEZStnQXFvljKuwfUP3kNDT2x+Bjw/FqnBkiBgFrGitQJ95kJOLn
         eBqQ1IBKfRx5PI7dya9r+ufWbh8aJdg8cbDiN3RJ9sVjmvtCm7md+B/3GjUTWYANLlYI
         2YRvJhR1CuHfYoyJuul4rkMHcwDoa/Oxc79TwVY30/B90pTwP3ybUoCNIS4mvF9HJ6/h
         bBfw==
X-Received: by 10.152.36.135 with SMTP id q7mr17390laj.29.1416592105953;
        Fri, 21 Nov 2014 09:48:25 -0800 (PST)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.152.19.98 with SMTP id d2ls236162lae.19.gmail; Fri, 21 Nov
 2014 09:48:21 -0800 (PST)
X-Received: by 10.112.89.195 with SMTP id bq3mr1987702lbb.9.1416592101552;
        Fri, 21 Nov 2014 09:48:21 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id l9si268620wix.1.2014.11.21.09.48.19
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>;
        Fri, 21 Nov 2014 09:48:19 -0800 (PST)
Received-SPF: temperror (google.com: error in processing during lookup of philipoakley-7KbaBNvhQFM@public.gmane.org: DNS timeout) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnMPALZ5b1RZ8YpUPGdsb2JhbABcgw5VWYMGhAOBBMNTh0sEAoEEFwEBAQEBAQUBAQEBOCAbg30FAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVBQIFIQICFAEECBIGBwMGAQ0GARIIAgECAwGIGwMJDbZBhn+JEg2GTwwggS2NIB2CHoJ+NoEeBZJXZ4N3hRiDR4NViDuCQoJtiAQ9MIJLAQEB
X-IPAS-Result: AnMPALZ5b1RZ8YpUPGdsb2JhbABcgw5VWYMGhAOBBMNTh0sEAoEEFwEBAQEBAQUBAQEBOCAbg30FAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVBQIFIQICFAEECBIGBwMGAQ0GARIIAgECAwGIGwMJDbZBhn+JEg2GTwwggS2NIB2CHoJ+NoEeBZJXZ4N3hRiDR4NViDuCQoJtiAQ9MIJLAQEB
X-IronPort-AV: E=Sophos;i="5.07,432,1413241200"; 
   d="scan'208";a="16958670"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip02ir2.opaltelecom.net with SMTP; 21 Nov 2014 17:48:19 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley-7KbaBNvhQFM@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=temperror
 (google.com: error in processing during lookup of philipoakley-7KbaBNvhQFM@public.gmane.org: DNS
 timeout) smtp.mail=philipoakley-7KbaBNvhQFM@public.gmane.org
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/git-users/subscribe>

From: "Fahad Ashfaque" <fahadash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>I have downloaded the latest git from git-scm on my windows machine.
>
> I am using git on windows, I am having trouble trying to get notepad++
> as my commit message editor.
>
> I have created a shell script called npp.sh which has the following 
> content
>
> /c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe -multiInst
> -nosession -noPlugin $1
>
>
> I figured this is how paths are accepted in git-bash
>
> Now I configured core.editor this way
>
> git config --global core.editor /c/path/to/npp.sh
>

I simply have (from 'git config -l'):
core.editor='C:/Program 
Files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noplugin

>
> when I try to commit, using the following command
>
> git commit
>
> I get the following error
> $ git commit
> error: cannot spawn c:/path/to/npp.sh: No such file or directory
> error: unable to start editor 'c:/dev/tools/cmd/npp.sh'
> Please supply the message using either -m or -F option.
>
> when I run the following command
>
> ls c:/
>
> I get the directory for my repository's root, not C drive's root
>
> When I run the following command through git-bash
>
> /c/path/to/npp.sh
>
> It works
>
> but when git commit invokes, it does not.
>
> Here is more of what I found
>
> when 'git commit' launches npp.sh, it changes /c/path/to/npp.sh to
> c:/path/to/npp.sh
>
> c:/ is not the root of my C drive according to git-bash,
Correct. The "Linux" bash is rooted, _usually_, at the base of your 
personal 'c:/documents and settings' (or whatever on your Windows 
version), with the MS drives under /c/ and /d/ etc. i.e. a load of 
virtualisation.

use 'pwd -W' to get the true (Windows) path of your current/present 
working directory. (I had to ask just a few days ago ;-)

> c:/ is root
> of my repository because when I run 'ls c:/' I get files from root of
> my repository.
I wouldn't have expected that to play nice (confusion between windows 
and linux path styles).

>
> so may be if 'git commit' does not change /c/path/to/npp.sh to
> c:/path/to/npp.sh, it would work... Or if git-bash does not mount c:/
> to /c/path/to/myrepository and keep it to /c it would work too.
>
> Please let me know if you need more info on this

I've also copied in the Git user / Git for Human beings list (for 
reference) which can be useful for Windows based issues.

>
> Thanks
>
> Fahad
> --

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
