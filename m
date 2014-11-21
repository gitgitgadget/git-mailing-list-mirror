From: "Philip Oakley" <philipoakley-7KbaBNvhQFM@public.gmane.org>
Subject: Re: Cannot set the commit-message editor
Date: Fri, 21 Nov 2014 21:14:39 -0000
Organization: OPDS
Message-ID: <ADA906CC4DD040DF9F1F2DFA9EEF69BF@PhilipOakley>
References: <CAOmRNZ4uJEoxroyCRUSDwSC3OAMKTSO0s91_uFDaUit3k8eJLg@mail.gmail.com><F248C92A32904678A4E8E158A3518AA3@PhilipOakley> <CAOmRNZ5PGWNM_+c_G_3ZfBnYqXTM-5WRBpK_z7Px6Jkae+CvRw@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Git Users" <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: "Fahad Ashfaque" <fahadash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDSOTWHYX4PBBGGWX2RQKGQEVIZ2B6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Nov 21 22:14:04 2014
Return-path: <git-users+bncBDSOTWHYX4PBBGGWX2RQKGQEVIZ2B6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ee0-f60.google.com ([74.125.83.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDSOTWHYX4PBBGGWX2RQKGQEVIZ2B6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1XrvWm-0000rY-6v
	for gcggu-git-users@m.gmane.org; Fri, 21 Nov 2014 22:14:04 +0100
Received: by mail-ee0-f60.google.com with SMTP id c13sf549382eek.25
        for <gcggu-git-users@m.gmane.org>; Fri, 21 Nov 2014 13:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=u4H8usMT+23T0YOJdt1f7m5tFBwPilkWsbd8DWU3Grg=;
        b=vijP8Ke6jYaDwI00A8iV7LbeBk5bxnKSJT6hJCq2he/1jx62gVCsxv/juQQQNLzx6+
         jmJWQ/8ikegrPP4v9xh5GrCJk/zzFtTy++/SdNxJBzw0AGYqJzGwjjZMGs+pK23zNf1w
         XyIvCEpiQuCPjAhQYpbaE344EsxwoYh1NWTOo2LF2FOroJrHSHIK2Kl3iuR7TrMGG1rs
         szKa6RfC2aECNXrkwTqjTCRr2aMC5OsDNXpx2WsPGPdqWOIeGPsulm6RN7OsMEf4KPse
         vaLTn3Q9qZdTYiwxKzbbTjYyKSWNqmPojDfU0I52jW1xX63PUjrqQRS/Z57GG+wGswEr
         Y9Pg==
X-Received: by 10.152.36.135 with SMTP id q7mr28319laj.29.1416604444022;
        Fri, 21 Nov 2014 13:14:04 -0800 (PST)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.152.22.130 with SMTP id d2ls271538laf.32.gmail; Fri, 21 Nov
 2014 13:14:00 -0800 (PST)
X-Received: by 10.112.147.131 with SMTP id tk3mr2234056lbb.2.1416604440131;
        Fri, 21 Nov 2014 13:14:00 -0800 (PST)
Received: from out1.ip03ir2.opaltelecom.net (out1.ip03ir2.opaltelecom.net. [62.24.128.239])
        by gmr-mx.google.com with ESMTP id el8si28746wib.3.2014.11.21.13.13.59
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>;
        Fri, 21 Nov 2014 13:14:00 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley-7KbaBNvhQFM@public.gmane.org does not designate 62.24.128.239 as permitted sender) client-ip=62.24.128.239;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusQAKmqb1RZ8YpUPGdsb2JhbABcgw5VWYMGhQfDaR0KhhZPAQMBAYEGFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEZFRYIAQEhBQYCAwUCAQMVAwICBSECAhQBBAgQAgYHAwYBDQYICwgCAQIDAQwEiAsDCQ0JtmeGfolADYZCDAEfgS2NIYI9gwA2gR8FhS8CjTNrg3qFHYNIP4MaiEqCQ4JwiAZIMAGCSgEBAQ
X-IPAS-Result: AusQAKmqb1RZ8YpUPGdsb2JhbABcgw5VWYMGhQfDaR0KhhZPAQMBAYEGFwEBAQEBAQUBAQEBODuDfQUBAQEBAgEIAQEZFRYIAQEhBQYCAwUCAQMVAwICBSECAhQBBAgQAgYHAwYBDQYICwgCAQIDAQwEiAsDCQ0JtmeGfolADYZCDAEfgS2NIYI9gwA2gR8FhS8CjTNrg3qFHYNIP4MaiEqCQ4JwiAZIMAGCSgEBAQ
X-IronPort-AV: E=Sophos;i="5.07,432,1413241200"; 
   d="scan'208";a="533208314"
Received: from host-89-241-138-84.as13285.net (HELO PhilipOakley) ([89.241.138.84])
  by out1.ip03ir2.opaltelecom.net with SMTP; 21 Nov 2014 21:13:39 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley-7KbaBNvhQFM@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley-7KbaBNvhQFM@public.gmane.org does not designate
 62.24.128.239 as permitted sender) smtp.mail=philipoakley-7KbaBNvhQFM@public.gmane.org
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
> still don't get it.
>

Do check each instance of bash separately. Each can have a different 
virtual root.

I was caught by this just last week on Msysgit (the msys.bat) where that 
has a different base address to the Git bash version in "C:\program 
files".
https://groups.google.com/d/msg/msysgit/prLaAOCF9Ig/l1zRsYfVrqwJ

> I run /c/path/to/npp.sh just fine,.... Its only 'git commit' that is
> teleporting me to a different world. So there is NO way I can refer to
> folders outside of my repository in a shell script when it is used in
> a config param ?
>
> I will try setting the core.editor to the value you suggested.
>
> On Fri, Nov 21, 2014 at 12:48 PM, Philip Oakley <philipoakley-7KbaBNvhQFM@public.gmane.org> 
> wrote:
>> From: "Fahad Ashfaque" <fahadash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> I have downloaded the latest git from git-scm on my windows machine.
>>>
>>> I am using git on windows, I am having trouble trying to get 
>>> notepad++
>>> as my commit message editor.
>>>
>>> I have created a shell script called npp.sh which has the following
>>> content
>>>
>>> /c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe -multiInst
>>> -nosession -noPlugin $1
>>>
>>>
>>> I figured this is how paths are accepted in git-bash
>>>
>>> Now I configured core.editor this way
>>>
>>> git config --global core.editor /c/path/to/npp.sh
>>>
>>
>> I simply have (from 'git config -l'):
>> core.editor='C:/Program 
>> Files/Notepad++/notepad++.exe' -multiInst -notabbar
>> -nosession -noplugin
>>
>>>
>>> when I try to commit, using the following command
>>>
>>> git commit
>>>
>>> I get the following error
>>> $ git commit
>>> error: cannot spawn c:/path/to/npp.sh: No such file or directory
>>> error: unable to start editor 'c:/dev/tools/cmd/npp.sh'
>>> Please supply the message using either -m or -F option.
>>>
>>> when I run the following command
>>>
>>> ls c:/
>>>
>>> I get the directory for my repository's root, not C drive's root
>>>
>>> When I run the following command through git-bash
>>>
>>> /c/path/to/npp.sh
>>>
>>> It works
>>>
>>> but when git commit invokes, it does not.
>>>
>>> Here is more of what I found
>>>
>>> when 'git commit' launches npp.sh, it changes /c/path/to/npp.sh to
>>> c:/path/to/npp.sh
>>>
>>> c:/ is not the root of my C drive according to git-bash,
>>
>> Correct. The "Linux" bash is rooted, _usually_, at the base of your 
>> personal
>> 'c:/documents and settings' (or whatever on your Windows version), 
>> with the
>> MS drives under /c/ and /d/ etc. i.e. a load of virtualisation.
>>
>> use 'pwd -W' to get the true (Windows) path of your current/present 
>> working
>> directory. (I had to ask just a few days ago ;-)
>>
>>> c:/ is root
>>> of my repository because when I run 'ls c:/' I get files from root 
>>> of
>>> my repository.
>>
>> I wouldn't have expected that to play nice (confusion between windows 
>> and
>> linux path styles).
>>
>>>
>>> so may be if 'git commit' does not change /c/path/to/npp.sh to
>>> c:/path/to/npp.sh, it would work... Or if git-bash does not mount 
>>> c:/
>>> to /c/path/to/myrepository and keep it to /c it would work too.
>>>
>>> Please let me know if you need more info on this
>>
>>
>> I've also copied in the Git user / Git for Human beings list (for 
>> reference)
>> which can be useful for Windows based issues.
>>
>>>
>>> Thanks
>>>
>>> Fahad
>>> --
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
