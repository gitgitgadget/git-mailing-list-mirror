From: "Alexander Gladysh" <agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Thu, 4 Sep 2008 18:54:21 +0400
Message-ID: <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com> <20080904143723.GB23708@spearce.org>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
X-From: grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu Sep 04 16:55:52 2008
Return-path: <grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-gx0-f62.google.com ([209.85.217.62])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbGF9-0007NL-4s
	for gcggu-git-users@m.gmane.org; Thu, 04 Sep 2008 16:55:31 +0200
Received: by gxk22 with SMTP id 22so1768554gxk.21
        for <gcggu-git-users@m.gmane.org>; Thu, 04 Sep 2008 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=/OFHIlkTRBd9REksxtsqaxBbyCai81fWqy61NCXB1HA=;
        b=XG/UI7FFgR9ZYLwVOIoZiAOxC979veVCfL/nAw8u58LVlinDvQBCTR7LORhuGUkzyT
         jd6cD7ywI5jGu7MfK8uSpA2yneBy1P4bgSlqtPyvp3Kel2iloFtogx75xn1neI9MBMGm
         eyNCGHuwpAWgA+60llulJxevfZB1tAgXohNzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:references:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=s/CECRpCCOiGiMObWkz66NgFsSsN9RwKUX9XPbNPwD1yKbEisK624rWxYcV9aJ02hk
         gC+NvQeVHnNwJjJe9iaOT4EbktPlVRuD9MsVR64UVwaqC9ogM5xfVm6EZDt3MX/EGxgA
         8bZ1n2dhJT2oALCg5v2FQ9hJdTBJTj9FeIjJE=
Received: by 10.90.34.4 with SMTP id h4mr593446agh.27.1220540063428;
        Thu, 04 Sep 2008 07:54:23 -0700 (PDT)
Received: by 10.106.25.23 with SMTP id 23gr141pry.0;
	Thu, 04 Sep 2008 07:54:23 -0700 (PDT)
X-Sender: agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Apparently-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.214.148.21 with SMTP id v21mr12533172qad.5.1220540063041; Thu, 04 Sep 2008 07:54:23 -0700 (PDT)
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29]) by mx.google.com with ESMTP id 39si17830351yxd.2.2008.09.04.07.54.22; Thu, 04 Sep 2008 07:54:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.44.29 as permitted sender) client-ip=74.125.44.29;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 74.125.44.29 as permitted sender) smtp.mail=agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Received: by yx-out-2324.google.com with SMTP id 31so1666633yxl.81 for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Thu, 04 Sep 2008 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references; bh=vz8X7P1GLZrnlk6xte5r4hAFj+2Iie/2eUZG5FELQh0=; b=sFGZUTzxQsGAzZWSDVCcfaM5EjyjKwo7Zx4OMZzC8itspJthElyrTHwvhwiE4sF8pc Qa1DWswn2jmJQXoJ7So9e00BuPsci3VPUw/tDPv4DkMA1VVyPN+3j+g1yOytP4PmFb75 JSJ1300grMVUlAzhEMgVkaQiCP3GaXNgUXnU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:content-transfer-encoding:content-disposition :references; b=djwGKTw2WsuvtrD2ZPlPszSDdZlumDHdNlmKEVpKkPARbHOB5yJAfseYhHlsjvQKsX pwArhb1tFXe6VSyJcYaaOL5i+jYPyH9OKDA0B7sl0TnymjmOk2bnxXjiPhWbFK+6cadl ZqqhbB6hynHv4hevq5EEEHMdtLUITiXSW90/0=
Received: by 10.114.66.2 with SMTP id o2mr8902698waa.83.1220540061692; Thu, 04 Sep 2008 07:54:21 -0700 (PDT)
Received: by 10.115.95.8 with HTTP; Thu, 4 Sep 2008 07:54:21 -0700 (PDT)
In-Reply-To: <20080904143723.GB23708-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact git-users+owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <git-users.googlegroups.com>
List-Post: <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/git-users/subscribe>,
	<mailto:git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-BeenThere-Env: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94938>


(Shawn, apologies for double-posting.)

> Actually the header you sent me privately wasn't well formed.
> It looked something like this:
>
>  diff --git a/path/file.ext b/path/file.ext
>  --- a/path/file.ext
>  +++ b/path/file.ext
>  --- assert(a != b)
>  --- assert(a != c)
>  @@ -10,1 +10,2 @@
>
> It looks to me like some part of the context became part of the
> diff header, with three "-" stuck in front of it.  Which git-apply
> then thinks is the pre-image path name.

Aha! Thank you! That "--" is a comment in Lua (that is commented line
that was removed in diff). First dash is from diff, next two came from
file itself.

Steps to reproduce the bug:

$ mkdir test
$ cd test
$ git init
Initialized empty Git repository in path/test/.git/
$ cat >file.ext
-- 1
-- 2
-- 3
-- 4
-- 5
^D
$ git add file.ext
$ git commit -m "one"
Created initial commit 9226cdf: one
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 file.ext
$ cat >file.ext
-- 1
-- 2
-- 33
-- 4
-- 5
$ git gui

And stage (sole) hunk. You see the error.

> Can you put in some more puts in that same section of the code
> so we can find out which of the puts has these extra asserts?
> Is it the first one for $current_diff_header or is it the second
> one that is supposed to be pulling in the patch hunk?  Do you see
> these extra asserts in the diff viewer like this before you try to
> apply the patch?

Hopefully the above steps would help to debug this bug directly. If
you still need any more info from me, please say, I'll be glad to
provide it.

Thank you again!
Alexander.
