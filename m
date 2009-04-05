From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 22:05:22 +0200
Message-ID: <fabb9a1e0904051305m66b08c44y23129469198bfd0b@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> 
	<fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> 
	<7vvdpjrkp0.fsf@gitster.siamese.dyndns.org> <fabb9a1e0904051206l11a629cald95a794815c2d76f@mail.gmail.com> 
	<20090405195908.GB4716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYca-00054H-2f
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163AbZDEUFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758187AbZDEUFl
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:05:41 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50799 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758186AbZDEUFk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 16:05:40 -0400
Received: by fxm2 with SMTP id 2so1623270fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5pjo7KdfTt5093Uu40xJIYlxaaI79Xb0EXHCIYCfFTQ=;
        b=G63HbI3uob+yLlETO2xFt5trNstHK9qN2HRrsuw4+tnZC0hpb0zrRtal+fEKRvJb8U
         uGdtHsDQzaNJYPL1ZScC8Qlu8RsllaL68IV4xN7KhI8NTTVfLd/jh+Mr+umphUcGv5qt
         W/XKQlEAEY0DeEQyg0iyDHR2LDWwIOhRLtNLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aXBLGawoUC/qw7YD/cQedKv15WyIXpTnleK+Fv9BJwGn0fv3LiQr+sF3WyZ77dOv2a
         wk/lRto2O0bZKesX906gmhRjMk/KpCdMlmtH94ufdY6mrA2xtmS2NzhZPKgbGp0Az11b
         /thDwEI0n5TYGYJWBKKIjhq+/979SyqxUHcL4=
In-Reply-To: <20090405195908.GB4716@coredump.intra.peff.net>
Received: by 10.103.92.8 with SMTP id u8mr1612950mul.34.1238961937251; Sun, 05 
	Apr 2009 13:05:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115695>

Heya,

On Sun, Apr 5, 2009 at 21:59, Jeff King <peff@peff.net> wrote:
> =A0die("BUG: assertion failed in binary search")

Given that we now only have one binary search (which should be re-used
everywhere), I think it's fair enough to describe it like that.

> However, if this "oops" has been there for 2 years and nobody has see=
n
> it, it's entirely possible that somebody actually got the binary sear=
ch
> code right in the first place. ;)

Hehe, never underestimate the difficulty of writing a proper binary
search! :P But I do agree two years of 'testing' is more than more
binary searches get before being 'released' ;).

--=20
Cheers,

Sverre Rabbelier
