From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 1/4] t5541-http-push: add test for chunked
Date: Wed, 4 May 2011 01:18:34 +0800
Message-ID: <BANLkTi=MQYSR5_wwswtpeM-gn61znVeoaw@mail.gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
	<1304437649-7052-2-git-send-email-rctay89@gmail.com>
	<BANLkTimmQAUKXfe3SntpDpKjc8XhEpjeJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dan McGee <dpmcgee@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 03 19:18:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJFB-0001Hg-4D
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab1ECRSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 13:18:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51071 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab1ECRSe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 13:18:34 -0400
Received: by iwn34 with SMTP id 34so247552iwn.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8W0v6KbbkHboB2vX3I6AMHoXmrzxBaLU/84EP9KDP20=;
        b=qgAWW+a+9Q67RLVqxZAE7E3B0QMXc29czyxh948VDobTfLY4f5fQ0/qDS7kPhj+856
         Vw/vaUPlMlcaK2YpAYXPXNGcnMA+FMpq1XOticZMrN2nCdLGZnealIk+VaxzAgi6Bp93
         GUdqus6eIQzGYEryo6cFt0eb+HBsKka/tzDrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TInTMYqpaLZ+EP56jp4qLtZwkk5AjBxHWsaQ2i/lbeRafYp4IN5gizmaeH9Ij8m/fU
         IhY8sWeD3URgLIWQkEs6QV2l1bc0+6AHAKEWY/CAGRy2JhJTmFiePNw4A19TI0D+fZF2
         69UC4ZiMtNx9O6V+UdWstp37C2fNNkajclRZE=
Received: by 10.42.172.133 with SMTP id n5mr186878icz.66.1304443114146; Tue,
 03 May 2011 10:18:34 -0700 (PDT)
Received: by 10.42.146.199 with HTTP; Tue, 3 May 2011 10:18:34 -0700 (PDT)
In-Reply-To: <BANLkTimmQAUKXfe3SntpDpKjc8XhEpjeJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172672>

On Wed, May 4, 2011 at 12:32 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Tue, May 3, 2011 at 08:47, Tay Ray Chuan <rctay89@gmail.com> wrote=
:
>> Trigger the chunked type of pushing for smart HTTP. This can serve a=
s a
>> regression test for the issue fixed in 1e41827 (http: clear POSTFIEL=
DS
>> when initializing a slot).
> ...
>> + =A0 =A0 =A0 # to trigger chunked pushing, we need a sufficiently l=
arge pack - use
>> + =A0 =A0 =A0 # git v0.99
>
> The better way to trigger this is to set http.postBuffer to something
> very small, e.g. "4".

Ah, thanks for the tip.

--=20
Cheers,
Ray Chuan
