From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git pack v4: next step, help required
Date: Thu, 19 Sep 2013 08:28:28 +0700
Message-ID: <CACsJy8Cyg3Qdnx_eh4gVpeLLgHrTWRZbOnd3z57oqMVtJy9h8A@mail.gmail.com>
References: <alpine.LFD.2.03.1309181120390.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 19 03:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMT3I-0001sf-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 03:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab3ISB3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 21:29:00 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49034 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab3ISB27 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 21:28:59 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so8573579obc.7
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 18:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6HlVsMr8auBc3i8ecCpho0nRTaUrsDLOSJUgRgy24Bk=;
        b=onrfZvVuT0m3fYBK8F0nEMnW/vyugppWJ6bH2cgFbfWKnCxUYaWnnlmY8uxNqVWdAo
         ErcSmiiJAP8szmLT1UtIViXjxvlR38y+y/Ur6dgUhZ8ZnEx9HU4/i5URoPzzGfxGF82I
         EdblJL5kSTci4ovVY1cDSalSmoKjkydNq3XJYYZ9Zj8BiSTnWT0nqOZf+nSCKOZ8U+vi
         DwtM3zH9ZTsdwQRQQuPl+3Dj6elh6TcRopMMhQUlIOk9bkta1OY7wG9hLPKo0BftQ3gq
         HqWvetIf9N+qGaxvkfULQsJ67QkzrVOp+X/ux8zpVZ3Jw0sX9iWLyfko4+RaMjnSIAqZ
         4TOg==
X-Received: by 10.60.155.166 with SMTP id vx6mr320782oeb.28.1379554138889;
 Wed, 18 Sep 2013 18:28:58 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 18 Sep 2013 18:28:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309181120390.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234999>

On Thu, Sep 19, 2013 at 12:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> I think the pack v4 format and compatibility code is pretty stable now,
> and probably as optimal as it can reasonably be.
>
> @Junio: might be a good idea to refresh your pu branch again.
>
> Now the biggest problem to solve is the actual tree
> "deltification".  I don't have the time to spend on this otherwise very
> interesting problem (IMHO at least) so I'm sending this request for help
> in the hope that more people would be keen to contribute their computing
> skills to solve this challenge.

Just so we're clear as I'm involved a bit in packv4 series. I plan to
make the test suite fully pass, then add v4 support to git protocol.
After that I may look into adding multi-base tree support to
index-pack/unpack-objects, and only then either look into this
challenge or continue to add v4-aware tree walker to git. In short,
you you are intereted in Nico's challenge, go ahead, it will not
overlap with my work, at least in the next one or two months.
-- 
Duy
