From: Thomas Ferris Nicolaisen <tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Fri, 5 Oct 2012 17:21:26 +0200
Message-ID: <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
	<CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 
	git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, August Karlstrom <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCUYJD4C7IMBB5XVXOBQKGQEHDSNGRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Oct 05 17:21:35 2012
Return-path: <git-users+bncBCUYJD4C7IMBB5XVXOBQKGQEHDSNGRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-vb0-f58.google.com ([209.85.212.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCUYJD4C7IMBB5XVXOBQKGQEHDSNGRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TK9iX-0007Rx-PH
	for gcggu-git-users@m.gmane.org; Fri, 05 Oct 2012 17:21:33 +0200
Received: by mail-vb0-f58.google.com with SMTP id p1sf1500769vbi.3
        for <gcggu-git-users@m.gmane.org>; Fri, 05 Oct 2012 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=wmPRS1/tVhEd+MXjQN3o92ArdAYJAzRZYAUN4mHLeZQ=;
        b=UMGd1g+x3yfBMg5qD4IPAiTZave7qby5KQJBNoZX2mGa6du6xgA6f0wNAEuFqBM8vg
         B8Ntkj22cYxKHSJVG8Psav18Fuk6XqlMAHJwDogQ6u1XsdJ7wikaLLoI0sVbOjoe+wnj
         XvUxSU5b4CjgrdE1trizAO+4U2FwSxI4BeKuIHd98N5WhpMbkH1mmLhc3gxYwcn3N8DP
         vsIkU/iKR8GyKguv6kSLMf9bSROEZsBN+RBSutuNniQedsf8M8VWPGVuBdm4H/MDePrk
         uTc4JsIlJ09YXzVN6ESNu5AL8RyQn9E/HG70mlR6zZ2QmCyDCi8kNJ1AEq2znDt0lEDL
         A2SA==
Received: by 10.50.217.164 with SMTP id oz4mr657893igc.6.1349450487169;
        Fri, 05 Oct 2012 08:21:27 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.197.170 with SMTP id iv10ls956705igc.4.gmail; Fri, 05 Oct
 2012 08:21:26 -0700 (PDT)
Received: by 10.42.19.199 with SMTP id d7mr5394599icb.11.1349450486468;
        Fri, 05 Oct 2012 08:21:26 -0700 (PDT)
Received: by 10.42.19.199 with SMTP id d7mr5394598icb.11.1349450486458;
        Fri, 05 Oct 2012 08:21:26 -0700 (PDT)
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com [209.85.219.44])
        by gmr-mx.google.com with ESMTPS id dd6si203595igc.0.2012.10.05.08.21.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 08:21:26 -0700 (PDT)
Received-SPF: pass (google.com: domain of tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.219.44 as permitted sender) client-ip=209.85.219.44;
Received: by mail-oa0-f44.google.com with SMTP id n5so2256406oag.31
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 05 Oct 2012 08:21:26 -0700 (PDT)
Received: by 10.182.179.100 with SMTP id df4mr7426324obc.59.1349450486304;
 Fri, 05 Oct 2012 08:21:26 -0700 (PDT)
Received: by 10.60.21.226 with HTTP; Fri, 5 Oct 2012 08:21:26 -0700 (PDT)
In-Reply-To: <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Original-Sender: tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.219.44 as permitted sender)
 smtp.mail=tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207109>

On Fri, Oct 5, 2012 at 3:46 PM, Philippe Vaucher
<philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> > On the git-users mailing list we're trying someone to help with
> > running `git push` over FTP.  That person is runnig Git 1.7.9.5
> > on Ubuntu 12.04.
>
> I don't think vanilla git supports pushing over ftp.
>

At least according to the documentation[1], "Git natively supports [...] ftp".

This could need some clarification if pushing over ftp is not supported.

[1] http://www.kernel.org/pub/software/scm/git/docs/git-push.html#URLS

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
