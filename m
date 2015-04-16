From: Pedro Rodrigues <prodrigues1990@gmail.com>
Subject: Re: git-archive ignores submodules
Date: Thu, 16 Apr 2015 20:59:46 +0100
Message-ID: <CAL1ZDKbvNvTA3CFg5iWMYpOVDbxFwtpFCu+PO2onssO=+pw5XQ@mail.gmail.com>
References: <CAL1ZDKZs++NkLoHZ_w_YebQuZYG3rgAiH5SsaQfTmb9MPHjR3w@mail.gmail.com>
	<20150416175623.GJ21868@paksenarrion.iveqy.com>
	<CAL1ZDKbcmrer481fRY2NEHUQ1J5tjRbHz2yLEcszh3Q-NjcvcQ@mail.gmail.com>
	<5530076E.50605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 21:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yipx5-0003oI-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 21:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbDPT7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 15:59:48 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36706 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbDPT7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 15:59:47 -0400
Received: by qku63 with SMTP id 63so140344296qku.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=udFjupj9xxxMlo7RfnqOymrtLyVSk8kc0j9e/nDjFwk=;
        b=aNmV0UodIfA9FL/dhpldeINqyI9vl/HRiShV/5BaHaFzBUJfRSJBtdICUBCoOmJMls
         ge8yvtw+0zX6mkSs5wV16G5HxsZ1uo/mfSbMJp0vQryjPuaWC4zPKpCCaLCz+uaS/dDF
         LcaB6sWelnwg4nsAo3J9uvaPMtBMsG89blnHD+vq40ahgNK6sn/LSFYNgTf4rR8HIAVA
         ggtcbsUO+w84EDOkts15KXgvoTIIo0Qk8yta8YuJq2M/tscvtNDwAOI6UJ5JY6xi6FOr
         /EDe3i8+45VxlAL2PztiP4kxap3OYkF2mWZLJwnMKDl+57+CxNGmh0bLNtAQRaXfNHpv
         JoFw==
X-Received: by 10.55.20.30 with SMTP id e30mr56765705qkh.45.1429214386914;
 Thu, 16 Apr 2015 12:59:46 -0700 (PDT)
Received: by 10.140.97.100 with HTTP; Thu, 16 Apr 2015 12:59:46 -0700 (PDT)
In-Reply-To: <5530076E.50605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267331>

I sure can. Just send me an ID I can pull and test in here (not really
into C, so this the least I can contribute).

Although, my expectations are very simple, I just expect(ed) the exact
same git-archive command to be run on submodule(s), and have an output
on a single zip|tar|whatever file.

Not completely off topic, but for consistency consider that:
git-clone supports --recursive and --recurse-submodules, which do the
same thing.
git-pull and git-push only support --recurse-submodules.
