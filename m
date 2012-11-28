From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] jk/send-email-sender-prompt loose ends
Date: Wed, 28 Nov 2012 22:37:19 +0100
Message-ID: <CAMP44s1uVK-m_jczhVui0Z_Tcv-vtSVU8E1uVKY7QdQvQhMQFg@mail.gmail.com>
References: <20121128182534.GA21020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdpKE-0001Gt-0d
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 22:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388Ab2K1VhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 16:37:24 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38937 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab2K1VhU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 16:37:20 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so10666647vcm.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 13:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jrsa9vIzJB8CrQq0tzM7JnMHR0ruaNneYqorAUH3cn8=;
        b=f/7qTgBwE+2EYIqQfnYQyx2rsIDCa/03fcWKzCQ2fjmurwhy7VSnA78F7Abt7wHUd0
         8Lle06r0konUUAqNOdlS0b5AEHfDLnGw3XSWmA0al5VUwSC2qkulSd3uwbuqpjJq89TI
         5s0Ke5p9N6cSluQH5y9D8MZZT+j+KJfuJmDI+yWcElPlMOaFKLSefCgxjLUyVEGTvjbr
         aXfP7GE9fkGGphQ8AFsS4ahXqjVCBqCe/uatmf0EyNbTaeikH8w2Js+fwhzWdsEfQa8R
         SxiVH8r8cDoN9CuZWj/vwmWhTZcIOmNuAkIHFKB325zlUhV+sWF4SCaQkGhisXyZXzxl
         3Ssw==
Received: by 10.220.152.204 with SMTP id h12mr29294173vcw.66.1354138639486;
 Wed, 28 Nov 2012 13:37:19 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Wed, 28 Nov 2012 13:37:19 -0800 (PST)
In-Reply-To: <20121128182534.GA21020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210783>

On Wed, Nov 28, 2012 at 7:25 PM, Jeff King <peff@peff.net> wrote:
> Here are the cleanups and refactorings split out from my
> jk/send-email-sender-prompt series. They can go right on master and are
> independent of Felipe's fc/send-email-no-sender-prompt topic.
>
>   [1/5]: test-lib: allow negation of prerequisites
>
> Same as before. I think this is a useful feature for the test suite (and
> 2/5 depends on it).
>
>   [2/5]: t7502: factor out autoident prerequisite
>
> Same as before. Patch 5/5 depends on it.
>
>   [3/5]: ident: make user_ident_explicitly_given static
>
> Same as before. Cleanup.
>
>   [4/5]: ident: keep separate "explicit" flags for author and committer
>
> Same as before. Cleanup. I do not know if anybody will ever care about
> the corner cases it fixes, so it is really just being defensive for
> future code.
>
>   [5/5]: t: add tests for "git var"
>
> Tests split out from he "git var can take multiple values" patch.
>
> Dropped were:
>
>   - "git var" can take multiple values. Nobody really cares about doing
>     so, and it's an external interface, so we'd have to support it
>     forever.
>
>   - exporting "explicit ident" flag via "git var"; same reasoning as
>     above
>
>   - Git.pm supporting explicit ident; ditto
>
>   - send-email prompting change; obsoleted by Felipe's patch

For what it's worth; they look good to me. However, I think it's worth
mentioning that there are no functional changes.

-- 
Felipe Contreras
