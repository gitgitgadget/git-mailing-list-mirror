From: Marko Kreen <markokr@gmail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 17:32:59 +0300
Message-ID: <AANLkTilsqlqX0f8_LhXBssCGMuTdS_mCw7V3lVrMb4XK@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
	<AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
	<AANLkTiko_Azw-cXNFe11oXkijvtER2I9qiRE_gVFouht@mail.gmail.com>
	<AANLkTikDcZRHpKp9phlThK5x-8A0OfTYIlhGkqookiFj@mail.gmail.com>
	<AANLkTil-nMo5E2laacYm48-HGbhseEICWsUHwTlc3l47@mail.gmail.com>
	<AANLkTimo2P3JIJ2zhD3QtT2wgfr4WmXPkVVxUDpiOfJH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 16:33:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHe8y-0002bX-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab0E0OdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 10:33:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56955 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0E0OdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 10:33:00 -0400
Received: by gyg13 with SMTP id 13so4066172gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=CMUsbFlmb5FziCTizzAV15LKva5UZoA0HTepuKDtiaE=;
        b=q75rQJPcTN64n2zOFotGuIhbCPGPNYp8NyXx82P55Wt6UMUdL6d3MF2Lu8nv/lmAO+
         ZpFcQ+1RLXGIq5cDmly55O1ZxdOGETkAkvRS/8xWTrIzb8jrun2+TLTp9Wed4grNGlnE
         lwl8Ch2gX9c2J/PO1KSVspbDmT8gQ0eWkTA44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jVojpzYqQK+AoyL+/VSxjcbe4k4E9oRF2m0Tg6F8vgrdwKm3mJbD9f+u2UiZZ8oQdw
         vHr5b2CAp3azf/rIw+8NyrtpQhQ0Dy6S2X+kLFn2PUE4gYPzMP7IBc7A63+NQN5x1bof
         Qf5l8JXfK8SslcuX+on5YIOjXi9eIaJTOCisA=
Received: by 10.150.165.6 with SMTP id n6mr205973ybe.412.1274970779529; Thu, 
	27 May 2010 07:32:59 -0700 (PDT)
Received: by 10.151.48.11 with HTTP; Thu, 27 May 2010 07:32:59 -0700 (PDT)
In-Reply-To: <AANLkTimo2P3JIJ2zhD3QtT2wgfr4WmXPkVVxUDpiOfJH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147864>

On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 4:11 PM, Marko Kreen <markokr@gmail.com> wrote:
>  > On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>  >> On Thu, May 27, 2010 at 3:58 PM, Marko Kreen <markokr@gmail.com> wrote:
>  >>  > On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>  >>  >> On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gmail.com> wrote:
>  >>  >>  > On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>  >>  >>  >> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>  >>  >>  >>  <kusmabite@googlemail.com> wrote:
>  >>  >>  >>  > On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>  >>  >>  >>  >> Implement the subset of poll() semantics needed by git in terms of
>  >>  >>  >>  >> select(), for use by the Interix port.  Inspired by commit 6ed807f
>  >>  >>  >>  >> (Windows: A rudimentary poll() emulation, 2007-12-01).
>  >>  >>  >>  >>
>  >>  >>  >>  >
>  >>  >>  >>  > A possible problem with this approach is that the maximum number of
>  >>  >>  >>  > file descriptors poll can handle limited by RLIMIT_NOFILE, whereas the
>  >>  >>  >>  > maximum number of file descriptors select can handle is limited by
>  >>  >>  >>  > FD_SETSIZE.
>  >>  >>  >>  >
>  >>  >>  >>  > I don't think this is a big problem in reality, though - both values
>  >>  >>  >>  > seem to be pretty high in most implementations. And IIRC git-daemon is
>  >>  >>  >>  > the only one who needs more than 2, and it doesn't even check
>  >>  >>  >>  > RLIMIT_NOFILE.
>  >>  >>  >>  >
>  >>  >>  >>
>  >>  >>  >>
>  >>  >>  >> To be clear: I think this strategy is the best option (at least for
>  >>  >>  >>  non-Windows, where select() might be our only option).
>  >>  >>  >>
>  >>  >>  >>  But perhaps you should include a check along the lines of this:
>  >>  >>  >>
>  >>  >>  >>  if (nfds > FD_SETSIZE)
>  >>  >>  >>         return errno = EINVAL, error("poll: nfds must be below %d", FD_SETSIZE);
>  >>  >>  >>
>  >>  >>  >>  Just so we can know when the code fails :)
>  >>  >>  >
>  >>  >>  > Well, per your own FD_SET example, the FD_SETSIZE on windows
>  >>  >>  > means different thing than FD_SETSIZE on old-style bitmap-based
>  >>  >>  > select() implementation.
>  >>  >>  >
>  >>  >>  > On Unix, it's max fd number + 1, on windows it's max count.
>  >>  >>  >
>  >>  >>
>  >>  >>
>  >>  >> Are you sure this applies for all Unix, not just some given Unix-y system?
>  >>  >
>  >>  > Not sure.  Just pointing out that the above check is not
>  >>  > universal enough.
>  >>  >
>  >>
>  >>
>  >> Isn't it? How could one possibly pass more than max fd number + 1 file
>  >>  descriptors, since they start at 0? I guess one could specify a given
>  >>  fd more than once, but that'd be kind of redundant... and also very
>  >>  unlikely in our case ;)
>  >
>  > Pass one fd with value 70 it.  Check returns error, although
>  > everything would work.
>  >
>
>
> No, not with the check I posted. I checked nfds, not the value of the
>  fds themselves. nfds is clearly the size of the fds array -- if it
>  wasn't, it'd be impossible for the poll-implementation to know how big
>  the array is!

Ah, ok.  I though this is the nfds for select().  In this case it can
still fail, as nfds=1 for poll() can still go over FD_SETSIZE for
select() if the fd value is big enough.  On non-windows, that is.

Dunno if this matters for git-daemon..

-- 
marko
