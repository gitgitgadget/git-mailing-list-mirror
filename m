From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: meaning of "-g" in git-describe output
Date: Wed, 17 Mar 2010 19:14:00 -0400
Message-ID: <76718491003171614r2e8ce0e5r3e4799503194831c@mail.gmail.com>
References: <201003172320.45058.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 18 00:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns2RF-0001gf-SU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 00:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab0CQXOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 19:14:03 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:52242 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0CQXOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 19:14:00 -0400
Received: by iwn12 with SMTP id 12so1306374iwn.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=lkLckfRBFTazFaKfjrSIYD06CSNgvVYq08ohEYf3zSA=;
        b=oA8nv3HMcNdvZJgr0KR4BVNf62NVPIYouf2/fVPOYuH9R0PydXr3cwFlsOZ5e3ymYb
         3Buo8VUcV9PhMgEnwLE+Y3+8sXhRO6c6KRCjwOF59cSu9fERxRiquoZ7sZkAXNvhIEXS
         x/YBzGxExOH7DoSx+9o2BYXH8yfCdQF9S6mOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cqLgb4kOgVT07sEyN3qm9tRdIpipeL3vu9AUk6Uf+VqWAz7HiEvL2U7Cippxd1L/8W
         9NvhfF5YtJdAL290JCG+Xpwd61jI3LPHBsBFtUbnnSRQY3McuwyIwFRFNGn/1p27VfIo
         uQgX18cX4UZN6Zt9rPa8DG8YIqOPaYIX+agcE=
Received: by 10.231.145.5 with SMTP id b5mr461808ibv.70.1268867640168; Wed, 17 
	Mar 2010 16:14:00 -0700 (PDT)
In-Reply-To: <201003172320.45058.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142442>

On Wed, Mar 17, 2010 at 6:20 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Hello,
>
> what is the meaning of the character 'g' in output like v1.0.4-14-g2414721 ?
> Is it simply the first letter, which isn't used in hexadecimal numbers
> or has it a deeper sense?

My guess, from 908e531 (Add a "git-describe" command, 2005-12-24), is
that it's short for "git":

    IOW, with something like Junios current tree, I get:

        [torvalds@g5 git]$ git-describe parent
        refs/tags/v1.0.4-g2414721b

    ie the current head of my "parent" branch (ie Junio) is based on v1.0.4,
    but since it has a few commits on top of that, it has added the git hash
    of the thing to the end: "-g" + 8-char shorthand for the commit
    2414721b194453f058079d897d13c4e377f92dc6.

    -- http://marc.info/?t=113546113600001

But I think only Linus (+cc) knows. :-)

j.
