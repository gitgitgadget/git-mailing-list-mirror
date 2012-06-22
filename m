From: Leila <muhtasib@gmail.com>
Subject: Re: [PATCH/RFC] Documentation and Code: Fix misspellings and grammar
Date: Fri, 22 Jun 2012 19:24:56 -0400
Message-ID: <CAA3EhHJx7N=T77CRb=SfqOmaEFf8bHN5NZdx1u=q6+0d-fQcpA@mail.gmail.com>
References: <1340404814-29790-1-git-send-email-muhtasib@gmail.com> <7vd34rlzxk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 01:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiDEB-0004dN-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 01:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310Ab2FVXZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 19:25:18 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:46058 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2FVXZR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 19:25:17 -0400
Received: by vbbff1 with SMTP id ff1so1132263vbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=C2PGwiT7tMdLKj8kiSEV/t/3NLyfA8qdMluFbCt1EVE=;
        b=BCWW0qCbdKBXBS1td1W1LzgT2ePBAuuwMVuO466l4VIkdHuZcob27g4eiKQr5eFRou
         cLsV1FKmuyBRvpI6xghXpnNdkec4K5HoNxw3S32Bsqi4r8d/n0mYU5Idvm0xIlfWJion
         vlyzIccp4y4Rd6WOvY67EWz231Qz7gTy/YdN7uX5x/prwWEENn78IiVBdZYD8oE/DVNb
         bpGiLTZpJg2OVEZaTz4nKmk2B7BYbIfpDnyiKX60dn2uGWUsAGAEXe+WlBbMdUgV7/kv
         XNycrmCVPKcBZOXmqhBHEGeFRnblW3Z6YYnIPQM4y/b0fK1Okj2IYCTW2c086qEtRUm7
         QQ3g==
Received: by 10.220.214.139 with SMTP id ha11mr2050202vcb.16.1340407517070;
 Fri, 22 Jun 2012 16:25:17 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Fri, 22 Jun 2012 16:24:56 -0700 (PDT)
In-Reply-To: <7vd34rlzxk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200486>

On Fri, Jun 22, 2012 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I am tempted to suggest "one word per patch" ;-)

I can do that, no problem. That's my preference too.

>
> Also you might want to take a look at
>
> =A0 =A0http://thread.gmane.org/gmane.comp.version-control.git/199033

Context is important, I agree.

>
>> Do you think it's a problem to fix misspellings in printf output?
>
> It depends, but in a sense, typos in comments are a lot lower
> priority (nobody is hurt if we do not fix them, and if such a fix
> interferes with topics in flight, it is more nuisance than it is
> worth and it would be greatly appreciated if you hold off typofixes
> until the dust settles).
>

That makes total sense. I'll hold off on typos in comments. Actually,
the only reason I included them was because they showed up when I did
a 'git grep <misspelled word>', so I went ahead and fixed everything.
How do I know when the dust has settled? Is that after you release a
version? 1.7.11 released on June 17, so that wasn't that long ago?


> Program output affects the end user experience, so it is more
> important.
>
> Changes to strings marked with _() for l10n should come early in the
> development cycle so that translators have enough time to prepare
> for it before the release.

Are we early in the dev cycle? Should I prepare a separate patch with
just the misspellings that affect end user experience?

Thanks!
Leila
