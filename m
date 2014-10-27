From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH][RFC] grep: add color.grep.matchcontext and color.grep.matchselected
Date: Tue, 28 Oct 2014 10:32:23 +1100
Message-ID: <CAKJhZwRShbV14=BihxiTzayR4kg3GaAPN_NFXwFZ-4kAD-QHTA@mail.gmail.com>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>
	<544D3A3C.4080906@web.de>
	<544E8D89.3030201@web.de>
	<xmqqy4s1s44h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 00:32:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xitm0-00053H-74
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 00:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbaJ0XcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 19:32:24 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37593 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaJ0XcY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 19:32:24 -0400
Received: by mail-ig0-f169.google.com with SMTP id a13so1493261igq.4
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bmSHS8xEModVEC3Tk8Mtv2rD9VFWzUCgCDcEoeaocmk=;
        b=kjDWYRCRjkfkzq1mYPJVc2PMeukOHQP+OkLOCmROxDkkdzCma6i15yUHVYf+WKqeGF
         Ut5E0dwEw1TEYrnW2h9II7+QUA9qIBQ3IyM+YwwT2NdKpEIxPNIGaH7am2FgvyU5VpPB
         k/Zk8tqbz9eXaNiIglVOT2OgzsJ4sk14uu52plavaqbZTyFTJuyFY44sJ4WWy2KEmez1
         bqdFDD/RRJlUmzjqZXFhyDKGAeqH2LAKuhGbk+GfxFSIdQw7YFjIVO3deOWPCvHo74Vu
         a1ILhE98YbogCfM+6xCsfR5RgxVDiMu8Ib8XGF8OTAyFd1wzhiDd2qinuCr+Cq533NFU
         chmA==
X-Received: by 10.42.250.17 with SMTP id mm17mr533773icb.18.1414452743315;
 Mon, 27 Oct 2014 16:32:23 -0700 (PDT)
Received: by 10.50.163.66 with HTTP; Mon, 27 Oct 2014 16:32:23 -0700 (PDT)
In-Reply-To: <xmqqy4s1s44h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I like Ren=C3=A9's approach, too. It's more flexible, supports the old
behaviour and it scratches my itch as well.
Don't mind if you dropped my patch and used Ren=C3=A9's instead.

>> Only *very* lightly tested, and a test for t/is missing anyway.  Jus=
t
>> wanted to quickly show what I meant.  You'd set color.grep.matchCont=
ext=3D""
>> to turn off highlighting in context lines.  What do you think?
>
> I didn't realize that people wanted to see pieces on non-matching
> lines highlighted.  It makes certain sense, e.g. it would allow you
> to spot near-misses, but that is only true for lines that neighbour
> real hits, so...
>
> I like this approach better in that it makes those who want a
> different behaviour to do the work without breaking the expectation
> of those who are used to the established behaviour.
>
> Zoltan?
