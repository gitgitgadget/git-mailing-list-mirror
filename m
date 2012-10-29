From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 14:24:55 +0100
Message-ID: <CAB9Jk9Ao=T=j=vkiZ-YxQZom353sj42DXEttKfFnwu5x90pWLA@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
	<CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
	<CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
	<508E532F.2010109@alum.mit.edu>
	<20121029103837.GA14614@sigill.intra.peff.net>
	<CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
	<20121029113500.GA15597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 14:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSpL3-0003Yy-2t
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 14:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756760Ab2J2NY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 09:24:57 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:47302 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620Ab2J2NY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 09:24:56 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2431750dak.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rdofD9LvhcPYcPLmucsT5BmXvDi2CL8PokegqzZWH/Q=;
        b=T9fag6bB8mRCM4fyWYsk6GqTa5/v01l6CrVluwZwJ9A8YG5GMDe7ifKixJjgCzYMFl
         Rvl8HRw6BEFzO7gYk9m6omB9bnByngqRBKEGGHhm7qY3OP9KHfuHWR/FP6wfN1YWdRlE
         sjZYKvch9Jiqx4msBBBRF9tADPNQf30xn8nI/4+j2zgdtFXEGMyPZWD99Ur0XU8FJwe8
         ZM/F93ka92Whlb205LNx2IN343RxQ/yJdWjwz6dOPwySgLKzjJvDrPoYqp4f7aXi5Vnc
         kmvMHAx2SAtu03fh8h+JnGRt1SCoygb15I6UhrLKsyFAif357AEdJ+zs1hYgrQ18bjPq
         eBKQ==
Received: by 10.66.83.9 with SMTP id m9mr83288121pay.22.1351517095504; Mon, 29
 Oct 2012 06:24:55 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Mon, 29 Oct 2012 06:24:55 -0700 (PDT)
In-Reply-To: <20121029113500.GA15597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208623>

Jeff,

> Then on top of that we can talk about what lightweight tags should do.
> I'm not sure.

If tags (even the lightweight ones) do not behave differently from
branches, then they are of no use, and the main difference is that
they do not move. So, I would suggest not to move them either.

-Angelo
