From: Tay Ray Chuan <rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Higher-level change review?
Date: Sun, 16 Oct 2011 23:05:33 +0800
Message-ID: <CALUzUxpr4FhjJ8OpYcpZOJLZuvveBNzKWd7soY6LQrz0Do1TDg@mail.gmail.com>
References: <m27h450zzc.fsf@pluto.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, magit <magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dave Abrahams <dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org>
X-From: magit+bncCIjC2d-DHxC-5ev0BBoEle1NAg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Oct 16 17:05:42 2011
Return-path: <magit+bncCIjC2d-DHxC-5ev0BBoEle1NAg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-bw0-f58.google.com ([209.85.214.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCIjC2d-DHxC-5ev0BBoEle1NAg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1RFSHR-0005Lg-6M
	for gcvgm-magit-3@m.gmane.org; Sun, 16 Oct 2011 17:05:37 +0200
Received: by bkbzs8 with SMTP id zs8sf2594421bkb.3
        for <gcvgm-magit-3@m.gmane.org>; Sun, 16 Oct 2011 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=xC9HnWnbOBqUkisZSVNkQBh528dx8OClDjeNFQztc8U=;
        b=EYjEzDqchA9k1nroFZe6s1L7kQF3kT0a7Guv1VXGDe0KienW8R9n4Vs3W2P/361wb8
         fCX3cjr38K0ExY8/ecTWxzxK//I7it/a8PipSp5OW85a0tGrj1e1JU4mCX/ys+4A09Wk
         4UxKJPWSFBuPs0aM7LcrVfbq/nV2oH/UhC4kI=
Received: by 10.223.61.1 with SMTP id r1mr174500fah.12.1318777534959;
        Sun, 16 Oct 2011 08:05:34 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.240.17 with SMTP id ky17ls948299bkb.3.gmail; Sun, 16 Oct
 2011 08:05:33 -0700 (PDT)
Received: by 10.204.7.214 with SMTP id e22mr1441172bke.2.1318777533899;
        Sun, 16 Oct 2011 08:05:33 -0700 (PDT)
Received: by 10.204.7.214 with SMTP id e22mr1441171bke.2.1318777533886;
        Sun, 16 Oct 2011 08:05:33 -0700 (PDT)
Received: from mail-bw0-f53.google.com (mail-bw0-f53.google.com [209.85.214.53])
        by gmr-mx.google.com with ESMTPS id n1si2511389bkn.1.2011.10.16.08.05.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 08:05:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.214.53 as permitted sender) client-ip=209.85.214.53;
Received: by bke11 with SMTP id 11so2423869bke.40
        for <magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Sun, 16 Oct 2011 08:05:33 -0700 (PDT)
Received: by 10.223.62.19 with SMTP id v19mr18011772fah.27.1318777533658; Sun,
 16 Oct 2011 08:05:33 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Sun, 16 Oct 2011 08:05:33 -0700 (PDT)
In-Reply-To: <m27h450zzc.fsf-NtBv8x4kbP9fRAUK6RR3EeqUGfbH9hYC@public.gmane.org>
X-Original-Sender: rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 209.85.214.53 as permitted sender)
 smtp.mail=rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183723>

On Sun, Oct 16, 2011 at 10:31 PM, Dave Abrahams <dave-xT6NqnoQrPdWk0Htik3J/w@public.gmane.org> wrote:
> I've discovered that Git's diff format is poorly-suited to reviewing the
> kinds of structural modifications I often deal with, where indentation
> changes and large parts of documents are reorganized.

Something off the top of my head:

  git (diff|show) -w

?

-- 
Cheers,
Ray Chuan
