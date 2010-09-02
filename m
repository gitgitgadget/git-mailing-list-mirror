From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 22:19:48 +0100
Message-ID: <AANLkTimTe8_P7uHA6Ytm3+3Ha7rygWHzrSFOUq7fdX-L@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
	<m3y6bjnadu.fsf@localhost.localdomain>
	<AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 23:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrHCd-0006FV-8H
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 23:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758006Ab0IBVTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 17:19:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55867 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757883Ab0IBVTx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 17:19:53 -0400
Received: by vws3 with SMTP id 3so679615vws.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XLAZYEXH0e03SEWnv4kGIIXrfU7q0AVO/mvv4jr0djg=;
        b=wTvPKyixEsHo3HtYkg7c0ukrIzGaCPIHLGk2cVwkB2SDr0pRNN4wByptf3UVWKHtNy
         bVOlNDkVdL/WVknGQvL2Xk+p6tOObNpwqN09L9m3zvs2PR6Kp49iUjkatQz1FViar3wj
         43Slxo12RUiXYNmmSBFZh2XuI9Q3lc6QGBtIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lYODZhQb7zx2v42d9XLCO42TEftBR8ZqIdwx7JojTVTko/WIZwFma5J1ebfALwEUIq
         Tv0XJOm/GN22+2iFqlwg5JBU6lJNf1LVSMPjvuomrKf91airZq8Ormn/klXLwqysEsqm
         Z34UaXktKEgKuxoqhq9KR4JybFT0EMStNP3/A=
Received: by 10.220.87.69 with SMTP id v5mr7730086vcl.133.1283462388331; Thu,
 02 Sep 2010 14:19:48 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 14:19:48 -0700 (PDT)
In-Reply-To: <AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155210>

sorry, shouldn't have hit send so quick.

On Thu, Sep 2, 2010 at 10:10 PM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:

> were talking about? =C2=A0well, here it is *splat* - are you able to
> recreate the pack-object from that, for me, and if so please gimme
> again"

> sooo.... taking a wild guess, here: if you were to parse the .idx fil=
e
> and extract the list of object-refs, and then pass that to "git
> pack-objects --window=3D0 --delta=3D0", would you end up with the exa=
ct
> same pack file, because you'd forced git pack-objects to only return
> that specific list of object-refs?

 becauuuuse... if soooo... then that's a solution!  you get the .idx
file first, you make sure that that's cached (and it's small, isn't
it, so that would be ok), then you transfer it around the network, and
you ask each repo if they can re-create the pack-object from the
contents of the .idx, if they can, blam, they're a seed/sharer for
that pack-object; if they can't, tough titty, they've probably had git
gc run, or had some more commits added, or whatever, and can't
participate, wow big deal, no great loss.

does that fly? :)  if it doesn't fly (with --window=3D0 --delta=3D0) wo=
uld
it be easy to add an option to say "oi, gimme a pack with nothing but
these refs, in exactly this order, no quibbling, no questions, just
gimme"?  and you could call it "the same as the original" because,
duh, it would contain exactly the same objects as the original.

am i even vaaaguely along the right lines? *scratches head*.

l.
