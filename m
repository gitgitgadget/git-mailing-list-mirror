From: Andreas Jacobsen <andreas@andreasjacobsen.com>
Subject: Re: [PATCH] merge-tree: handle directory/empty conflict correctly
Date: Tue, 7 May 2013 06:54:15 +0200
Message-ID: <CADEJa-5M3Pe+s+Df70AN5XS6UBWHr_BW3KZ4GKHm2d_GXNG+hA@mail.gmail.com>
References: <CADEJa-5prhhY-fUHgkk91M8HKWRG3enODS_h7Mq0dgo7V9sYsQ@mail.gmail.com>
	<20130506133937.GB25912@serenity.lan>
	<CADEJa-5-UpkUaNQ=QResY54cH4TvXqiUSeG-jewH+n+HsZqmHA@mail.gmail.com>
	<20130506142923.GC25912@serenity.lan>
	<20130506144958.GD25912@serenity.lan>
	<20130506152054.GE25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 07 06:54:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZuv-00083C-UL
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758433Ab3EGEyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:54:17 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:48873 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab3EGEyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:54:16 -0400
Received: by mail-ve0-f176.google.com with SMTP id cz11so128781veb.7
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=I5VDiu4LTfiQuEW80t6tK2zS0zren/r6bbsxug/c3Qw=;
        b=H7bQkW13xiiPR4haA8ev0meXqizxZtvCXmnk9uIcoQaYrIgcNoRaAt1JwRg1u9BWAC
         cXEyTLAtYsCMen1SEeKHMdWYRCYHjUCW8T+8kW0NSecyAxZOCC6VoPSJOjeiEQ7QUM9d
         qce6uV1b72qIw5M/OErEy3/LVzS5qOqo6z4J7e9+XrhCehBjJnEOQQ024MitqfMAO+si
         +B1QOgfPir6OOXho/JThNLhEjJBTdiWjRP1o3vy9Tm+XicJai9Hgyj0w5DEN6hmSivGy
         UBWrlpVE5YNnrUuXiXH2z6h5A+byIH8/SAn4VUsG60hV+fYZR0ugQAWzhJUpozn3IivQ
         yzKg==
X-Received: by 10.52.16.200 with SMTP id i8mr165998vdd.93.1367902455370; Mon,
 06 May 2013 21:54:15 -0700 (PDT)
Received: by 10.58.252.135 with HTTP; Mon, 6 May 2013 21:54:15 -0700 (PDT)
In-Reply-To: <20130506152054.GE25912@serenity.lan>
X-Gm-Message-State: ALoCoQl3MW0nW/ry0A5bwo3Jdq7q/4IFwTZTMP2qY/rLn0tYR9ZqdniWZ+DQRobDNXHWmNhTQacg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223549>

On 6 May 2013 17:20, John Keeping <john@keeping.me.uk> wrote:
> Andreas, can you try this patch and see if it fixes your test case?

Worked perfectly. Thank you, John :)
