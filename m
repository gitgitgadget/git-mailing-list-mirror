From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: clean bug on ignored subdirectories with no tracked files?
Date: Mon, 21 Nov 2011 15:03:43 -0500
Message-ID: <CAG+J_DzBgQTdCoj8Y185+=+SpMMYgPXQXkta=o-Rson2xL8ytQ@mail.gmail.com>
References: <CAG+J_Dxw00e_cr7i3R9DAbTrqZvJHYk2yeUa=xGKh+Zqqmp-SA@mail.gmail.com>
	<7vy5vbj4rb.fsf@alter.siamese.dyndns.org>
	<CAG+J_DwKeWntmi22vHS6CRud6Lo0P_+D5u5ih2Bbc50ekYji5w@mail.gmail.com>
	<7vy5v9fgel.fsf@alter.siamese.dyndns.org>
	<7vty5xff6l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 21:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSa5o-0008Rn-KG
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 21:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598Ab1KUUDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Nov 2011 15:03:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49168 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab1KUUDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 15:03:44 -0500
Received: by ggnr5 with SMTP id r5so2743054ggn.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WXR+JlSntPqj7Fk0TE7ccCvQkkVG4zyOIpSFd+mGV8s=;
        b=sSvT6zoe4x6oreGP1DHNR/zRIE4e9T9ONVSN4haz0ULI2/xUAOGQ4Yo5i17h2Hd9Ie
         /2Of/V3y3RwVSlS7OKbzJ+nIwLUZDsdSbeVk4F956RK5f0ANSdrqe30gLPVlrVbmIiA/
         RhzHMwhb1AxcoMbtt9wRyNaKbElubKhXFzBUo=
Received: by 10.236.155.36 with SMTP id i24mr12384818yhk.43.1321905824050;
 Mon, 21 Nov 2011 12:03:44 -0800 (PST)
Received: by 10.146.1.15 with HTTP; Mon, 21 Nov 2011 12:03:43 -0800 (PST)
In-Reply-To: <7vty5xff6l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185760>

On Mon, Nov 21, 2011 at 2:28 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "clean" without "-x" is meant to preserve untracked but expendable pa=
ths
> (e.g. build products), so if something is removed that is untracked b=
ut
> matches the ignore pattern, then that is a bug to be fixed. =C2=A0Car=
e to roll
> a patch to fix it?

Okay, just confirming it is a bug. I'll add this e-mail to my todo
list, but I don't have time for a patch anytime soon. :-(

> Sorry for the confusion, but as I said, I do not use (hence nor care =
much
> about) "clean" myself, so...

Okay.

j.
