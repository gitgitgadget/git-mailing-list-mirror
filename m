From: "Philip Oakley" <philipoakley-7KbaBNvhQFM@public.gmane.org>
Subject: Re: worlds slowest git repo- what to do?
Date: Thu, 15 May 2014 20:06:40 +0100
Organization: OPDS
Message-ID: <06A2490FC9BC4461A39B982D3C7C85F7@PhilipOakley>
References: <5374F7C6.5030205@gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Cc: "Git List" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "John Fisher" <fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: git-users+bncBDSOTWHYX4PBBVFA2SNQKGQECUE2YFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Thu May 15 21:07:04 2014
Return-path: <git-users+bncBDSOTWHYX4PBBVFA2SNQKGQECUE2YFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-ee0-f59.google.com ([74.125.83.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBDSOTWHYX4PBBVFA2SNQKGQECUE2YFQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1Wl0zd-0007an-QX
	for gcggu-git-users@m.gmane.org; Thu, 15 May 2014 21:07:01 +0200
Received: by mail-ee0-f59.google.com with SMTP id c41sf153560eek.14
        for <gcggu-git-users@m.gmane.org>; Thu, 15 May 2014 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:references:subject:date:organization
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=n9zsBACA/PkIwBqVvNw4ovnzemmbZZCst0KGuItG4gQ=;
        b=tSVwwhci3NWY141N8VSzdbcUNHqx0cMNqE7JUJvbSOp4AEGHMwM+nYgBVrA4aDYGVx
         lMMx2HSUrWibyaxQ76qCUENAf8TfvYsEAJnGqyCHBc/bmgM+DJsLJxYBLnTCnC88SdHM
         zgdZ9yDdY5n8GMfF0vhUAj8CiuGuhBs9VB/jeqYrZof7dcikcbLhFAtNmyhWmY8Ond3K
         7nLxqF9L2zpRHbVOYAtiRNPTF0uAGuP1ySSbcNGzUYW4xJVUT9zI7ZKOe9xwwh0F6bml
         SQmn+KqbsFUaEvhS8TmXL09p7chWLSwO52thCbe6OeFPEmjPzs3pgzAPjd5MCKKQl9AK
         Sthg==
X-Received: by 10.152.184.38 with SMTP id er6mr26383lac.26.1400180821536;
        Thu, 15 May 2014 12:07:01 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.152.22.195 with SMTP id g3ls75958laf.59.gmail; Thu, 15 May
 2014 12:07:00 -0700 (PDT)
X-Received: by 10.152.43.101 with SMTP id v5mr7473lal.10.1400180820107;
        Thu, 15 May 2014 12:07:00 -0700 (PDT)
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net. [62.24.128.241])
        by gmr-mx.google.com with ESMTP id u3si827628wiw.3.2014.05.15.12.06.59
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>;
        Thu, 15 May 2014 12:07:00 -0700 (PDT)
Received-SPF: softfail (google.com: domain of transitioning philipoakley-7KbaBNvhQFM@public.gmane.org does not designate 62.24.128.241 as permitted sender) client-ip=62.24.128.241;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvoYACcQdVNZ8Y1s/2dsb2JhbABZgwZPiH28bwQBAQIBAYESF3SCIAUBAQQBCAEBLh4BASELAgMFAgEDDgcMJRQBBAgSBgcXBgESCAIBAgMBiBwDCQwJshSYYQ2GLow5ghWDMoEVBIRaAoR7hkKCV4RugzCLbYVqgzc8
X-IPAS-Result: AvoYACcQdVNZ8Y1s/2dsb2JhbABZgwZPiH28bwQBAQIBAYESF3SCIAUBAQQBCAEBLh4BASELAgMFAgEDDgcMJRQBBAgSBgcXBgESCAIBAgMBiBwDCQwJshSYYQ2GLow5ghWDMoEVBIRaAoR7hkKCV4RugzCLbYVqgzc8
X-IronPort-AV: E=Sophos;i="4.97,1061,1389744000"; 
   d="scan'208";a="456386223"
Received: from host-89-241-141-108.as13285.net (HELO PhilipOakley) ([89.241.141.108])
  by out1.ip05ir2.opaltelecom.net with SMTP; 15 May 2014 20:06:40 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley-7KbaBNvhQFM@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley-7KbaBNvhQFM@public.gmane.org does not designate
 62.24.128.241 as permitted sender) smtp.mail=philipoakley-7KbaBNvhQFM@public.gmane.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249184>

From: "John Fisher" <fishook2033-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>I assert based on one piece of evidence ( a post from a facebook dev) 
>that I now have the worlds biggest and slowest git
> repository, and I am not a happy guy. I used to have the worlds 
> biggest CVS repository, but CVS can't handle multi-G
> sized files. So I moved the repo to git, because we are using that for 
> our new projects.
>
> goal:
> keep 150 G of files (mostly binary) from tiny sized to over 8G in a 
> version-control system.
>
> problem:
> git is absurdly slow, think hours, on fast hardware.
>
> question:
> any suggestions beyond these-
> http://git-annex.branchable.com/
> https://github.com/jedbrown/git-fat
> https://github.com/schacon/git-media
> http://code.google.com/p/boar/
> subversion
>
> ?

At the moment some of the developers are looking to speed up some of the 
code on very large repos, though I think they are looking at code repos, 
rather than large file repos. They were looking for large repos to test 
some of the code upon ;-)

I've copied the Git list should they want to make any suggestions.

>
>
> Thanks.
>
> -- 
Philip 

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
