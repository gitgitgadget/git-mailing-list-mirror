From: lei yang <yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: how to get the formated patches from the merge id
Date: Fri, 15 Jun 2012 20:56:28 +0800
Message-ID: <CAHsH0E8MzMW8SEFGB_X80qH_5btnmvLWFxjQ-EBSaGbHSUz-Sg@mail.gmail.com>
References: <CAHsH0E98t7EcvXM0zSjMGHcd5u4_Lp6B7q9KAhcE0eyo-tXnWw@mail.gmail.com>
	<9579793f-d72f-424c-9546-f2caa1fbf847@googlegroups.com>
	<CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ@mail.gmail.com>
	<4FDB239A.9070803@lyx.org>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent van Ravesteijn <vfr-0hXrFu2P2+c@public.gmane.org>
X-From: git-users+bncCJHCj86PEhD94ez-BBoEQr-Rzg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Jun 15 14:56:32 2012
Return-path: <git-users+bncCJHCj86PEhD94ez-BBoEQr-Rzg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncCJHCj86PEhD94ez-BBoEQr-Rzg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SfW4k-00056e-PB
	for gcggu-git-users@m.gmane.org; Fri, 15 Jun 2012 14:56:30 +0200
Received: by pbbro8 with SMTP id ro8sf3349108pbb.3
        for <gcggu-git-users@m.gmane.org>; Fri, 15 Jun 2012 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=JIZCvyzKQcbg3FeBQT5ooq0a21j3wGF8MbxtNt06BG0=;
        b=6tU5ePD1iZjhop0wGW8umCkMHssEkO8WnJXADUVPgLyLUej2jtFlUId98tgmcj7S50
         rGuA07acIkYgxS1rEkEMRTHmgvzsP+dYtSizpGcYWEj3XYEPvfVSt76tWliIHb6bA+Uk
         GZbrd8fsr51FBZvvsugrBhf9bjHfDzfbu2pGY=
Received: by 10.52.95.238 with SMTP id dn14mr394403vdb.1.1339764989432;
        Fri, 15 Jun 2012 05:56:29 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.220.219.79 with SMTP id ht15ls693966vcb.3.gmail; Fri, 15 Jun
 2012 05:56:28 -0700 (PDT)
Received: by 10.52.75.161 with SMTP id d1mr3630244vdw.2.1339764988752;
        Fri, 15 Jun 2012 05:56:28 -0700 (PDT)
Received: by 10.52.75.161 with SMTP id d1mr3630243vdw.2.1339764988740;
        Fri, 15 Jun 2012 05:56:28 -0700 (PDT)
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com [209.85.220.172])
        by gmr-mx.google.com with ESMTPS id l12si2602533vdf.3.2012.06.15.05.56.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 05:56:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.220.172 as permitted sender) client-ip=209.85.220.172;
Received: by vcqp1 with SMTP id p1so1781921vcq.3
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 15 Jun 2012 05:56:28 -0700 (PDT)
Received: by 10.52.100.4 with SMTP id eu4mr2501655vdb.66.1339764988593; Fri,
 15 Jun 2012 05:56:28 -0700 (PDT)
Received: by 10.52.97.35 with HTTP; Fri, 15 Jun 2012 05:56:28 -0700 (PDT)
In-Reply-To: <4FDB239A.9070803-0hXrFu2P2+c@public.gmane.org>
X-Original-Sender: yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.220.172 as permitted
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200049>

On Fri, Jun 15, 2012 at 7:59 PM, Vincent van Ravesteijn <vfr-0hXrFu2P2+c@public.gmane.org> wrote:
> Op 15-6-2012 13:46, lei yang schreef:
>
>> Hi
>>
>> I mean,
>>
>> I have a commit like below
>> commit 0e93b4b304ae052ba1bc73f6d34a68556fe93429
>> Merge: b724cc1 51bfd29
>>
>> This commit done this work: merge b724cc1..51bfd29 commit,
>>
>> The question is how could I *onlys* through
>> 0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get the formated patch for
>> the
>> commit(b724cc1..51bfd29)
>
>
> It is still not clear what you want to accomplish.
>
> Your proposal: "git format-patch b724cc1..51bfd29" only gives you the
> commits that were in the branch 51bfd29 that weren't yet in the branch
> b724cc1. This just reflect the commits of one of the branches, but not the
> "work done by the merge commit".
>


but,git format-patch b724cc1..51bfd29 do the same work as what you
said "git format-patch 0e93b4b3^1..0e93b4b3^2"
so this do the same thing, formated patch which merged, can you give a
try to explain it in your workspace. and I don't understand what you
said "branch 51bfd29",51bfd29 is not the branch

Thanks for your help,git format-patch 0e93b4b3^1..0e93b4b3^2 is what I need.

Lei





> If this is really what you want you can do:
>
> $ git format-patch 0e93b4b3^1..0e93b4b3^2
>
> 0e93b4b3^1 means the first parent of 0e93b4b3, which is b724cc1. 0e93b4b3^2
> means the second parent, which is 51bfd29
>
> HTH,
>
> Vincent

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
