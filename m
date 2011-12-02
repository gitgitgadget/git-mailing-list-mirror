From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Proposal: create meaningful aliases for git reset's hard/soft/mixed
Date: Fri, 2 Dec 2011 15:27:13 +0100
Message-ID: <CAGK7Mr7zdstbm7QsrYq9a6m9ui_r8Ak8XtyWADLQ0n-mXiov4w@mail.gmail.com>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org> <CAGK7Mr5nQoubAw11KDj4WKwQnXrfgteKbMj2=AR-HhsGKi52wQ@mail.gmail.com>
 <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 02 15:27:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWU5e-0000Fy-CP
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 15:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736Ab1LBO1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Dec 2011 09:27:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48943 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab1LBO1o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2011 09:27:44 -0500
Received: by iage36 with SMTP id e36so4259792iag.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fDPabhfVbaCJnya1pUSpmXFida5pkt8u7E3wgpdQst4=;
        b=KedwNeU6sJrWVnXrdLHe4v1fPucBmlSBGMwILnKqlSOd3n2+YdWAq8Z6B1BzzSJFgN
         Oxj03xtxnHyRPDVqI0RaXF6oLtwS1jOyGxTyJncccA1DLIzr5whOYXY2b+HoRZTmOGe3
         LLP+8t8VKArgwjlpyLo/BMPtkNbi77yummyXU=
Received: by 10.231.28.28 with SMTP id k28mr3046894ibc.61.1322836064132; Fri,
 02 Dec 2011 06:27:44 -0800 (PST)
Received: by 10.50.189.166 with HTTP; Fri, 2 Dec 2011 06:27:13 -0800 (PST)
In-Reply-To: <CABURp0rtCUbJXLHtXv_1g6GRKL3mX-T+3vN1=QO4CUibqXdEMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186220>

> > Why worse? I'd understand if you said it's doesn't improve it enoug=
h
> > for it to be worth the change tho.
>
> I think that's what "you should aim higher" means.

Yes, but my question was why was the proposal _worse_ in his mind.
Anyway, it's not really important, probably something he typed in a
hurry.


> How about:
> =A0--soft: git checkout -B <commit>
> =A0--mixed: git reset -- <paths>
> =A0--hard: =A0git checkout --clean

I like the idea... but as other pointed out those are not equivalent.

Maybe we'd start by listing the features we want to be able to do:

- Move git's HEAD to a particular commit without touching the files or =
the index
- Move git's HEAD to a particular commit and clear the index but
without touching the files
- Move git's HEAD to a particular commit and clear the index and have
all the files match that particular commit files
- Move git's HEAD to a particular commit and clear the index and have
all the files match that particular commit files and remove files that
are unknown to that commit

Is there a scenario I'm missing? Once we have the scenarios nailed
down we can start thinking about how to express them.

Philippe
