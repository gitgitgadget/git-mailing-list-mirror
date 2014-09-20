From: Andrew Latham <lathama@gmail.com>
Subject: Re: [slightly OT?] TOTP gateway for any service on any server
Date: Sat, 20 Sep 2014 09:46:17 -0500
Message-ID: <CA+qj4S_DOD=jVQBciA1sAJHNVu1VjMjr4LtZMgK-31zUp2uxmw@mail.gmail.com>
References: <541D860A.9040203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gitolite Google Groups <gitolite@googlegroups.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: gitolite+bncBDY5L3FXRYLRBONG62QAKGQE6TLHY4Q@googlegroups.com Sat Sep 20 16:46:20 2014
Return-path: <gitolite+bncBDY5L3FXRYLRBONG62QAKGQE6TLHY4Q@googlegroups.com>
Envelope-to: gcvg-gitolite@m.gmane.org
Received: from mail-oa0-f62.google.com ([209.85.219.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <gitolite+bncBDY5L3FXRYLRBONG62QAKGQE6TLHY4Q@googlegroups.com>)
	id 1XVLvX-0006p6-IL
	for gcvg-gitolite@m.gmane.org; Sat, 20 Sep 2014 16:46:19 +0200
Received: by mail-oa0-f62.google.com with SMTP id g18sf717418oah.27
        for <gcvg-gitolite@m.gmane.org>; Sat, 20 Sep 2014 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=m33RwdORc5IYfROdHPcAz+OSTBhaZDeCltPB6p35/8I=;
        b=b5DHl2vmWAy1+lZRSZQnzNco239d9Ud7+S5Y6j2WvuuZxrAf0wmVHg6eMemXrS3mxA
         wXHG5QMkyQLtnOHxHB6ADVev51326ksTQ7wyZyJIyKr3jj23dJXwyosNmAMpngFdcqsU
         Bhgxo09N5HNK6uI1oSrVhn0GcxQv+FBq7ftIgPgiKnQzb1+J1+uzwG+CpaQJCXOp21ym
         GNVY1EVRXr4ieLELGNFbP5T6TR3WjtzDxA/YWoEHbQLexuPH6r2WqDldshA63Mhh5t4R
         WGLg6QCG6EXZ7iTaTjafgoz0H969p9jEy8GLgQ5e34URMmmo1N4v+zUL0Ql+Xnn0xGdt
         kezQ==
X-Received: by 10.50.118.4 with SMTP id ki4mr29160igb.9.1411224378684;
        Sat, 20 Sep 2014 07:46:18 -0700 (PDT)
X-BeenThere: gitolite@googlegroups.com
Received: by 10.50.221.99 with SMTP id qd3ls1055088igc.40.gmail; Sat, 20 Sep
 2014 07:46:17 -0700 (PDT)
X-Received: by 10.66.227.135 with SMTP id sa7mr1951074pac.19.1411224377747;
        Sat, 20 Sep 2014 07:46:17 -0700 (PDT)
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com [2607:f8b0:4001:c03::234])
        by gmr-mx.google.com with ESMTPS id f14si392148igt.0.2014.09.20.07.46.17
        for <gitolite@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Sep 2014 07:46:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of lathama@gmail.com designates 2607:f8b0:4001:c03::234 as permitted sender) client-ip=2607:f8b0:4001:c03::234;
Received: by mail-ie0-f180.google.com with SMTP id ar1so2246332iec.11
        for <gitolite@googlegroups.com>; Sat, 20 Sep 2014 07:46:17 -0700 (PDT)
X-Received: by 10.50.85.38 with SMTP id e6mr3341064igz.5.1411224377602; Sat,
 20 Sep 2014 07:46:17 -0700 (PDT)
Received: by 10.64.102.164 with HTTP; Sat, 20 Sep 2014 07:46:17 -0700 (PDT)
In-Reply-To: <541D860A.9040203@gmail.com>
X-Original-Sender: lathama@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of lathama@gmail.com designates 2607:f8b0:4001:c03::234
 as permitted sender) smtp.mail=lathama@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list gitolite@googlegroups.com; contact gitolite+owners@googlegroups.com
List-ID: <gitolite.googlegroups.com>
X-Google-Group-Id: 373658679585
List-Post: <http://groups.google.com/group/gitolite/post>, <mailto:gitolite@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:gitolite+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/gitolite
Sender: gitolite@googlegroups.com
List-Subscribe: <http://groups.google.com/group/gitolite/subscribe>, <mailto:gitolite+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+373658679585+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/gitolite/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257325>

Sitaram

Looks good and can be very useful. I can even image some edge cases of
using this in automation. Will have to find the time to test this.

On Sat, Sep 20, 2014 at 8:50 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Hi all,
>
> I've just created a general purpose TOTP "gatekeeper" that is designed
> to gate access to any service on any server/OS (as long as traffic can
> only go *through* the TOTP gatekeeper).
>
> The inspiration was Konstantin Ryabitsev's implementation of two-factor
> authentication for kernel.org -- from which I got the idea of "use TOTP
> to whitelist an IP for some time".
>
> I then extended it to protect any TCP port on any server behind the
> gatekeeper.  http://gitolite.com/totport/ is the documentation, and the
> source is linked there.
>
> I'd welcome any feedback but please be mindful of the fact that deep
> discussion may veer way off-topic for the git or gitolite mailing lists,
> although I hope I won't get flak for *this* email :-)
>
> sitaram
>
> --
> You received this message because you are subscribed to the Google Groups "gitolite" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to gitolite+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
~ Andrew "lathama" Latham lathama@lathama.com http://lathama.net ~

-- 
You received this message because you are subscribed to the Google Groups "gitolite" group.
To unsubscribe from this group and stop receiving emails from it, send an email to gitolite+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
