From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 17:02:24 +0700
Message-ID: <CACsJy8CU5N+3rMh1Png=8YQNMb5s8JT9Py9FdLekae6Dkds3BQ@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org> <vpqioerz03s.fsf@anie.imag.fr>
 <CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
 <c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org> <vpqh9uavp6q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: msysgit+bncBC2ZN5PHQUMBBT53W2TQKGQEDUESCEQ@googlegroups.com Wed Feb 25 11:02:57 2015
Return-path: <msysgit+bncBC2ZN5PHQUMBBT53W2TQKGQEDUESCEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f188.google.com ([209.85.213.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBT53W2TQKGQEDUESCEQ@googlegroups.com>)
	id 1YQYnw-0007MB-I1
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 11:02:56 +0100
Received: by mail-ig0-f188.google.com with SMTP id a13sf970022igq.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Feb 2015 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe;
        bh=rgUWI9C+hQufj4XYUkx6TZ+yMpRoJt0x6cSRAgjcmVY=;
        b=NUoVOAFibQceVeoNtax1uPO31Iwruu5S2GcDnIJFJkL8lB6595sIvU8b0asYZ/oD8a
         exwbLygbz5MUxYzztjG7z4XIdOh/64NkZx5JB/jif7MhNJrDnglYudhIJ4dJnWvzcHkC
         YmJ+Ec3VxR5aV2gwOB18Z8ed2qgQ2A3t5JKBgliNMF/ND4e9PxSC6wM2n50VabujADqr
         uaNKEdmxw1dn5TwkwmKHt4o/5Mdc3J+Tc8Rj2JwdLTmIPR9UON9HETqFD8M/sBctSJET
         4eDkzD5i69s+38aPgIpTsUTBWHHWof20rDR5V4oGq04HWgLneM797KlpgTHtDxkb/U8Z
         B3fA==
X-Received: by 10.140.109.66 with SMTP id k60mr30251qgf.36.1424858575840;
        Wed, 25 Feb 2015 02:02:55 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.72.20 with SMTP id l20ls3337034qgc.2.gmail; Wed, 25 Feb
 2015 02:02:55 -0800 (PST)
X-Received: by 10.236.26.17 with SMTP id b17mr2266671yha.15.1424858575124;
        Wed, 25 Feb 2015 02:02:55 -0800 (PST)
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com. [2607:f8b0:4001:c05::236])
        by gmr-mx.google.com with ESMTPS id nt6si1337690igb.2.2015.02.25.02.02.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 02:02:55 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c05::236 as permitted sender) client-ip=2607:f8b0:4001:c05::236;
Received: by mail-ig0-x236.google.com with SMTP id h15so4466981igd.3
        for <msysgit@googlegroups.com>; Wed, 25 Feb 2015 02:02:55 -0800 (PST)
X-Received: by 10.50.107.7 with SMTP id gy7mr3392587igb.49.1424858574986; Wed,
 25 Feb 2015 02:02:54 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Wed, 25 Feb 2015 02:02:24 -0800 (PST)
In-Reply-To: <vpqh9uavp6q.fsf@anie.imag.fr>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:4001:c05::236
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264377>

On Wed, Feb 25, 2015 at 6:56 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> To get an idea, I counted the lines of code written by the student I
> mentored last year:
>
> $ git log --author tanayabh@gmail.com -p | diffstat -s
>  43 files changed, 1225 insertions(+), 367 deletions(-)
>
> I would consider this GSoC as "average" (i.e. not exceptionnally good,
> but certainly not a bad one either), so you may hope for more, but you
> should not _expect_ much more IMHO.
>
> In comparison:
>
> $ wc -l git-add--interactive.perl
> 1654 git-add--interactive.perl
> $ wc -l git-stash.sh
> 617 git-stash.sh
>
> I'd expect a rewrite in C to at least double the number of lines of
> code, so rewriting git-stash would mean writting at least as many lines
> of code as the GSoC above. git-add--interactive.perl would be rather far
> above.
>
> But my point was not to convert _only_ git-pull.sh, but to have a GSoC
> starting with this one and plan more. Then, depending on how it goes,
> you can adjust the target.

Some data point as I have a half-baked builtin/pull.c in my
(forgotten) private branch for 3 years. pull.c has 389 lines (with 24
shell lines left in "#if 0"). git-pull.sh has 340 lines. Let's add 100
C lines  to pull.c when it's complete, that's 50% more lines. But in
the git-pull case the student could get a good head start by reusing
my code, maybe.
-- 
Duy

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
