From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 11:18:02 -0700
Message-ID: <CA+55aFzEVy6BsVzTrYda3Nfo4o+QtqiqsX5xJqRt=se0eREDsA@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
	<20160421170815.GA10783@sigill.intra.peff.net>
	<CA+55aFyadCxX_Ws5fUC0QXwYYyaAjC5TC=y+tVA+YUHX1o+-iQ@mail.gmail.com>
	<20160421180507.GA12950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:18:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atJB8-0000qZ-EE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 20:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbcDUSSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 14:18:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35267 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbcDUSSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 14:18:03 -0400
Received: by mail-io0-f194.google.com with SMTP id u185so11600320iod.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Y01+iqaUz2JAOi37V2hKtXCQrwVra5j4DvojXt/yJV4=;
        b=V9GLDEhdfla1GDT2giuY7eAvKEDDX3+OoxnBSjphUJc7RyWYFOH7UsXPpdBIZ2Acxb
         pDDeQUercajTpOpnE0nMEOk8HFrDhht7MJnRp1g1fapX/591w04LwwSX2PfccRjbCH+J
         VKBKdw9xACsiu38q40iyNmQUyPHKMw0VIIcpmdY6loLTL0Sf+maH08jkc5lncidE43Aa
         fyyaqrdVzXbX6u81cgB+HN1xdwq7R5ISb8aBlwUEF6N1Cq5aGykFy2kTlX/9cZl/xVpm
         XZk7lBGp2sU/c0yUqsBFLK5hX/hZZGUmmxgfnoGsFEsmOtCSQeVHnhkMy/kN40wZmznS
         b2KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Y01+iqaUz2JAOi37V2hKtXCQrwVra5j4DvojXt/yJV4=;
        b=X1Eu2fCuzcb1RWhxPWgN91ZmjT7LxY3en1YeDTrUZTFId3N/4YyZmtVPvQyUPNKOTY
         0OyyS4l/joQ4t5t6XhsQ8cX4VS5Zs6XsfCKjATa+cbmn/jHlNIpPOqw89r9Uecyq4i/+
         nMi5W5O3bMCdqP14s2ye55gtaZLh8Gwp77Nms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Y01+iqaUz2JAOi37V2hKtXCQrwVra5j4DvojXt/yJV4=;
        b=HguQRqw0UrU/fZWpHWyFvhzliEpbq9vcl0HWbizz0nqhR+sQ1ZCPQjtvYwoKoFa++B
         FlcIutUV8T5XWiD7JpP5wzYE1DMN7eboAX/mwKwV6yhioXJ84+zp1JqJ1w4Gr+SXB0+0
         AW27buRjvSGApoShuPtKLzcJSnkCu7Rp0YfVamDNi+s0ErxcDoxT6alzXS6iIbQ/3TtK
         lJXcOTfrPfhrwAQThjW74G3XaxHcVrmL3AlkQAuV11iWcwO35Jc+pNB5zlw4y/Z5z0M4
         bAQ/5KvLcHHCdpXImZLhcqqKZ1cbwfmTwDlEXCOi9toP5UcBzZFu0K/L0axDSs+kVDLH
         G+aQ==
X-Gm-Message-State: AOPr4FWwtnwtNBmqLpNmU1SlCQ1CwJYMuIgV24ip4aP5s/HS4aQJrtofa6HsDiVuUTJSUubK7CMHbj8DILS2zQ==
X-Received: by 10.107.23.131 with SMTP id 125mr19026612iox.186.1461262682330;
 Thu, 21 Apr 2016 11:18:02 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 11:18:02 -0700 (PDT)
In-Reply-To: <20160421180507.GA12950@sigill.intra.peff.net>
X-Google-Sender-Auth: YQDWbYEMc74wwCXw6jw8SwlCkeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292140>

On Thu, Apr 21, 2016 at 11:05 AM, Jeff King <peff@peff.net> wrote:
>
> I actually think the best name for aed06b9 is probably:
>
>   v3.13-rc1~65^2^2~42

Sounds likely. I don't know how to find that best match without a
complete rewrite, though.

My recent patch that got

  v3.13-rc2~32^2^2~47

comes close to that, and the complexity is similar but the numbers are
actually smaller, so I guess my heuristic did indeed find a "simpler"
name, but yes, the one based on 3.13-rc1 would definitely be the
better one.

> which I found by picking the oldest tag from "git tag --contains" and
> plugging it into "git describe --match".

Yeah, so you basically did the "let's figure out minimal inclusion" by hand.

> Sadly, neither git's internal
> version-sorting nor GNU's "sort -V" knows that "v1.0-rc1" comes before
> "v1.0", so I had to rely on "--sort=taggerdate".

I'm not seeing the "sadly".

I think "--sort=taggerdate" is pretty much the only sane sort there is
for tags, unless you do a true and full topological one (ie sort based
on by how many commits that tag encompasses, but also by how each tag
contains another tag).

              Linus
