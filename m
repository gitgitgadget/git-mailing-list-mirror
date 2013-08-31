From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] branch: improve verbose option
Date: Sat, 31 Aug 2013 12:24:18 -0500
Message-ID: <CAMP44s00qUjqR6Daiy_3_hONuSBkxY99xaxCdbKyBM-t84Q0=w@mail.gmail.com>
References: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
	<CD323DA08A0540A89D9BFB28F541AFB4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Aug 31 19:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFouO-0006ab-8f
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 19:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab3HaRYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 13:24:20 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:35098 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab3HaRYU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 13:24:20 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so2475239lab.13
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P2PEKThFb9dfXwxaKUXa1AV5yOXXkwqjkGn4aWi69gw=;
        b=L65ouWxJvVmpK8RQ2vOPW2/L27bL7vSCmyuTSgObpXfzjULjOU/HAeJARRqpulyzQx
         eolB+LOj8BPfjv9VyGQ52c8TyI1dwylRDEXsQYRd6x1Fp7NmS1oMF5uaGyVnyLnlPA2F
         QzN7XpCTCp176gJWLDxW5qxnSkLv/d7DIaUVK6hRSCxeXSlfWeeY5qY2KBXuKa2X6mHp
         juuUnSEX/Eyb0wvVZmxZ0cnfJnPu+CJFUtuBCzerz0PlPUdd7F/5mRsm+KiPNaIJVyNN
         Em1PpKbJQi5c6vpHBHmKnzJb95miwnoJsZvMrh6iPTeWVscMSXyV7YArPuloZ3KXzuKW
         /RCg==
X-Received: by 10.112.126.37 with SMTP id mv5mr12873497lbb.20.1377969858713;
 Sat, 31 Aug 2013 10:24:18 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 10:24:18 -0700 (PDT)
In-Reply-To: <CD323DA08A0540A89D9BFB28F541AFB4@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233525>

On Sat, Aug 31, 2013 at 9:41 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>

>>        Showing ahead/behind is
>> not as important,
>
>
> I still find this useful - if it's up to date I don't need reminding of
> which remote / upstream tracking branch it's configured against ;-)

Whether or not it's up to date depends on which is the upstream
tracking branch. What if you see "ahead 1", and you think it's not up
to date, but it turns out it's tracking the wrong branch?

> These two bits of information, while related are separate. If anything I
> think I'd prefer both, but then again optimisations are still good.

So you can keep using 'git branch -vv'.

-- 
Felipe Contreras
