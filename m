From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: relative objects/info/alternates doesn't work on remote
 SMB repo
Date: Tue, 30 Oct 2012 11:28:52 +0200
Message-ID: <CAGHpTB+o4gHfgFgLqie_hbjzWjxL94xRQi11GwS9F-Qhik0qVA@mail.gmail.com>
References: <CAGHpTBKNurqd0xcz9A9bC8MQU8yHfef0ozJ2Khr9uQvwHoyP2g@mail.gmail.com>
	<CACsJy8BSpX7UxAEhZTqNnazAtSMp7oZtyxiBdnVoCXefWpTDEw@mail.gmail.com>
	<CAGHpTB+TbrQLw7E+RpP8y0euYrLNOC6-sic-4x3pbxcAborFLQ@mail.gmail.com>
	<CACsJy8B3=33FE-SbOD6Su4v_DbyuYsxfh-DxAzbJbJa5B2pyLg@mail.gmail.com>
	<CAGHpTBLbPvkEGqh5PGbtNS0MKY5YutaQpx3D_Fv5oSWeR52K9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: msysgit+bncBCBOVJV7VMPRBVN3X2CAKGQEXYIBUQI@googlegroups.com Tue Oct 30 10:29:05 2012
Return-path: <msysgit+bncBCBOVJV7VMPRBVN3X2CAKGQEXYIBUQI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f58.google.com ([209.85.220.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCBOVJV7VMPRBVN3X2CAKGQEXYIBUQI@googlegroups.com>)
	id 1TT887-0007U6-AH
	for gcvm-msysgit@m.gmane.org; Tue, 30 Oct 2012 10:29:03 +0100
Received: by mail-pa0-f58.google.com with SMTP id fb11sf39297pad.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Oct 2012 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=vCGbSAvp2lqj6hob5fHia6Y5JNNy3bR0Ac/uKcNWMF0=;
        b=dWtw3ce0ihgJSwg6HVF3OIH5GzRv3SzAyTivZjlU8FCW4+BiKxmz1Ktau/qfn2KJ9O
         a/IT8TuMjicKyePNxIcvCBXhsJ1hfwnRbj+Yg1bxMOAIw0AFzV844eZTvBbH3ogRDq9d
         GIIgL9tSUytLvWICcJdGSaqf2kinV4jr5z40KxEVFq1i7mx4oCLKM+PIPmrNKbu3O8p7
         CkWJxSd36XpFAzOtuczY9CiNw0JDTZwgZsdEcF592rZGVeta8av7B5XOoxCdsmroyS6a
         mOmFnuy9bNanA9oCsZqpr2qHeR5bHRNkZsB6jLbs/4UAJSTtWRUnmWKMJQkLVcJBWre9
         ryIQ==
Received: by 10.224.188.20 with SMTP id cy20mr4810514qab.10.1351589333614;
        Tue, 30 Oct 2012 02:28:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.77.83 with SMTP id f19ls226696qak.5.gmail; Tue, 30 Oct
 2012 02:28:52 -0700 (PDT)
Received: by 10.224.105.205 with SMTP id u13mr9639145qao.6.1351589332989;
        Tue, 30 Oct 2012 02:28:52 -0700 (PDT)
Received: by 10.224.105.205 with SMTP id u13mr9639144qao.6.1351589332977;
        Tue, 30 Oct 2012 02:28:52 -0700 (PDT)
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com [209.85.216.170])
        by gmr-mx.google.com with ESMTPS id ba11si32358qcb.2.2012.10.30.02.28.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 02:28:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of orgads@gmail.com designates 209.85.216.170 as permitted sender) client-ip=209.85.216.170;
Received: by mail-qc0-f170.google.com with SMTP id d42so27484qca.29
        for <msysgit@googlegroups.com>; Tue, 30 Oct 2012 02:28:52 -0700 (PDT)
Received: by 10.224.186.145 with SMTP id cs17mr18069909qab.91.1351589332812;
 Tue, 30 Oct 2012 02:28:52 -0700 (PDT)
Received: by 10.49.39.130 with HTTP; Tue, 30 Oct 2012 02:28:52 -0700 (PDT)
In-Reply-To: <CAGHpTBLbPvkEGqh5PGbtNS0MKY5YutaQpx3D_Fv5oSWeR52K9A@mail.gmail.com>
X-Original-Sender: orgads@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of orgads@gmail.com designates 209.85.216.170 as permitted sender)
 smtp.mail=orgads@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208687>

On Thu, Aug 30, 2012 at 3:34 PM, Orgad and Raizel Shaneh
<orgads@gmail.com> wrote:
>
> On Thu, Aug 30, 2012 at 4:22 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
> wrote:
> > On Thu, Aug 30, 2012 at 8:12 PM, Orgad and Raizel Shaneh
> > <orgads@gmail.com> wrote:
> >>> Could be path normalization. What does "git rev-parse --git-dir" say?
> >>> Try to run it at top working directory and a subdirectory as well.
> >>>
> >>> If you set GIT_OBJECT_DIRECTORY environment variable to
> >>> //server/share/foo/repo/.git/objects, does it work?
> >>
> >> git rev-parse --git-dir in a subdirectory has //server
> >
> > Hmm where is your git repository? That does not look like a git
> > repository's path.
> >
>
> Let me try to explain again.
> I have /d/share/bare, which is a bare repository, and /d/share/repo
> which is a clone with a relative path to bare/.git/objects in its
> .git/objects/info/alternates
>
> D:\share is configured as a SMB shared folder. It is accessed using
> //server/share.
> I do not clone from this directory, but work directly in it using 'cd
> //server/share', then performing git operations.
>
> >> setting GIT_OBJECT_DIRECTORY prints "fatal: bad object HEAD" on git
> >> status.
> >
> > I guessed you put your repo in .../repo/.git, but I was probably
> > wrong. Try setting again, pointing GIT_OBJECT_DIRECTORY to the
> > "objects" directory inside your repository. I just want to make see if
> > it's because git miscalculates this path. If setting the env variable
> > works, then it probably does.
> > --
> > Duy
>
> Same result. fatal: bad object HEAD. Tried even using a full (local)
> path to the objects dir.
>
> - Orgad

Any news? This still doesn't work with 1.8.0.

- Orgad

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
