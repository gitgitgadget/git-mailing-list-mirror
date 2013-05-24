From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 08:11:00 -0500
Message-ID: <CAMP44s3_BBPu0WSzYyaVLbdg0dBuaV7MFgy1SMuK1C8P2vKbYg@mail.gmail.com>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 15:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufrm6-00074f-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 15:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab3EXNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 09:11:10 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33313 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3EXNLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 09:11:09 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so4443614lab.19
        for <git@vger.kernel.org>; Fri, 24 May 2013 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BV4VzEMoadDLeOw9VlV9TlqQBKQQXt1nlql+u6ogSCw=;
        b=DHF3LDHyZcqPEnBoq0leiSynwbu32WMQfXIVWIu8FIC6JtP3+W9pLgXkq1eJKx/TBb
         0JUam/0Xq4lZ+jR33UydI0+BHOANJcdGDn8NGT5qBdZHUgcz6ZcptmWCvmIFWId1XCbH
         3vpsG51CvkZWjKwLtOGWWNnPdF38GkTqYGKp2t/9c0N/+ARBbypxHHSobakEYiauzFas
         4kTLcpFElp5zSAJz2kzILuAvd6fJavrP7l4cKUZqzuFj9Hy6YWomTvNs/JmMJbgQlz58
         Abd8a1JSTxxffuhka8GjZblZ0madmHb8Ur904YNi5yoATUEwfUuu6FuhwYZSG5dw8FyD
         vgDg==
X-Received: by 10.152.2.233 with SMTP id 9mr8956022lax.34.1369401061011; Fri,
 24 May 2013 06:11:01 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Fri, 24 May 2013 06:11:00 -0700 (PDT)
In-Reply-To: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225350>

On Fri, May 24, 2013 at 6:33 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi,
>
> I'm not able to sort completions for some weird reason.  No matter
> what I order I insert stuff into COMPREPLY, bash seems to auto-sort
> them lexically.  I tried to pass --sort='-committerdate' to git
> for-each-ref so I can get a sensible 'git checkout <TAB>' reply, and
> I'm very annoyed that it doesn't work.
>
> I thought it was bash's complete builtin doing the implicit sorting,
> so I read the manual with no success.  Is readline doing it?  If so,
> why am I not getting the ordering even in zsh (which doesn't use
> readline)?
>
> What am I missing?

AFAIK bash needs the completions sorted, so we added some | sort |
uniq. I suppose zsh doesn't need that, but have you tried by calling
compadd directly?

-- 
Felipe Contreras
