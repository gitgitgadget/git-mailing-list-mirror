From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: add CC to TRACK_CFLAGS
Date: Mon, 20 Sep 2010 13:38:05 +0000
Message-ID: <AANLkTikLCFb3GrMxP7dLPB=eggc2w6FOq=7ZpdSYpnki@mail.gmail.com>
References: <1284331065-3394-1-git-send-email-avarab@gmail.com>
	<AANLkTikBP3pJ7ZN9jC9yQeVKssgr2KMpaY-nQtpJZiP-@mail.gmail.com>
	<7viq21uqzb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 15:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxgaC-00082k-D3
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 15:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485Ab0ITNi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 09:38:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57351 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab0ITNi5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 09:38:57 -0400
Received: by iwn5 with SMTP id 5so4287921iwn.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lj7evtT95zHdKxdY5dl0Lx6kVTznu+UJMhb8aQ1dFU4=;
        b=J9s+39YGqgQjhfgC/ESIRojG18xZePDlBRf6lMkvY5MoDi1ZVnl4his5UFExaVVv4o
         ce63HzSC02z1A7gNVtOMVO4dg0lcg3DIiWX1JUZREeV0eC+pWXgnxRNcBaFOHsQy/HHW
         nVDnOmj/NIWYAvKFGIBBd57NzkiER9qqxAqPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VqYBi4iy391n2JRls4WAG2ts3xWi8YeZ/YhXSTSMdhsxgcHMW55Uiq17NKjTXecfxn
         d85awVia/xmIMAhik2WM/5hLegeaOXSf54oF3fpkuGNd4TBwg5rzdf311HFKB08R+iZF
         pdwd2e5TsYF73z41HGUOXqzbh7BLyv88teoh4=
Received: by 10.231.169.10 with SMTP id w10mr10418395iby.106.1284989886174;
 Mon, 20 Sep 2010 06:38:06 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 06:38:05 -0700 (PDT)
In-Reply-To: <7viq21uqzb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156622>

On Mon, Sep 20, 2010 at 01:46, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Is there a reason for why this didn't get picked up other than falli=
ng
>> through the cracks?
>
> Simply because I wasn't actively collecting new topics during feature
> freeze, especially for small stuff that I knew that resending after
> release would be trivial and more efficient use of my time than queui=
ng it
> in 'pu' and having to look at it every time I do another push-out in =
order
> to decide when to merge it to 'next'.

Rigth, I have no problem doing $whatever to get patches in, but the
problem I often have is that I don't know what state things are in,
and what I'm supposed to do at any given time.

E.g. in this case I submitted the "send-email: use catfile() to
concatenate files" patch 2 days after this one, that one got into the
next "What's cooking in git.git" post.

Since both were trivial fixes and there was no comment on this one I
was inclined to think that it just fell through.

Should I generally re-send patches that I've sent, haven't had
comments, and haven't appeared in subsequent "What's cooking in
git.git" posts (given that some reasonable amount of time has passed
since the original send) ?

Then there's stuff like my "git-am: Ignore whitespace before patches"
which had some comments, but which *I* still think is OK as-is. Should
I just keep pushing stuff like that until someone tells me to stop?

Thanks, from a list member somewhat confused about the patch queue :)
