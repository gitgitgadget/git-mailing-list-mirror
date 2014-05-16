From: John Fisher <fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: worlds slowest git repo- what to do?
Date: Fri, 16 May 2014 14:22:44 -0700
Message-ID: <537681A4.2070601@gmail.com>
References: <5374F7C6.5030205@gmail.com> <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley> <CACsJy8CmiW88tNavRphZa_uMU=jVUCQE6cw5+t2AYnf5dDmcsQ@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Git List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
 Philip Oakley <philipoakley-7KbaBNvhQFM@public.gmane.org>
To: Duy Nguyen <pclouds-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, John Fisher <fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBDC6ZSUJSQEBBJ4D3KNQKGQERDH2K2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri May 16 23:22:50 2014
Return-path: <git-users+bncBDC6ZSUJSQEBBJ4D3KNQKGQERDH2K2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-yh0-f64.google.com ([209.85.213.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDC6ZSUJSQEBBJ4D3KNQKGQERDH2K2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1WlPab-0002Z1-Q6
	for gcggu-git-users@m.gmane.org; Fri, 16 May 2014 23:22:50 +0200
Received: by mail-yh0-f64.google.com with SMTP id b6sf1420450yha.19
        for <gcggu-git-users@m.gmane.org>; Fri, 16 May 2014 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=9wkQiRoDGW0GwxNC4V/xZPV0pNI3/M0gEdm06em5s1I=;
        b=uE1vECM/Ls5ZjJC8094hnalMJuMFNG+bxhAy5w4Dyj7d2rmummRbaSvR542TdIBfLY
         vyrFcCqtBVpPvXarmnudOjIkjKFnxDICi0TWQcAvtu4w45zaM4G5PCzk+ck0ofS/S9Lt
         dbmFSFBTq7R3QTssNwmSjU5jpLppcc8+bBZtcgLHKULKtB+5QWXBWw8iNVPTV63yIJnh
         X7K/ZY+U/qxqnf6CS36utko+Z87uWKqU37tr0K75ubHdRxjrnqIxOldzMk34mAVHnPI6
         OVWu2/M/UhSExMcDlB5nWuuVR4emVzX/jn4osc1Ia6VF3/AkznblGZSvX6to8Sn49Rz/
         sfYw==
X-Received: by 10.140.97.166 with SMTP id m35mr48424qge.28.1400275368884;
        Fri, 16 May 2014 14:22:48 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.140.101.247 with SMTP id u110ls901139qge.79.gmail; Fri, 16 May
 2014 14:22:47 -0700 (PDT)
X-Received: by 10.58.95.98 with SMTP id dj2mr1745934veb.30.1400275367573;
        Fri, 16 May 2014 14:22:47 -0700 (PDT)
Received: from mail-pb0-x22f.google.com (mail-pb0-x22f.google.com [2607:f8b0:400e:c01::22f])
        by gmr-mx.google.com with ESMTPS id zs4si2142031pbc.1.2014.05.16.14.22.47
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 14:22:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:400e:c01::22f as permitted sender) client-ip=2607:f8b0:400e:c01::22f;
Received: by mail-pb0-x22f.google.com with SMTP id rp16so3112034pbb.34
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Fri, 16 May 2014 14:22:47 -0700 (PDT)
X-Received: by 10.66.190.167 with SMTP id gr7mr24154456pac.75.1400275367447;
        Fri, 16 May 2014 14:22:47 -0700 (PDT)
Received: from [10.2.6.1] (wsip-98-173-202-3.sb.sd.cox.net. [98.173.202.3])
        by mx.google.com with ESMTPSA id xk1sm38843316pac.21.2014.05.16.14.22.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 14:22:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CACsJy8CmiW88tNavRphZa_uMU=jVUCQE6cw5+t2AYnf5dDmcsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Original-Sender: fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:400e:c01::22f
 as permitted sender) smtp.mail=fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249419>


On 05/16/2014 03:13 AM, Duy Nguyen wrote:
> On Fri, May 16, 2014 at 2:06 AM, Philip Oakley <philipoakley-7KbaBNvhQFM@public.gmane.org> wrote:
>> From: "John Fisher" <fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> I assert based on one piece of evidence ( a post from a facebook dev) that
>>> I now have the worlds biggest and slowest git
>>> repository, and I am not a happy guy. I used to have the worlds biggest
>>> CVS repository, but CVS can't handle multi-G
>>> sized files. So I moved the repo to git, because we are using that for our
>>> new projects.
>>>
>>> goal:
>>> keep 150 G of files (mostly binary) from tiny sized to over 8G in a
>>> version-control system.
> I think your best bet so far is git-annex 

good, I am  looking at that

> (or maybe bup) for dealing
> with huge files. I plan on resurrecting Junio's split-blob series to
> make core git handle huge files better, but there's no eta on that.
> The problem here is about file size, not the number of files, or
> history depth, right?

When things here calm down, I could easily test the repo without the giant files, leaving 99% of files in the repo.
There is hardly any history depth because these are releases, version controlled by directory name. As has been
suggested I could be forced to abandon the version-control, even to the point of just using rsync.  But I've been doing
this with CVS for 10 years now and I hate to change or in any way move away fron KISS. Moving it to Git may not have
been one of my better ideas...


> Probably known issues. But some elaboration would be nice (e.g. what operation is slow, how slow, some more detail
> characteristics of the repo..) in case new problems pop up. 

so far I have done add, commit, status, clone - commit and status are slow; add seems to depend on the files involved,
clone seems to run at network speed.
I can provide metrics later, see above. email me offline with what you want.

John

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
