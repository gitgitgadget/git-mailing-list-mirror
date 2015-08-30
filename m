From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 10:14:39 +0200
Message-ID: <CAHYJk3TAUFT4qnD23ug4gw41PJH+Ncj8CKTsDJnn-PH5z3GoWA@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
	<CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
	<CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
	<CANy2qHdsd=nsg5OMyg3POaT-_H6PXwrycCSpzAQbJ9=oBmpR_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:14:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVxlH-0003lL-D5
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 10:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbbH3IOm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 04:14:42 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35145 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbbH3IOk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 04:14:40 -0400
Received: by qgeb6 with SMTP id b6so5269697qge.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1H8b3/49Y355VLFtcAM9wxmNzhGRh0iAImzAY7rZrQ8=;
        b=Sz49/hWaIaQat1/WHvWS7Pj6A2fMz+A6XJ67yllEKUitlFlwxz4ZEDk8y5Zzv0jRT7
         eH53o9FgrowAUJtCghXHA08wS1JUldNtj/Zm78KQMh8n7okazrETFE/foB51NrJBaKfj
         51v8MyTuweJfSPZPhxOOE/LjJ+eC4XBmzLC5lN84rJOMUtBa9hZQkfg8XKLSX1hzezOp
         UUJwYDUVbfsOwEWG2eJ8kUV2oC5qYwq0f+mhrNRsy6qyhtGZdrM2YC8QqoQ7o1BQF6X+
         jIcNfqJGI8OypZGt0v4rrIl+9/vuM4wTDrMJbJa0bGQ4k7XIfT1+rQCTHS3nzV6rX8iP
         PR/A==
X-Received: by 10.140.147.85 with SMTP id 82mr30462490qht.90.1440922479730;
 Sun, 30 Aug 2015 01:14:39 -0700 (PDT)
Received: by 10.55.20.139 with HTTP; Sun, 30 Aug 2015 01:14:39 -0700 (PDT)
In-Reply-To: <CANy2qHdsd=nsg5OMyg3POaT-_H6PXwrycCSpzAQbJ9=oBmpR_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276811>

On Sun, Aug 30, 2015 at 10:11 AM, Gabor Bernat <bernat@primeranks.net> =
wrote:
> this can work instead of the data command for getting the time
> elapsed, however for getting the actual date of a timestamp is not
> possible generally; so I think I will just remove that part.
> Bern=C3=A1t G=C3=81BOR
>
>
> On Sun, Aug 30, 2015 at 10:04 AM, Mikael Magnusson <mikachu@gmail.com=
> wrote:
>> On Sun, Aug 30, 2015 at 5:15 AM, Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>>> (Please don't top-post on this list.)

Ah, I got caught up on the ETA part. Do note that date +%s is also a
gnu extension and won't work everywhere.

--=20
Mikael Magnusson
