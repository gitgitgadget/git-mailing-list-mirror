From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Fri, 14 Mar 2014 10:51:53 -0400
Message-ID: <CALs4jVHcPFjf-12mXvvSxctNJZgLD=P3=57u6_FYePDOB7txQQ@mail.gmail.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net> <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
 <20140312194943.GA2912@sigill.intra.peff.net> <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
 <20140312211415.GA10305@sigill.intra.peff.net> <20140312220640.GA14802@sigill.intra.peff.net>
 <xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com> <CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
 <20140314045758.GA32748@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 15:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOTTB-0000uF-0t
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 15:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbaCNOwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2014 10:52:15 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:41137 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbaCNOwO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2014 10:52:14 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so2898428veb.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=z7UCLZ/rAShaX/TdWKbXgObR2pgtbxSBL2DRZUj/3Z8=;
        b=xSyp0XsKBnm0GuFZLqm/7/DbSO6MtGGs7MWN9LyzWY31zisGHffvskjafo5qNOdomW
         Zv3udOUsXzRrVfHlfHeUuUV981JJwVJP8akcjC3O/b88w1bob0FPnt7N9PWcTrE1+B1L
         /h53J09uMPZchwrmGB2DuTv2OPw85FodoOKPQHmlPUV5Q+FPtQOcTHAwQzYfvhTengPh
         zofYIzyW3k3u04UDXrQ79muClL5N71H7EflDS8ShR5tBRGQN/TWwIbHiflxQJFLhz5Z0
         a3ZH5vrC53AjAt2vBH8Q809xC5td4XJZhZ99NGniOl9EmqxvrwLMXNmqFAz1E4Wfce8r
         SwbQ==
X-Received: by 10.52.137.143 with SMTP id qi15mr367677vdb.39.1394808733839;
 Fri, 14 Mar 2014 07:52:13 -0700 (PDT)
Received: by 10.58.228.34 with HTTP; Fri, 14 Mar 2014 07:51:53 -0700 (PDT)
In-Reply-To: <20140314045758.GA32748@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244090>

2014-03-14 0:57 GMT-04:00 Jeff King <peff@peff.net>:
> This discussion ended up encompassing a lot of other related cleanups=
=2E I
> hope we didn't scare you away. :)

I don't think you could; this community is much more accepting than
other software communities around the web. The fact that I received
constructive feedback rather than a lecture when formatting issues
slipped my mind (i.e. forgetting [PATCH v2]) is reason enough to stick
around!

> My understanding is that you were approaching this as a micro-project
> for GSoC. I'd love it if you want to pick up and run with some of the
> ideas discussed here. But as far as a microproject goes, I think it
> would make sense to identify one or two no-brainer improvement spots =
by
> hand, and submit a patch with just those (and I think Junio gave some
> good guidelines in his reply).

I agree with trying to push a few uncontroversial changes through. I'd
love to take a deeper look at these helper functions and related
cleanups=E2=80=A6perhaps it would be worth it to identify a few key are=
as to
work on in addition to a main GSoC project? In fact, the project I'm
looking to take on (rebase --interactive) also involves code cleanup
and might not take all summer, so I could see how those could work
well together in a proposal.

I'll be re-reading this thread and working on this patch over the
weekend to try to identify the more straightforward hunks I could
submit in a patch.

Thanks Peff and everyone else for your help.
Quint
