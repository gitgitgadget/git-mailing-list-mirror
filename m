From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 15:50:29 +0100
Message-ID: <AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
	<alpine.LFD.2.00.1009040040030.19366@xanadu.home>
	<5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 04 16:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oru4r-0003e3-8R
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 16:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542Ab0IDOuj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 10:50:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56589 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab0IDOui convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 10:50:38 -0400
Received: by vws3 with SMTP id 3so2142461vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7hvaaLvvUvQAg/6TCFGO3R93gJGG+tdhUpgBOYNZOoE=;
        b=nFTnlOvIoC5K4aPbBVRN+TtN1Tw6ak+TPvh5Zrzhw8Zn3FFBpK3Uka6O9wpxAG4wCk
         dELJuevIqJO6yf5evOTMDJGL69hgv8NMGczNg9ODLbb+9tRN7dw3x5YRrFNaKi730R8X
         hf7v17hS+030QsCROiQzs8MjstSQO5Jil2tWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LoYEfJ8KrTjvNJ8+7dA0V3+SAMN+IsL/DmEWO0egE1X+zLchjWQrkbZKYBWGIjun8N
         bw2EQlixDykRLIrPUcl+w/M1c8RcE/EUEEcCQibOgM+2X+XYc2p8+BXUVHHIksVH1NR6
         pYc49hxEmsBiXacyEfLMrgyOaYJh1WD9l6tsM=
Received: by 10.220.123.218 with SMTP id q26mr1379932vcr.107.1283611830060;
 Sat, 04 Sep 2010 07:50:30 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 07:50:29 -0700 (PDT)
In-Reply-To: <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155330>

On Sat, Sep 4, 2010 at 1:00 PM, Theodore Tso <tytso@mit.edu> wrote:

> such as ebook DRM liberation scripts (the kind which today
> are typically distributed via pastebin's :-), my guess is that
> zipping up a git repository and dropping it on a standard
> bittorrent server run by the Swedish Pirate party is going to
> be much more effective. =C2=A0 :-)

:)  the legality or illegality isn't interesting - or is a... red
herring, being one of the unfortunate anarchistic-word-associations
with the concept of "file sharing".  the robustness and convenience
aspects - to developers not users - is where it gets reaaally
interesting.

 i do not know of a single free software development tool - not a
single one - which is peer-to-peer distributed.  just... none.  what
does that say??  and we have people bitching about how great but
non-free skype is.  there seems to be a complete lack of understanding
of the benefits of peer-to-peer infrastructure in the free software
community as a whole, and a complete lack of interest in the benefits,
too - perhaps for reasons no more complex than the tools don't exist
so it's catch-22, and the fact that the word "distributed" is
_already_ associated with the likes of SMTP, DNS and "git" so
everybody thinks "we're okay, jack, go play with your nice dreams of
p2p networking, we're gonna write _real_ code now".

=2E.. mmmm :)

l.
