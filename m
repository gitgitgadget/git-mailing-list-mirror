From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 12:01:24 +0200
Message-ID: <CAGdFq_j2aa8bwxWuJvEsgA_1zkR4mMzoKjGs9TQVqw+0XYr98A@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se> <9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
 <201109261539.33437.mfick@codeaurora.org> <201109261552.04946.mfick@codeaurora.org>
 <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk> <CAGdFq_hvR1MPF33YFcjDCzCM0iOO2zpiiePFFS4dBabu84cwTg@mail.gmail.com>
 <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <davidbarr@google.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 12:02:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8UUO-00060l-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 12:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab1I0KCG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 06:02:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41677 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab1I0KCF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 06:02:05 -0400
Received: by pzk1 with SMTP id 1so17076795pzk.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 03:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mcT4SVb+vX7xzvzKuwuijFnaYqxkAl4RmkkVfLaPYwg=;
        b=WsBBHSzCTxR5FBLRy8dfMbT704ewjgdbFV6IxX8kkPFEHxAsog7w3qGRBrENIME96T
         vaUGmScSYks9OLsEaLyYDN1pHh/d0wF1uLI+5w9gftuFufzt3Kpy9wV4S9zjIM0X25bs
         blwr5DkGpVMOWUA6xx0XyJ1CwnZKgc1umUOJg=
Received: by 10.68.14.102 with SMTP id o6mr36201792pbc.51.1317117724106; Tue,
 27 Sep 2011 03:02:04 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Tue, 27 Sep 2011 03:01:24 -0700 (PDT)
In-Reply-To: <22f055b34840e3c64f3339f7b3dc6920@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182231>

Heya,

On Tue, Sep 27, 2011 at 11:01, Julian Phillips <julian@quantumfyre.co.u=
k> wrote:
> It has to be hot-cache, otherwise time taken to read the refs from di=
sk will
> mean that it is always slow. =C2=A0On my Mac it seems to _always_ be =
slow reading
> the refs from disk, so even the "fast" case still takes ~17m.

Ah, that seems unfortunate. Not sure how to test it then.

--=20
Cheers,

Sverre Rabbelier
