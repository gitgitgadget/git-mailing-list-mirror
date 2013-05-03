From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v4 3/3] Add colors to interactive git-clean
Date: Fri, 3 May 2013 10:53:01 +0800
Message-ID: <CANYiYbG5r=sO7qqU4hnOpCUUrgVYPZH6XF7xO4+6TqCGTjC6pg@mail.gmail.com>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
	<3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
	<vpq38u6n397.fsf@grenoble-inp.fr>
	<bb5463fa4ef09df08ad3bf5abf4660a5df414e64.1367500374.git.worldhello.net@gmail.com>
	<vpqhailfmj9.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 03 04:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY67Q-0000OS-E8
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 04:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761706Ab3ECCxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 22:53:03 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39145 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758945Ab3ECCxC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 22:53:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so684340pad.19
        for <git@vger.kernel.org>; Thu, 02 May 2013 19:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=N2pOIIrMkGjMRwBSyGWn3OR2AwpNmFGTgDwy+0XaxFA=;
        b=KbsiWF0DKlQtQ3YGLpvWRwL0Nwg/USY+dv4zOLpzyixjPSoHrWdNeL+HJxwxywyo2W
         18l9pkK5xFluumrs8i2gaRDuL5i5kj8a8GI4FRaZEaOgOKUiOms67rZZv+tXPTqJT5LO
         Y0jMKn/RrEoF/RA21edpVabrHDeySIOuU/px1XOVs4T19WWaLrQV1tE2gTV1HsAgAuM4
         uI0W2wIC4jKsFZE9zY6WZ8J1LPc+A6DSdp6edtCL7h7sSNY4RDPwBKNsow29UuIbBjRr
         f2Bw6/6Wi77ZAi5YQfgO1+xS0q2gwFtTH+Ugnddn8kT3YIfNyKBNTYyEOukTYGakF/5n
         GIiw==
X-Received: by 10.66.162.67 with SMTP id xy3mr12530597pab.94.1367549581652;
 Thu, 02 May 2013 19:53:01 -0700 (PDT)
Received: by 10.68.197.234 with HTTP; Thu, 2 May 2013 19:53:01 -0700 (PDT)
In-Reply-To: <vpqhailfmj9.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223270>

2013/5/2 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Show help, error messages, and prompt in colors for interactive
>> git-clean.
>
> I find the red WARNING a bit agressive. Also, the NOTE: is the same
> color as the WARNING, hence visually similar. I first thought it was
> repeating the same message. I think it would make more sense to use
> default color, black,

Will use new style -- CLEAN_COLOR_HEADER (GIT_COLOR_BOLD)
as header for interactive git-clean (i.e.  WARNING)

> for the NOTE, by analogy with "git add -p" which
> uses it for patch hunk headers (somehow, this is the question you're
> replying to after the blue prompt below).

I agree. NOTE should only be displayed once, and will be fixed
in patch 3/1 of next reroll.

--
Jiang Xin
