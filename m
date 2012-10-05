From: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: Fw: How do I git-push to an FTP server?
Date: Fri, 5 Oct 2012 21:38:10 +0400
Message-ID: <20121005213810.28199bf3504fd64b87d0bf6e@domain007.com>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
	<CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, August Karlstrom
 <fusionfile-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBCWKX34CSUCBBBVWXSBQKGQEHJG5BZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Oct 05 19:38:21 2012
Return-path: <git-users+bncBCWKX34CSUCBBBVWXSBQKGQEHJG5BZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBCWKX34CSUCBBBVWXSBQKGQEHJG5BZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1TKBqv-00010C-HA
	for gcggu-git-users@m.gmane.org; Fri, 05 Oct 2012 19:38:21 +0200
Received: by mail-wi0-f186.google.com with SMTP id hm2sf276933wib.3
        for <gcggu-git-users@m.gmane.org>; Fri, 05 Oct 2012 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :in-reply-to:references:x-mailer:mime-version:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=+DpoLvtHIoOq1UG3UH5/k0dyv+Oc2+YVHtZckqLxVEs=;
        b=v/6ctHquYuajG6lwsq6QANmrVO/cLshUx2vTfehVpnZs/82uJ/X89ilcEDx4LIsE5d
         e5R3ajnKMddb0SYIAp0CWRj1ZZv3hCWSat4AL5iNgP8HoUu0q+VEJGgRgQxuh43t0wKg
         yxFZ66fCcye+vNXSOTc5nxB1DFMsB7dwbYifHBxgtKbtw8FyUFravv8sTmSW50l1ZV5o
         1ppLF3V3IktCqhz2/AzEwcM9MHANmxHpDF+RGA/WSLCVwE5Tq36jxoGd0KUOOyeGcT2n
         sj/L61Zu8nEFRxMcpQUnDUKquLQZ0A9y2ZROMPVP31vM+pf5Za1rKD3fs9XtSD3UhXmq
         
Received: by 10.204.129.220 with SMTP id p28mr921864bks.1.1349458695458;
        Fri, 05 Oct 2012 10:38:15 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.129.197 with SMTP id p5ls4870706bks.9.gmail; Fri, 05 Oct
 2012 10:38:14 -0700 (PDT)
Received: by 10.204.4.211 with SMTP id 19mr663121bks.5.1349458694489;
        Fri, 05 Oct 2012 10:38:14 -0700 (PDT)
Received: by 10.204.4.211 with SMTP id 19mr663120bks.5.1349458694475;
        Fri, 05 Oct 2012 10:38:14 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id k7si1053709bks.2.2012.10.05.10.38.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 10:38:14 -0700 (PDT)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) client-ip=84.204.203.130;
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q95HcAtj011073;
	Fri, 5 Oct 2012 21:38:11 +0400
In-Reply-To: <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207113>

On Fri, 5 Oct 2012 15:46:33 +0200
Philippe Vaucher <philippe.vaucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> > On the git-users mailing list we're trying someone to help with
> > running `git push` over FTP.  That person is runnig Git 1.7.9.5
> > on Ubuntu 12.04.
> 
> I don't think vanilla git supports pushing over ftp.
> 
> There are plugins like https://github.com/resmo/git-ftp tho.

git-ftp's functionality is completely orthogonal to `git push` -- this
script allows to sync a tree referenced by the specified Git commit
with a remote directory accessible via FTP, transferring only
new and modified files and deleting disappeared files and directories.
IOW, git-ftp is a (very handy) Git-powered *deployment* tool, not a
backend for `git push` or something like that.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
