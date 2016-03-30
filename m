From: Stefan Beller <sbeller@google.com>
Subject: Re: weird diff output?
Date: Wed, 30 Mar 2016 12:40:42 -0700
Message-ID: <CAGZ79kbk5T5SdSzfZ8Q6TQmXgiG+ZSUYc5E7_95KtariDU8MHQ@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
	<CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
	<xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
	<CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
	<20160330045554.GA11007@sigill.intra.peff.net>
	<CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
	<CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
	<CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:41:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLzB-00074G-Us
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbcC3Tkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:40:45 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38360 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbcC3Tko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:40:44 -0400
Received: by mail-ig0-f180.google.com with SMTP id ui10so41686169igc.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LF3t9rhkUKnDU9UU5q07sXXQhKqEOLXzO0+eZ94hkho=;
        b=W6HkX8rUVUHDvlXqzTrw7aXH774AoUV46ZXX9CYDGt7VAHAJV7C35229ibVg7BXWUB
         WOLeT4LMiiWpqSrSn0VrKTlCwa0m6XxM4R/sZz7+jDvTjsrj19wUxrBbD/CbLSWhruze
         y0wntU5BDJ3w3o0EqgBaDsFR6GkCMiTqsZhNeAhm/VC2NS1hfX1JxZ0Pl1hy69OL4QWN
         NcV7Z8QkKUUrnFwEctjrQ8CWf0uhszIhcPfsll21rsXcvXrt5A9uOhcGuYpMghb/zRc3
         9c7h/RPJgj3cAioBdqlZa9xkIhXWiqlI9YNj3r29gfIqm7wsilpIOvn8NjgG77y9Qz1z
         MMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LF3t9rhkUKnDU9UU5q07sXXQhKqEOLXzO0+eZ94hkho=;
        b=EKqMlvXGcc2nVdRtHblmGHLC12qmMohx/2J+no7cSs+dRDW34YI+0mE78nLXH6GPVb
         mHbqNGs8QClV5QCdT5SyGfRvPf1PLBQ1OOTuqwYXPkwb0h+9Kw89EjMgTjUeC8ULODke
         TYxFlFgpDuLMBTgxkojwSwrVoqMg+1Th5iA+yIaAqq8J2SU0+fYTd/kd89fvP32WQaIr
         Y2Eczm3F6PWtIZlchQVf203KRJx2hxc9mG8iodppA4ft2Y7HKeV8D/EuJ6C04M+6H6mX
         NumHbrOsSftnfP354yXO11WrwpCbuS2SIeWpsPvq8aK32A0dt+1YCZm5O1s8FJyQSDiF
         U5hw==
X-Gm-Message-State: AD7BkJKIqE730CQo9vGsMaqdWlskDkR9DKopJcLf9fo73myUzoR6Mox5cLT05s7pBo8E3A3QxPQvYT2Vd0swc5dd
X-Received: by 10.50.28.105 with SMTP id a9mr25829913igh.94.1459366843012;
 Wed, 30 Mar 2016 12:40:43 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 30 Mar 2016 12:40:42 -0700 (PDT)
In-Reply-To: <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290342>

On Wed, Mar 30, 2016 at 12:31 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>
>           If unsure, say Y.
> +
> +config RMI4_I2C
> +       tristate "RMI4 I2C Support"
> +       depends on RMI4_CORE && I2C
> +       help
> +         Say Y here if you want to support RMI4 devices connected to an I2C
> +         bus.
> +
> +         If unsure, say Y.
>
> after:
>
>           required for all RMI4 device support.
>
> +         If unsure, say Y.
> +
> +config RMI4_I2C
> +       tristate "RMI4 I2C Support"
> +       depends on RMI4_CORE && I2C
> +       help
> +         Say Y here if you want to support RMI4 devices connected to an I2C
> +         bus.
> +
>           If unsure, say Y.

The optimum would be:

  >
  >           If unsure, say Y.
  >
  > +config RMI4_I2C
  > +       tristate "RMI4 I2C Support"
  > +       depends on RMI4_CORE && I2C
  > +       help
  > +         Say Y here if you want to support RMI4 devices connected to an I2C
  > +         bus.
  > +
  > +         If unsure, say Y.
  > +
  >  config BLA_I2C

The overlapping lines:
  > +
  > +         If unsure, say Y.
  > +

However that broke the lines at the first empty line, not the last
as Jeff claimed it. (Could there be a problem in the perl script when
empty lines are at the first or last overlapping line?)

Thanks for going through examples!
(I would, too. But fixing a submodule regression is more important
now; I only develop new features when there are no known regressions
caused by me)

Thanks,
Stefan

>
> So in this particular instance which has multiple blank lines and is a
> similar issue as with Stefan's note above, this is where the heuristic
> falls apart. At least for C code this is basically vanishingly small
> compared to the number of comment header fix ups.
>
> I think it may be that Stefan's suggestions above may be on the right
> track to resolve that too.
>
> Regards,
> Jake
