From: lei yang <yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: how to get the formated patches from the merge id
Date: Fri, 15 Jun 2012 19:46:22 +0800
Message-ID: <CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ@mail.gmail.com>
References: <CAHsH0E98t7EcvXM0zSjMGHcd5u4_Lp6B7q9KAhcE0eyo-tXnWw@mail.gmail.com>
	<9579793f-d72f-424c-9546-f2caa1fbf847@googlegroups.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-From: git-users+bncCJHCj86PEhCQwez-BBoEqnV82w-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Jun 15 13:46:26 2012
Return-path: <git-users+bncCJHCj86PEhCQwez-BBoEqnV82w-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncCJHCj86PEhCQwez-BBoEqnV82w-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SfUyu-0007OP-NH
	for gcggu-git-users@m.gmane.org; Fri, 15 Jun 2012 13:46:24 +0200
Received: by yenq6 with SMTP id q6sf2414791yen.3
        for <gcggu-git-users@m.gmane.org>; Fri, 15 Jun 2012 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tdACZ9RVstadshL4K+AfHndxK7jxlPIIiorF+oAGY4k=;
        b=XJNgqCJo5TY0JFM6Ib7PwCw+xSy59Rpridbd5AdCut37ktynyPhsDR/jYW0UuYZFyW
         36hPOaP/z6iGiZTYbQCqaRCPcv/frlS7jlzIg83jLgr1pAJprGKDn/ykRx8w9hVpphMl
         06bChRStT+fbCxvEjafFX0opCzt7mrgieIS4o=
Received: by 10.52.20.51 with SMTP id k19mr383146vde.8.1339760784278;
        Fri, 15 Jun 2012 04:46:24 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.52.69.174 with SMTP id f14ls693755vdu.2.gmail; Fri, 15 Jun
 2012 04:46:23 -0700 (PDT)
Received: by 10.52.240.229 with SMTP id wd5mr3410922vdc.8.1339760783207;
        Fri, 15 Jun 2012 04:46:23 -0700 (PDT)
Received: by 10.52.240.229 with SMTP id wd5mr3410921vdc.8.1339760783198;
        Fri, 15 Jun 2012 04:46:23 -0700 (PDT)
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com [209.85.220.177])
        by gmr-mx.google.com with ESMTPS id u6si2553671vdi.1.2012.06.15.04.46.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 04:46:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.220.177 as permitted sender) client-ip=209.85.220.177;
Received: by vcbf13 with SMTP id f13so1759082vcb.36
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 15 Jun 2012 04:46:23 -0700 (PDT)
Received: by 10.52.29.69 with SMTP id i5mr523080vdh.84.1339760782760; Fri, 15
 Jun 2012 04:46:22 -0700 (PDT)
Received: by 10.52.97.35 with HTTP; Fri, 15 Jun 2012 04:46:22 -0700 (PDT)
In-Reply-To: <9579793f-d72f-424c-9546-f2caa1fbf847-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-Original-Sender: yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.220.177 as permitted
 sender) smtp.mail=yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en_US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en_US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200046>

Hi

I mean,

I have a commit like below
commit 0e93b4b304ae052ba1bc73f6d34a68556fe93429
Merge: b724cc1 51bfd29

This commit done this work: merge b724cc1..51bfd29 commit,

The question is how could I *onlys* through
0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get the formated patch for
the
commit(b724cc1..51bfd29)

Lei


On Fri, Jun 15, 2012 at 4:02 PM, Thomas Ferris Nicolaisen
<tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> I don't really understand what you're trying to do here. Could you try
> explaining in a little more detail?
>
>
> On Thursday, June 14, 2012 6:25:12 PM UTC+2, lei yang wrote:
>>
>> Hello list:
>>
>> eg:
>>
>> commit 0e93b4b304ae052ba1bc73f6d34a68556fe93429
>> Merge: b724cc1 51bfd29
>>
>> how can I from 0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get the
>> formated patch ?
>> (I know we can do git format-patch b724cc1..51bfd29, but how to from
>> 0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get?)
>>
>> Lei
>
> --
> You received this message because you are subscribed to the Google Groups
> "Git for human beings" group.
> To view this discussion on the web visit
> https://groups.google.com/d/msg/git-users/-/kVcX-TK_VowJ.
> To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> To unsubscribe from this group, send email to
> git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit this group at
> http://groups.google.com/group/git-users?hl=en.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
