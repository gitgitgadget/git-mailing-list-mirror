From: Stefan Beller <sbeller@google.com>
Subject: Re: weird diff output?
Date: Tue, 12 Apr 2016 12:34:21 -0700
Message-ID: <CAGZ79kZ+JgVNSvJ+tZwGqP-L-NVUv8hmd1jsbh71F08F5AqsjA@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	<xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
	<CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
	<20160330045554.GA11007@sigill.intra.peff.net>
	<CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
	<CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
	<CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
	<20160331134750.GA29790@sigill.intra.peff.net>
	<CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>, davidel@xmailserver.org
X-From: git-owner@vger.kernel.org Tue Apr 12 21:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq44x-0004dn-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 21:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbcDLTeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 15:34:23 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34422 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcDLTeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 15:34:22 -0400
Received: by mail-io0-f171.google.com with SMTP id 2so42148892ioy.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ugQW5Ji4V4atxCSLmqbDgWBASLMiaj/K4cktT+oI1aw=;
        b=otJy5xLqLg9SQ0GaqOSrngMGI2HH7Ceh2+gPKwBV7AxEzBuvO70D+pxrS6ZYtY4LHI
         ugx1J5WCobJA8/kycvodfp0IfXJKKJ/qUlL3z48Kq/zCM0u7Y8QEta/N9T0/RrSfv8sh
         214vvvTjq5LL5qfdlrfyrVnHYzhG2YsAEZltU9lX0vDQ0G6Ws9m7hltuxwO2WXRHagC1
         4EPthVdQPPd87xp7vwJJAFnCaIT6LfotQfaQJ35c6fYLF6qEBNQ16eJmXTSVEyEjeSPB
         Us3rjdS/EQq9SEeRyDVQPuYvDu9JBdRb6L8x1T7lYXBr8Cil7rcVCiLDA7+2Haqfdq2B
         ljtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ugQW5Ji4V4atxCSLmqbDgWBASLMiaj/K4cktT+oI1aw=;
        b=jz7/emsnU6BzqVX4iBMOl8SkBJ0HMksNLkvzs4bIw02a4K84F6bd4dfd4AHw3k3EBz
         xW6dgnouBoHypJ/Y32JDMKWgbesk9kX+XGSaXnkMdg6tifbwfOnAzdYSnHM8faVZqVOU
         9moHag5fSyyeqAd7+dnSPT2lPrkVhDYHO/NuM/XoJHYi/lI41sYNo2pg4MMwTa/vAu58
         d3Qz3ZnxpdfUDg8/sZ4e+BKNSLPHtA1Vf4shxCNi5HKtXdUe9diOYMcBRG8WvLQq26Na
         1IbK5sWz3ofV2qkoQyEt5vB9KJ8nmIHasj/PPn04mmRIaTBfjdB/gTEwzFH2uNDsZzu5
         lSPQ==
X-Gm-Message-State: AOPr4FVRBusbRtKUlCXcAyM04G8GsKW2DDEPaekUJ7J2s/y28kaZ/yykF5U4KIfVA7aeqUiExHRIS5hr+V5/L3e+
X-Received: by 10.107.184.8 with SMTP id i8mr5912788iof.96.1460489661793; Tue,
 12 Apr 2016 12:34:21 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 12 Apr 2016 12:34:21 -0700 (PDT)
In-Reply-To: <CA+P7+xpX_xR9wVdRPgymXe0wRjDY2USRx2PyWJMKTjAepWpP+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291289>

On Wed, Apr 6, 2016 at 10:47 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
> I started attempting to implement this heuristic within xdiff, but I
> am at a loss as to how xdiff actually works. I suspect this would go
> in xdi_change_compact or after it, but I really don't understand how
> xdiff represents the diffs at all...

I agree that this seems like the right place.

On the off chance that David, the author of xdiff remembers that
part, I cc'd him. (The whole discussion on better diffs is found at
http://thread.gmane.org/gmane.comp.version-control.git/290093)

Thanks,
Stefan



>
> Thanks,
> Jake
