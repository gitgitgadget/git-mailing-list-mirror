From: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: Git clone fails with "bad pack header", how to get
 remote log
Date: Mon, 29 Oct 2012 21:18:54 +0400
Message-ID: <20121029211854.b58c791d30a6c8d68665e574@domain007.com>
References: <7f498800-ed38-474d-86ad-cb937be68173@googlegroups.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin Molcard <kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: git-users+bncBCWKX34CSUCBBAXVXKCAKGQER4YFPSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Mon Oct 29 18:19:08 2012
Return-path: <git-users+bncBCWKX34CSUCBBAXVXKCAKGQER4YFPSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCWKX34CSUCBBAXVXKCAKGQER4YFPSY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TSszT-0005Yn-Hj
	for gcggu-git-users@m.gmane.org; Mon, 29 Oct 2012 18:19:07 +0100
Received: by mail-wg0-f58.google.com with SMTP id dt12sf1632609wgb.3
        for <gcggu-git-users@m.gmane.org>; Mon, 29 Oct 2012 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :in-reply-to:references:x-mailer:mime-version:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=z0FOqx/5xxrVErk3dlLinLk0Px98c7+Au8TKv27xBMQ=;
        b=HBtxBXRClm2qxnI8H4Rrc2G3NFLMeA5XKtJTn5aVWTsh41jjvz7PXspj2Mc0AcSgni
         5hKGB1LfhgtfggWwIlIZX6Q7bEYk8XbSGVcON1CB985JR0VVOuHAF4VZcI7Yd5vGxf+T
         d35QNH0HBkANruZ0Gx3hhCRfDoTtRi6PmtWEyCz/ZZLGwon9kGZxRcR488dPpwSNoLBX
         4g+1AnXyn4KhqmkKLK5Ul4SCgg8+TrvxFOg3zz1uHvrV9YLKXLWLrC86e62lIUpOr5ua
         MEUu3ga+Xck7uRaaKg2THyrXaRFP7caayIovZf6tvTn0jItbE9IWRG2sHy+ZomSNObGv
         
Received: by 10.205.137.11 with SMTP id im11mr2171935bkc.30.1351531139216;
        Mon, 29 Oct 2012 10:18:59 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.155.71 with SMTP id r7ls6791838bkw.6.gmail; Mon, 29 Oct
 2012 10:18:58 -0700 (PDT)
Received: by 10.205.123.145 with SMTP id gk17mr6557783bkc.2.1351531138068;
        Mon, 29 Oct 2012 10:18:58 -0700 (PDT)
Received: by 10.205.123.145 with SMTP id gk17mr6557781bkc.2.1351531138048;
        Mon, 29 Oct 2012 10:18:58 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id o9si1011628bko.2.2012.10.29.10.18.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 10:18:57 -0700 (PDT)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) client-ip=84.204.203.130;
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q9THIsMq016168;
	Mon, 29 Oct 2012 21:18:55 +0400
In-Reply-To: <7f498800-ed38-474d-86ad-cb937be68173-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Original-Sender: flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 84.204.203.130 is neither permitted nor denied by best guess record for
 domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) smtp.mail=flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208629>

On Mon, 29 Oct 2012 09:52:54 -0700 (PDT)
Kevin Molcard <kev2041-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I have a problem with my build system.
> 
> I have a remote server with a relatively large repository (around 12
> GB, each branch having a size of 3 GB). 
> 
> I have also 2 build servers (Mac, Windows) that are cloning the repo
> from the remote.
> 
> Sometimes (very often when several git clone are sent at the same
> time), I have the following error:
>         
>     remote: internal server error
>     fatal: protocol error: bad pack header
> 
> I know that it happens when the remote is compressing objects (thanks
> to `--progress -v` flags) because the last line of the log before the
> erro is: 
>     remote: Compressing objects:  93% (17959/19284)   [K
> 
>  * So I have 2 questions, does anybody what is the problem and what
> should I do?
>  * Is there a way to get a more precise log from the remote to debug
> this problem?

This reminds me of a bug fixed in 1.7.12.1 [1]:

* When "git push" triggered the automatic gc on the receiving end, a
  message from "git prune" that said it was removing cruft leaked to
  the standard output, breaking the communication protocol.

In any case, bugs should be reported to the main Git list (which is
git at vger.kernel.org), not here.
I'm Cc'ing the main Git list so you'll get any responses from there, if
any.

Kevin, please answer to this message (keeping all the Ccs -- use "Reply
to group" or "Reply to all" in your MUA) and describe exactly what Git
versions on which platforms your have.

1. https://raw.github.com/git/git/master/Documentation/RelNotes/1.7.12.1.txt

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
