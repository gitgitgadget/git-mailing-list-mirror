From: "Shawn O. Pearce" <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Mon, 15 Sep 2008 07:24:21 -0700
Message-ID: <20080915142421.GE6320@spearce.org>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com> <20080904143723.GB23708@spearce.org> <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com> <20080905045327.GA31166@spearce.org> <c6c947f60809150721m1ec11f10xc68ce39559398659@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Gladysh <agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Sep 15 16:30:14 2008
Return-path: <grbounce-9bT_dAUAAACIBuRSQHd8xQYABcDNOWyf=gcggu-git-users=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-gx0-f59.google.com ([209.85.217.59])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfF1A-0003XL-7X
	for gcggu-git-users@m.gmane.org; Mon, 15 Sep 2008 16:25:32 +0200
Received: by gxk19 with SMTP id 19so104636gxk.21
        for <gcggu-git-users@m.gmane.org>; Mon, 15 Sep 2008 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received:date
         :from:to:cc:subject:message-id:references:mime-version:content-type
         :in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=VNFo+SP8uS1AcjPwgYQRhl7bqjEhHgM8Rpx3YOenc4Y=;
        b=FQRXI3kv1lcGWrY+AVLsraViSGZOjjnqr5rkLRymX+ZyUVRVsGkOA+hSN0eR/ZMrlU
         nOf3OR70UPwX7V8v/lr/VwqUlmQwKHAQDKVjkSH/xsgxN4lleWYgnnL+uUJLCJAgxFSu
         OA+vfAe6beJotVAieSgIgp7VLrhjEfv3a9o78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:to:cc:subject:message-id:references:mime-version:content-type
         :in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=aVF5r8DE1v7FEhDNC3JMRxzs6nLv4Uv64jqKj1czrAOhAZPucEZm+eU3LMObN3KxC+
         n1oNJOFMvtlVNnlSwRlhVkLWbjgIYb7280OLd10i0UpCPZb7XrqBsxbZCTTxsPGCGMmH
         OLh/rNiS85x6mJ6H60VnGLyxkO7uhcMGmodcg=
Received: by 10.100.120.6 with SMTP id s6mr3520anc.24.1221488662775;
        Mon, 15 Sep 2008 07:24:22 -0700 (PDT)
Received: by 10.106.212.23 with SMTP id k23gr166prg.0;
	Mon, 15 Sep 2008 07:24:22 -0700 (PDT)
X-Sender: spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org
X-Apparently-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.140.164.1 with SMTP id m1mr1588832rve.16.1221488662384; Mon, 15 Sep 2008 07:24:22 -0700 (PDT)
Received: from george.spearce.org (george.spearce.org [209.20.77.23]) by mx.google.com with ESMTP id 39si8208653yxd.2.2008.09.15.07.24.22; Mon, 15 Sep 2008 07:24:22 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org designates 209.20.77.23 as permitted sender) client-ip=209.20.77.23;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org designates 209.20.77.23 as permitted sender) smtp.mail=spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org
Received: by george.spearce.org (Postfix, from userid 1001) id B89833835F; Mon, 15 Sep 2008 14:24:21 +0000 (UTC)
In-Reply-To: <c6c947f60809150721m1ec11f10xc68ce39559398659-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95912>


Alexander Gladysh <agladysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Sep 5, 2008 at 8:53 AM, Shawn O. Pearce <spearce-o8xcbExO1WpAfugRpC6u6w@public.gmane.org> wrote:
> 
> > git-gui: Fix diff parsing for lines starting with "--" or "++"
> 
> Somewhat related bug, but reproduceable event without "--". If I set
> diff context to none in git gui (by repeatedly clicking "show less
> context") I'm sometimes not able to stage hunk or line.

git-apply refuses to apply a patch with 0 context lines.  Latest
git-gui in maint (and in Git 1.6.0.2?) won't let you reduce the
number of context lines below 1, so you never can see this error.
 
> Reduce context to none, then do stage hunk. It fails with message:
> 
> error: patch failed: file.ext:3
> error: file.ext: patch does not apply
> OK

-- 
Shawn.
