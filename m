From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 19:36:21 -0500
Message-ID: <CAMP44s3WPUW3z-1Jthfr7R-xw1ufiub4vA8j9jXuk-cpO1hwVQ@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpSt-0002lk-RX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab3IIAgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:36:24 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:52378 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3IIAgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:36:23 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so4309593lab.22
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hQbHodJz9jDxaqAhWwH1zgZV6lVxDKXl6xkueQlJ28I=;
        b=FgrXOPgfZlVRY0ZCKa/+6rT855u6d8SpIBgBtntCbAoAhJzNb4VnpazzS+BxVU7Ng7
         bXgKnPxz+gw9HFNaL+fOHFp0G5J7CZ0+m2lkZBCAEZK2/TLG5Qpu8EVELFegYnOpz2u/
         ln8WWCk538+FVe+93q5PDFF+0PU5Q6UGbRjkdpQZMi6IAW7SPjiQsK1hsWyWPgQwgeE+
         31jFQXG9XUg9suKhfmkRTwmXsqxYpwXJravkL20XZjfh9UNaKe64YmuMHd2Y7nmJ9uvv
         HGBNfgUzoMS0WfUYqzz1bmPEqQRANT2/VdxWzYCh7pnZ8Aq2AmlYMjkDvQWs8MMMErsY
         mjVA==
X-Received: by 10.112.167.3 with SMTP id zk3mr3990726lbb.23.1378686981477;
 Sun, 08 Sep 2013 17:36:21 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 17:36:21 -0700 (PDT)
In-Reply-To: <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234290>

On Sun, Sep 8, 2013 at 7:29 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> My patches pretty much do nothing else but introduce a warning.
> Nothing is broken, nothing is changed in the test suite:
>
> http://article.gmane.org/gmane.comp.version-control.git/233669
>
> You are confusing my proposal with Junio's one.

Actually my mistake. My patches don't even add a warning, so nothing
is changed at all (unless you manually configure pull.mode =
merge-ff-only).

I only suggested to add the warning, but didn't actually implement it.
I'll do that soon.

-- 
Felipe Contreras
