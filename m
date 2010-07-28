From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 07:34:54 +0000
Message-ID: <AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:35:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1AK-0005aI-NE
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0G1Hez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:34:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39713 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab0G1Hey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 03:34:54 -0400
Received: by iwn7 with SMTP id 7so4575495iwn.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=jowvqK3ua1ZzQBzgjmXWVLO6UoRddYysYIeZ+zIdUZI=;
        b=pgoMiofr7cUmavmHqvbHtu3XLtJHpl58zTdgJ1phlRpaCgOmA/X14HlkPwTwDqSxUc
         snXOjLZM0CHT9TtfxtAjigj28fvoyBw935cEObVcYT7xukyRbs/urWobQ98UIcZz3v+4
         Sz5waBy6BYoEBeoOsCiGBtwtNOHV/Uh0MI7Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Dz3isEPPjWYA4v8CvfWGYqTKfDtpC5E7IEamYFoBWxy+bDal5oBNMyUqjbTW5sOtWD
         GW6RmR+iimRwKmfXRv65oD+yJJ6O8lw2Sc6KQ2cxLlk1KCYAJ0F+BTu6HaHaz19fbjMn
         g2kMkzT+aCynbEK0tZc+xjvQ/yRmoG1SrQsLQ=
Received: by 10.231.146.196 with SMTP id i4mr10656369ibv.110.1280302494308; 
	Wed, 28 Jul 2010 00:34:54 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 28 Jul 2010 00:34:54 -0700 (PDT)
In-Reply-To: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152048>

On Wed, Jul 28, 2010 at 01:24, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> I would love to be able to use the -m flag and --log together with git
> merge and pull to be able to create a custom commit message but also
> include one-line summaries of each of the commits being merged/pulled.

This sort of thing has vaguely come up before, and it was mentioned
that you can just use a small script that calls git-filter-branch or
git-rebase -i.

It's easy to rewrite the commits you just pulled, having some feature
that e.g. adds a custom message to the beginning of each of them would
just impose an artificial limitation and overlap with existing (and
more powerful) functionality.
