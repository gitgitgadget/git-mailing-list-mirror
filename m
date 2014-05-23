From: Henning Sprang <henning.sprang@gmail.com>
Subject: Re: git push rejected due being behind after git svn dcommit without
 any changes local/remote
Date: Fri, 23 May 2014 11:14:04 +0100
Message-ID: <CAB10+LuaoCHYOew_=_NhF3m++owM9uuQqFvA79e1bTs=YpOCWQ@mail.gmail.com>
References: <CAB10+LtnAiCCiMdrULvioxc-UBQufKD4AzOphvE8bAdq7en04g@mail.gmail.com>
 <CAEcj5uURgU0NfocwSxYDJiQvwdyvDgS3Gvo2kFEroz-dg=U5Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 23 12:14:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnmUh-0004BQ-80
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 12:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbaEWKO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 06:14:27 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:52697 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbaEWKOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 06:14:25 -0400
Received: by mail-qg0-f46.google.com with SMTP id q108so7477673qgd.5
        for <git@vger.kernel.org>; Fri, 23 May 2014 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=JMh9er4p58APAEM1Cgqc0RbMWn48LllGkRnx+pebNXE=;
        b=JWVxNWx7LLuMm3qV1hSoLKLBWQtcXNYswoiZpskazy97xuOy/9VXS9h00lqBOCtayR
         x/TbXrAwpLkqIMraQduyQNVfKj5X1I6JlpyiDSZC+CoZbbzWbTlYv6zywgpQSVLiXNmf
         Tu46TxAtc6jhXfdKH4+U9q1w1oviStYRz8pcerhTD14OnSWhFKSUKTw2jp9+zwT4XgOQ
         oiEHGgo/3RRN/N0O1uTZ6yrfqZiYG14tEDB3NoWA/q979N2vN27NCqRUesN9RGXLOgeO
         bca2gpnInmsAoB0NlptkG9uyX1a/0yxWHTuV/XKIY5iNoomPAHgdTm4C2OkaevirhIjD
         hr2w==
X-Received: by 10.140.94.39 with SMTP id f36mr4885273qge.64.1400840065037;
 Fri, 23 May 2014 03:14:25 -0700 (PDT)
Received: by 10.140.103.161 with HTTP; Fri, 23 May 2014 03:14:04 -0700 (PDT)
In-Reply-To: <CAEcj5uURgU0NfocwSxYDJiQvwdyvDgS3Gvo2kFEroz-dg=U5Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249979>

Hi Thomas,

On Wed, May 21, 2014 at 10:33 PM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> This is normal. Every time you update or sync against the SVN server,
> your local history is rewritten if you have local commits: All your
> local commits are rebased on top of the latest changes coming from
> SVN.
>
> If you want to avoid this, only push to your Git mirror when your
> git-svn clone and the SVN repo are in sync. Doing so ruins the whole
> point of your Git mirror, I assume.

Thanks for the explanation so far!

> So, I'm afraid you have to get used to just force-pushing to your Git
> mirror. Even though this is not considered good practice, it should be
> fine as long as you are the only one using this mirror.

OK, as you correctly assume, for this case it's pretty much fine, I
was just thinking I'm doing something stupid, and wanted to learn how
to do it correctly in case I'll have an actual use case where changes
appear on both sides - but then again, maybe that should then also be
avoided by a more reasonable versioning setup(e.g. throwing out SVN
completely :) )

> Alternatively, you could consider some other mechanism for backup (rsync, etc).

I do anyway. I just love to have multiple backups in multiple
locations and formats, just to see them all fail differently in a real
emergency case :)

Cheers,
Henning


-- 
Henning Sprang
http://www.sprang.de
