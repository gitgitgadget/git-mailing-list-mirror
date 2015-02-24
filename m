From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 10:25:12 -0800
Message-ID: <CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org> <vpqioerz03s.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: msysgit+bncBCG77UMM3EJRBHMEWOTQKGQES45QQOQ@googlegroups.com Tue Feb 24 19:25:35 2015
Return-path: <msysgit+bncBCG77UMM3EJRBHMEWOTQKGQES45QQOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oi0-f57.google.com ([209.85.218.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBHMEWOTQKGQES45QQOQ@googlegroups.com>)
	id 1YQKAo-0001u7-8h
	for gcvm-msysgit@m.gmane.org; Tue, 24 Feb 2015 19:25:34 +0100
Received: by mail-oi0-f57.google.com with SMTP id g201sf6464514oib.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:list-subscribe:list-unsubscribe;
        bh=SqdYZH5WQp4Nb/Ndr2S4uc+skp7f2Rbdk1qwJBWoPD8=;
        b=Md3QvgNxC2aTVG5qzMiHAs4TV8QdokimXisIE2FiSlNJyQcyYEEBIA4ElUCG/IBQks
         Eq8Yox24Xm7VPJUpfTPaaL27SFfH3gTaSHok1IUEcHxwMyVuMoj1aGZqz26ePQwDq9op
         5q7PilKyHNE76kKXtedWh3bEMlgo9hxmg8tC6wxffbamWJx2Zhw7N+j8Vbgwxptpu/pZ
         ohMU3KmvS47oEn/HDBFX+ZV/Vwt0xwNW7QKCB5BwzWTwB5MvNIrbcAekRWAx/pdgHAbv
         xVHd9NFQMthgK105tyhibKdZ+tSDDma3zGYQe306YEQHqVY9dGOsO5o0KAl5FSKobHRC
         pGhQ==
X-Received: by 10.140.101.51 with SMTP id t48mr207635qge.10.1424802333565;
        Tue, 24 Feb 2015 10:25:33 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.105.164 with SMTP id c33ls2962361qgf.66.gmail; Tue, 24 Feb
 2015 10:25:33 -0800 (PST)
X-Received: by 10.236.45.38 with SMTP id o26mr17973420yhb.32.1424802333042;
        Tue, 24 Feb 2015 10:25:33 -0800 (PST)
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com. [2607:f8b0:4003:c01::22b])
        by gmr-mx.google.com with ESMTPS id ux1si1423094igb.1.2015.02.24.10.25.33
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 10:25:33 -0800 (PST)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4003:c01::22b as permitted sender) client-ip=2607:f8b0:4003:c01::22b;
Received: by mail-ob0-f171.google.com with SMTP id gq1so45257318obb.2
        for <msysgit@googlegroups.com>; Tue, 24 Feb 2015 10:25:32 -0800 (PST)
X-Received: by 10.182.210.197 with SMTP id mw5mr12217662obc.26.1424802332633;
 Tue, 24 Feb 2015 10:25:32 -0800 (PST)
Sender: msysgit@googlegroups.com
Received: by 10.202.48.132 with HTTP; Tue, 24 Feb 2015 10:25:12 -0800 (PST)
In-Reply-To: <vpqioerz03s.fsf@anie.imag.fr>
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2607:f8b0:4003:c01::22b
 as permitted sender) smtp.mail=jch2355@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264335>

On Tue, Feb 24, 2015 at 9:32 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> About the proposal:
>
>   The idea of this project is to dive into the Git source code and
>   convert, say, git-add--interactive.perl and/or git stash into proper C
>   code, making it a so-called "built-in".
>
> My advice would be to try converting several small scripts, and avoid
> targetting a big one....
> add--interactive and stash are relatively complex beasts, perhaps
> git-pull.sh would be easier to start with.

Yeah, I think that is a very good suggestion.

Also drop "proper" as if scripted Porcelains are second class citizens ;-)

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
