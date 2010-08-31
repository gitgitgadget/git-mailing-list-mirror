From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 11:42:38 +0000
Message-ID: <AANLkTikuQZpOjddgHtpSpw-P4AeL1swsrzJzd5cE7e8F@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<alpine.DEB.2.00.1008311205280.28446@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Aug 31 13:42:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqPEs-0006Dt-70
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 13:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab0HaLmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 07:42:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49732 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab0HaLmj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 07:42:39 -0400
Received: by gwj17 with SMTP id 17so2465016gwj.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 04:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nsenphk3LUnv1aGtpCwue2qctb2RSwLLAMCOycQsDLk=;
        b=uOKieSMFB/55B31PXGBkKpnQDKKjRfe0aoUPBDpHhjpiqZowvWNe87dL9rzulyNjVX
         4aykNRmxO8rsI4bWsgwX1ib7CeY8TQfFUnBUJM7MDELF3RxO+6G7jYB1BNHS9JO8RGQh
         IlbjPrMd6CUKN7ayfAKlsEqqpaP1i4rOL7sFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jFk+EJs34zjJn5JsNyRTAgdBmc8JsI6G0np6QQwRbk2EhhF5KF7txj8emIS5S3VJJj
         IEFGybB6xtLy0YmAEwzcM2Qz7x4Pka36XjU4gR/Hxlvpkovb8kRUfYpURCyz9iJpuFu2
         w2r49YFixWeFaWTONTEfoGXhwo5W9Na/AN1fQ=
Received: by 10.101.165.35 with SMTP id s35mr6211501ano.258.1283254958761;
 Tue, 31 Aug 2010 04:42:38 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 04:42:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1008311205280.28446@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154893>

On Tue, Aug 31, 2010 at 11:08, Peter Krefting <peter@softwolves.pp.se> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> With it applied git-init is the one and only utility of the porcelai=
n
>> that's translatable. The series includes a translation of it into Ic=
elandic
>> and Polish.
>
> Very interesting. I would like to contribute a Swedish translation as=
 time
> permits.

Great!

> Any chance the translations could be co-ordinated through Translation
> Project <URL:http://translationproject.org/>? I know I suggested this=
, and
> was turned down, for gitk and git-gui, but this translation is potent=
ially
> larger and could benefit from the co-ordinated effort.

Something like that would be welcome. Personally I'm happy with
editing *.po files locally with Emacs's po-mode, but to get more
translators we probably want a friendly web interface like that at
some point. Preferably with an active translation community.

I meant to look at this myself at some point, but if you could help
that'd be great!

The only reference I could find to a previous git +
translationproject.org discussion was this:
http://kerneltrap.org/mailarchive/git/2008/3/14/1163164 Is that the
one you're talking about?

I've used Launchpad somewhat for translating and it's friendly to
contributors & has an active community, but it seems to require that
we BSD-license our translations[1], which would be a showstopper since
we'd have to contact everyone who's been submitting GPL-2-only strings
to Git for the last 5 years.

Translationproject seems to have a similar requirement[2], but they
seem require you to send a letter to the FSF through snail mail before
you can contribute (maybe not, I didn't read all their docs
carefully). That would be a major hurdle to casual contributors.

1. https://help.launchpad.net/Translations/LicensingFAQ
2. http://translationproject.org/disclaim.txt
