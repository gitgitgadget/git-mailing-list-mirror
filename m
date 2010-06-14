From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: vger doesn't like UTF-8 from send-email
Date: Mon, 14 Jun 2010 13:57:21 +0200
Message-ID: <AANLkTinH7p6_WV1FK7UTZLg-8OGINZFnYMA1kENb6PkW@mail.gmail.com>
References: <20100612000002.GA30196@neumann>
	<cover.1276336602.git.trast@student.ethz.ch>
	<201006121211.12870.trast@student.ethz.ch>
	<AANLkTim1QajqLOp4y6-oIMAGp8Tkf7z9uTH6bwIIFYkH@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 13:57:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO8ID-0002Uq-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 13:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab0FNL5Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 07:57:24 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36088 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab0FNL5X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 07:57:23 -0400
Received: by wwb18 with SMTP id 18so3732341wwb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=1R44+4S3M0Sn/hdXkloUHphoWv3CDUdE4gHMpKGMRK8=;
        b=kZISJ0PEGVruBzRdxkjfOPlSL/GnV96f6UfWSIjeM6hH12KWflT1Z59fTHUSFWFxpK
         Ed8n8nYY+xgW8jIkDBI1Bn0QJgiH82cvMg0FhL5K/3rkwr52A+9kMt506xdcrXX6/pZm
         k/hGD0y/hTK/oA12Cwf5f9uYFLku4X99T7hT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=bl85dRJeWIDhrpVT77SaWbjPZ8+u96WporrLkV95ClCX30hgZwN0zOOfTiNcrXvXSH
         LQIQ9PwWka82QQ/Ese0KAQPhv+3Ne/Egi9m+0COWDxWFNEuw5jWri8Llg0PrAAqkwVZQ
         hLz5qL1mDmO4zCa5XZHuTjkCtO2exg2/EinRI=
Received: by 10.216.155.65 with SMTP id i43mr2156421wek.98.1276516641678; Mon, 
	14 Jun 2010 04:57:21 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Mon, 14 Jun 2010 04:57:21 -0700 (PDT)
In-Reply-To: <AANLkTim1QajqLOp4y6-oIMAGp8Tkf7z9uTH6bwIIFYkH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149090>

On Sun, Jun 13, 2010 at 6:15 AM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Sat, Jun 12, 2010 at 05:11, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> AFAICT the original message did not declare an encoding:
>>
>> Subject: [PATCH v2 0/2] bash completion: Support "divergence from up=
stream" warnings in __git_ps1
>> Date: Sat, 12 Jun 2010 12:02:14 +0200
>> Message-ID: <cover.1276336602.git.trast@student.ethz.ch>
>> X-Mailer: git-send-email 1.7.1.561.g94582
>> In-Reply-To: <20100612000002.GA30196@neumann>
>> References: <20100612000002.GA30196@neumann>
>> MIME-Version: 1.0
>> Content-Type: text/plain
>> Return-Path: trast@student.ethz.ch
>> ...
>> Is this a new vger policy, or am I hitting a send-email bug?
>
> Let's assume the headers themselves are already properly encoded.
>
> According to:
>
> =A0 =A0http://www.faqs.org/rfcs/rfc2045.html
>
> we have:
>
> =A0 =A0The proper Content-Transfer-Encoding
> =A0 =A0label must always be used.
>
> and:
>
> =A0 =A0An encoding type of 7BIT requires that
> =A0 =A0the body is already in a 7bit mail-ready
> =A0 =A0representation. =A0This is the default value
> =A0 =A0-- that is, "Content-Transfer-Encoding: 7BIT"
> =A0 =A0is assumed if the Content-Transfer-Encoding
> =A0 =A0header field is not present.
>
> Moreover, according to:
>
> =A0 =A0http://www.faqs.org/rfcs/rfc2046.html
>
> we have:
>
> =A0 =A04.1.2 =A0 =A0Charset Parameter
> =A0 =A0...
> =A0 =A0The default character set, which must be
> =A0 =A0assumed in the absence of a charset parameter,
> =A0 =A0is US-ASCII.
>
> So, your email is indeed incorrect in 2 ways if the body contains
> UTF-8 encoded data.
>
> From what I've skimmed, the mail user agent (MUA)---such as
> send-email---could send your unmodified message body by producing
> these headers:
>
> =A0 =A0MIME-Version: 1.0
> =A0 =A0Content-type: text/plain; charset=3Dutf-8
> =A0 =A0Content-transfer-encoding: 8bit
>
> but only 7bit transfer encodings are guaranteed to make it intact to
> the destination; consequently, it would probably be a good idea for
> the MUA to transform your message into some 7bit encoding, preferably
> a human-readable one such as the 'quoted-printable' encoding; after
> such a transformation, the headers could be:
>
> =A0 =A0MIME-Version: 1.0
> =A0 =A0Content-type: text/plain; charset=3Dutf-8
> =A0 =A0Content-transfer-encoding: quoted-printable
>

QP-encoding is sometimes destructive, and as such not recommended for
patches - in fact, Documentation/SubmittingPatches forbid it. For the
cover-letter the destruction might not be an issue (IIRC it's some
line-feeds that might be added because QP can a line longer than the
maximum line-length), but special casing the encoding for
cover-letters doesn't strike me as The Right Thing To Do(tm).

I think the only real alternative to 8-bit encoding is Base64, and it
sacrifices human-readability. Dunno how bad that is, though.

--=20
Erik "kusma" Faye-Lund
