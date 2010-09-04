From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 13:44:30 +0100
Message-ID: <AANLkTi=F4RLbCPwoUGTAUFzqBuPFuM4qiAdpkrrGmntn@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Sep 04 14:44:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ors6o-0001CZ-JQ
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 14:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0IDMod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 08:44:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53513 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0IDMoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 08:44:32 -0400
Received: by vws3 with SMTP id 3so2081774vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7JXP3JVqlpZrDKi8Di+J04b1PqR/fUVDxcH+XuEOeoo=;
        b=JXKSjF2liqgOvCmRjHipAwZqq2CENWAIMamBSny5BLpUteRVxTBgGFYXIJgu7OFHkl
         aCDWtbC5euiad/gUxMhceeD8nsSY5oPlkBUO7ypqpMui121jQ3h0/g/yT3rdhd6RmP9r
         0xSMceucKOAfMOr2u4182PNbfOFV2TuYMINpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v7j1lAfsGkPM4CPkNqYlD7jjb1hLYqU6HXpw9t8loYk8PqWDzQITLBSmjP/knrfmxw
         ved0SWrC2TENhNp28hyLXQESZ6R85pCsyKsDXInnOhmCGU1ONjQqvpb2XY9lao1JG+Rw
         FUWlPy9woYYOHf0EAk2iXrznUzLvtR1VRq0Sw=
Received: by 10.220.168.12 with SMTP id s12mr1587036vcy.100.1283604270448;
 Sat, 04 Sep 2010 05:44:30 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 05:44:30 -0700 (PDT)
In-Reply-To: <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155323>

On Sat, Sep 4, 2010 at 1:00 PM, Theodore Tso <tytso@mit.edu> wrote:

> Quite frankly, I'm a little dubious about how critical peer2peer real=
ly is, for pretty much any use case. =C2=A0Most of the time, I can grab=
 the base "reference" tree and drop it on my laptop before I go off the=
 grid and have to rely on EDGE or some other slow networking technology=
=2E

 yes... but if you meet up with other people, where you have a fast
LAN segment or set up your own private wifi mesh, are you able to a)
sync up the mailing lists using git b) sync up the project's bug-list
using git c) sync up the wiki (if there is one) using git d)
seamlessly continue to appear to be talking (with the people you're
meeting) on the "mailing lists" as if you actually had a decent
connection to the server e) report, comment on, change the status of
and share bugs between all of the people you're meeting as if you had
a decent connection to the bugtracker server...

you see how it's not just about "The Source Code"?  sure, yes, you or
anyone else _on their own_ can do code development, isolated from
everyone else and the internet...

example: i went to europython, and met the moinmoin developers (nice
people).  i wanted to help with the sprint after hours: it turned out
that we'd got the day wrong, so we then went "oh well, let's find
somewhere to do a bit of hacking", and _immediately_ the discussion
turned into "how we can all of us find internet connectivity".  i said
that i had a 3G USB but i didn't have ndiswrapper installed for the
bcm4328 on my laptop, so i couldn't offer a mesh; someone else said
that their laptop's WIFI didn't even _do_ master-mode, and we then had
a nice discussion about various little network routers that ran
openwrt and lamented the fact that none of us had brought one along.

needless to say, we didn't do any hacking :)

l.
