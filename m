From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 3 Nov 2011 12:09:55 -0700
Message-ID: <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Thu Nov 03 20:10:32 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RM2gH-0005Sq-Pi
	for lnx-linux-ide@lo.gmane.org; Thu, 03 Nov 2011 20:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934501Ab1KCTKU (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Thu, 3 Nov 2011 15:10:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37408 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934290Ab1KCTKR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2011 15:10:17 -0400
Received: by wwi36 with SMTP id 36so2336398wwi.1
        for <multiple recipients>; Thu, 03 Nov 2011 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=uKdWocDkWx/F9eKVdEUDn5nJ5fYpyKk894EI389ml+k=;
        b=xpETsiz11CawhMvJvfOHWoflNmLWjMYWFAwt/60SUNGjMdpx5nR5h3YuyEE0ENZSgm
         FM89y/FlRywexKpXYkEWcSHlucB6CqIFKx6ClDZ9qHNJKdExuxqe37c8cMXLqKfWdSxR
         oP3EiC4+TIoZd2P5fHUxz5ATECecDsyiFVPQ4=
Received: by 10.216.24.39 with SMTP id w39mr8056361wew.67.1320347416066; Thu,
 03 Nov 2011 12:10:16 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Thu, 3 Nov 2011 12:09:55 -0700 (PDT)
In-Reply-To: <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: WZhkkxt63TUW865aKC3sZR6nvXQ
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184739>

On Thu, Nov 3, 2011 at 11:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ahh, sorry for the noise. I realize that we already have a winner, namely,
> the proposal outlined in your message I was responding to.

No, no, don't consider my "put in the merge message" a winner at all.

I personally dislike it, and don't really think it's a wonderful thing
at all. I really does have real downsides:

 - internal signatures really *are* a disaster for maintenance. You
can never fix them if they need fixing (and "need fixing" may well be
"you want to re-sign things after a repository format change")

 - they are ugly as heck, and you really don't want to see them in
99.999% of all cases.

So putting those things iin the merge commit message may have some
upsides, but it has tons of downsides too.

I think your refs/audit/ idea should be given real thought, because
maybe that's the right idea.

                           Linus
