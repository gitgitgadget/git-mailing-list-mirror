From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2 17/20] transport-helper: change import semantics
Date: Mon, 4 Jul 2011 13:20:20 +0200
Message-ID: <CAGdFq_iTojuvVAdB6sC7-Kro9E49q_1Lfh87Yy4nR5BTdZ1eaA@mail.gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-18-git-send-email-srabbelier@gmail.com> <20110619233822.GJ23893@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 13:21:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdhD8-0003cL-Ds
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 13:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab1GDLVB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jul 2011 07:21:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40969 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab1GDLVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2011 07:21:00 -0400
Received: by pzk9 with SMTP id 9so1594754pzk.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U2x4Rg6gTozGrRJ5R+E85cmJnNs7AK9NNtUq6pSwZzs=;
        b=iFDq9hR8IoIRuljs6LUzdQGqTjEQbRceGL1w0NpnNly/kLgGzY0n/HNDryDtSTZ+4y
         QyW0deG7Y8OHIJrwfxMTRldQ38H3WNvs5jIF2AvSkxhwjHIJqlGOu2GlCV9AdBB+xED9
         xmeeOh25cns1TexM4riyD0iAI2iMft+yOlnBo=
Received: by 10.68.7.6 with SMTP id f6mr3826234pba.234.1309778460051; Mon, 04
 Jul 2011 04:21:00 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Mon, 4 Jul 2011 04:20:20 -0700 (PDT)
In-Reply-To: <20110619233822.GJ23893@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176596>

Heya,

On Mon, Jun 20, 2011 at 01:38, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> I think that for learnability, it would be better to use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0import <ref>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0import <ref>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[blank line]
>
> since that is consistent with "fetch" and "push". =C2=A0I'll try mock=
ing up
> a patch for that tonight.

That would mean the only change compared to the current behavior is
the additional blank line, yes?

--=20
Cheers,

Sverre Rabbelier
