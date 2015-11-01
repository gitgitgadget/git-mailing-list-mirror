From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH 2/1] stash: recognize "--help" for subcommands
Date: Sun, 1 Nov 2015 09:17:52 +0100
Message-ID: <CAEwRq=oXEkMpMHKdWHrg6uY-TTCP_H+TyX2++AKyq0BG3MU1gg@mail.gmail.com>
References: <CAEwRq=r=iMmnnzS2F_2rr9Tjem9khn1d=os3krjEjOg5iK5bww@mail.gmail.com>
	<20150520180132.GB14561@peff.net>
	<20150520181746.GC14561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 01 09:17:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsnpt-0000Ov-9W
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 09:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbKAIRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 03:17:53 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38297 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbKAIRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 03:17:53 -0500
Received: by igbdj2 with SMTP id dj2so36370153igb.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jH81yUmzyXcfFJMUCLHS64M67kDjSMAzf3hQ01vVVEY=;
        b=FdI9Un4WGofYhIi33Rf8EDlcYuCEueLzCaTcSdrFzz6EYXksZgdrkWtLG99ARW81WP
         k4PZepgICUZ9OUA5HGMP365RglPKsDBz0Vjy8FOkGBpxgJATh71/1dsxtNj9mUFdhrmL
         DZ93uGyLEwnQLbsOGE1Auhly0ZSp29RlUbHQkjcz+gFmiqg4/KFUd72pDZacgFUkHYEl
         UdX/HYUftr8MRH+BYlDNVlZGeXh0wPQHqTmEj61AkM+1h1AjYy0J+TkspMFXo+fGHtwD
         W+2RIih1LcYcQISC3lzB8pVbZ+ArVDIE9ZzlpMhz6Erzws+NAD4WKShqrRbSDVUYr4UF
         sHnw==
X-Received: by 10.50.56.71 with SMTP id y7mr6206456igp.34.1446365872658; Sun,
 01 Nov 2015 01:17:52 -0700 (PDT)
Received: by 10.64.10.129 with HTTP; Sun, 1 Nov 2015 01:17:52 -0700 (PDT)
In-Reply-To: <20150520181746.GC14561@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280611>

On Wed, May 20, 2015 at 8:17 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 20, 2015 at 02:01:32PM -0400, Jeff King wrote:
>
>> This takes away the immediate pain. We may also want to
>> teach "--help" to the option. I guess we cannot do better
>> than just having it run "git help stash" in all cases (i.e.,
>> we have no way to get the help for a specific subcommand).
>
> That actually turns out to be pretty painless...

Looks OK, but this "[PATCH 2/1]" is fishy...

-- 
Vincent Legoll
