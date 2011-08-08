From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 14/18] reset: Make reset remove the sequencer state
Date: Mon, 8 Aug 2011 13:50:22 +0530
Message-ID: <CALkWK0nGp3pAE1vqqHfEqX-vons15YOxJKBVVz7o4ffs11Zudw@mail.gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
 <1312454356-3070-15-git-send-email-artagnon@gmail.com> <CAP8UFD0FfPqFpp1Fvg+ESkt1euqua6n_WPa3BSoyBEkNrOrFvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 10:20:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqL4r-0002hR-0A
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 10:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab1HHIUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 04:20:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57362 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1HHIUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 04:20:43 -0400
Received: by wyg24 with SMTP id 24so612560wyg.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vDUji52vxeQ5MiA9pqZ7MzKZJiykXP4hKadkUOSz3TY=;
        b=oHAIOVDl3luM6DwT+ExLrkoBfGj+gTx+a0JjncrF9yut+/Z6jEAnk8WPqjHyOTBZRJ
         PLKWXxGqsaNmoNOX4I8X44yiUEnBuxEPdTr3Vozo2poHcDrL28jUkybGJ/svkDPlHVZB
         jsUUBGilhmy0Igg9O5VuXuk0P3aXMDslZscoM=
Received: by 10.216.160.4 with SMTP id t4mr82282wek.109.1312791642390; Mon, 08
 Aug 2011 01:20:42 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 8 Aug 2011 01:20:22 -0700 (PDT)
In-Reply-To: <CAP8UFD0FfPqFpp1Fvg+ESkt1euqua6n_WPa3BSoyBEkNrOrFvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178946>

Hi Christian,

Christian Couder writes:
> On Thursday 04 August 2011 12:39:12 Ramkumar Ramachandra wrote:
>> =C2=A0create mode 100755 t/7106-reset-sequence.sh
>
> The name of the new test file should be "t7106-reset-sequence.sh" ins=
tead of
> "7106-reset-sequence.sh".

Ugh, right.
Junio: Could you kindly squash the following patch in before merging
the series into 'next'?  I hope it's not too late.

p.s- I'm pleasantly surprised to see no diff.

--8<--
Subject: [PATCH] fixup! reset: Make reset remove the sequencer state


Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 ...6-reset-sequence.sh =3D> t7106-reset-sequence.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{7106-reset-sequence.sh =3D> t7106-reset-sequence.sh} (100%)

diff --git a/t/7106-reset-sequence.sh b/t/t7106-reset-sequence.sh
similarity index 100%
rename from t/7106-reset-sequence.sh
rename to t/t7106-reset-sequence.sh
--=20
1.7.6.351.gb35ac.dirty
