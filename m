From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git clone doesn't work in symlink dir roots on Windows
Date: Sun, 11 Aug 2013 05:04:13 +0200
Message-ID: <CABPQNSaU_69RxNEAAY0=BYdJm0ir_xkOkd2nPaxop7m0aJ9trg@mail.gmail.com>
References: <CABJxLaM9t1HeEVkAiXpOmaOH_V6681w9Q9ZQt37+MpmhX7yN2g@mail.gmail.com>
 <20130810125140.GD25779@paksenarrion.iveqy.com> <CABJxLaOaUYxyAsy5mpciiAObmoazFpwB0T4C20cu3eHuSpEpAg@mail.gmail.com>
 <20130810163459.GE25779@paksenarrion.iveqy.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sedat Kapanoglu <sedat@eksiteknoloji.com>, git@vger.kernel.org, msysgit@googlegroups.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: msysgit+bncBDR53PPJ7YHRBVX6TOIAKGQEN6M27LQ@googlegroups.com Sun Aug 11 05:04:58 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBVX6TOIAKGQEN6M27LQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f191.google.com ([209.85.128.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBVX6TOIAKGQEN6M27LQ@googlegroups.com>)
	id 1V8Lxg-00049I-HN
	for gcvm-msysgit@m.gmane.org; Sun, 11 Aug 2013 05:04:56 +0200
Received: by mail-ve0-f191.google.com with SMTP id 15sf1590095vea.28
        for <gcvm-msysgit@m.gmane.org>; Sat, 10 Aug 2013 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=mGMG6eZnf1Ln6fNl0E7JPAly5A7k9VbONyNrsoHKyhY=;
        b=W/vCvKXwH27j/w4yvS9AIArU4BY+irWT++RzzEacwdNqQcwthzbHIgoNUUXb9gU+/u
         WIZAkCnbDDfVgOgBnmtdRgVqmFYiNAEvstNaWeJZGd70rqqgdzgcM97VGJcHZ/jbXVMS
         tOScJmxQdG88X5weVFTqS4r2QHPch96N3d7fESWLAtwqizC2lwg+EogxzLQ/nyo4f7h4
         Q98LQYQEfByGEZvu5BPjFqJYfQ3ToR71lOsIPkMLw/4gen7xfUlmrCL9bDlKUYG2v52/
         /wO7XvfA6P3/tOxZaYy8dduz6m9gQ4Biri8FYXU8zZg2leYRgJ/5yS12rzkqsQYuf++v
         X0Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=mGMG6eZnf1Ln6fNl0E7JPAly5A7k9VbONyNrsoHKyhY=;
        b=VDxSLfYm9kQVcR7mkKeCITfJJinAcOzWTweF+gB7yNKqbJF6Yg0+V5/d4NNhynXxEK
         on40cVoyk4fatyiVpI8jWMThNxWVhhmEXUgwksL7d2nIm3wWArdE6fppJTmtz8FT9wKM
         juLYI9YeLfnZLp+cVAVDVnCvhIfYLbqX+zl/lr8w+6uE10AVLZYESoSw2+BQUxsSFNKn
         1MdrPitjhb4avMzotEUhYaO9hVUGiqewEXzGdID23IQcvek78iRAlrpP3qdJC6R0zSi6
         yhSwBese8IRgWkdXg/IxiBClIuunWjqGDPMlDw37FTZOPW1vSPX3Eqy53ZpAQzs6D7b4
         IZMg==
X-Received: by 10.50.9.33 with SMTP id w1mr477986iga.12.1376190294890;
        Sat, 10 Aug 2013 20:04:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.176.131 with SMTP id ci3ls1769682igc.27.canary; Sat, 10 Aug
 2013 20:04:54 -0700 (PDT)
X-Received: by 10.43.60.11 with SMTP id wq11mr12309191icb.27.1376190294160;
        Sat, 10 Aug 2013 20:04:54 -0700 (PDT)
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com [2607:f8b0:4003:c01::22c])
        by gmr-mx.google.com with ESMTPS id r4si1143049ign.3.2013.08.10.20.04.54
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 20:04:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4003:c01::22c as permitted sender) client-ip=2607:f8b0:4003:c01::22c;
Received: by mail-ob0-f172.google.com with SMTP id er7so7752785obc.17
        for <msysgit@googlegroups.com>; Sat, 10 Aug 2013 20:04:53 -0700 (PDT)
X-Received: by 10.60.132.84 with SMTP id os20mr6124265oeb.94.1376190293784;
 Sat, 10 Aug 2013 20:04:53 -0700 (PDT)
Received: by 10.76.22.79 with HTTP; Sat, 10 Aug 2013 20:04:13 -0700 (PDT)
In-Reply-To: <20130810163459.GE25779@paksenarrion.iveqy.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4003:c01::22c
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) d=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232118>

On Sat, Aug 10, 2013 at 6:34 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sat, Aug 10, 2013 at 07:22:03PM +0300, Sedat Kapanoglu wrote:
>> > git is a disk intense program, so this setup is not sane at all. With
>> > that said I know that git on windows historically had problems with
>> > working on smb-mounted shares (sometimes you're forced to have stupid
>> > setups). I doubt that git really is the right tool for your work, since
>>
>> I reproduced the same problem in a regular symlink directory. Repro steps:
>>
>> mkdir actualdir
>> mklink /d symdir actualdir
>> cd symdir
>> git init .
>>
>> fatal: Invalid symlink 'D:/gitto': Function not implemented
>>
>> Thanks,
>>
>> Sedat
>
> Good, then we can determinate that this is a symlink error, it seams
> that readlink() isn't implemented in the msysgit version of msysgit.
>
> However msysgit should have a implementation of readlink() according to:
> http://mingw.5.n7.nabble.com/Replacement-for-readlink-td30679.html
>
> I've CC:ed the msysgit-maillist so that they can decide if this is
> something they want to address in newer releases.

No, we do not. (I won't be bothered to read *yet* another thread about
someone who thinks they know how symlinks should work on Windows, so
I'll assume it's the Cygwin-take... which is the most senseful IMO)
Symlinks in Cygwin are generally not compatible with native Windows
applications.

And Windows symlinks are not at all compatible with POSIX-symlinks. At all.

Whoever wants symlink support in Git for Windows have clearly not
considered how this would work (or more likely, break). It's an idea
built on misunderstanding and poor engineering-concepts.

There's no way we can support symlinks in a clean, Windows specific
way. So let's not even pretend it works.

That being said, we could probably error out in a more senseful way.
But if so,suggestions/patches welcome.

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
