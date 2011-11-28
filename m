From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Mon, 28 Nov 2011 12:49:10 +0100
Message-ID: <CAH6sp9MvS1naHpLXwkCpPyU0-Z+CHqrVwJvjBbWs=hvin0ZMvQ@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net>
	<20111127082744.GA32068@sigill.intra.peff.net>
	<CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
	<20111128035321.GA15640@sigill.intra.peff.net>
	<CABPQNSbLvWh-ivaqBk-Du+kwZvV3t+ajEJhHATRzyGZbHYyM=Q@mail.gmail.com>
	<20111128113127.GA23408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 12:49:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUzi0-0000cx-Vr
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 12:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab1K1LtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 06:49:12 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42957 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1K1LtL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 06:49:11 -0500
Received: by qyk4 with SMTP id 4so749643qyk.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IPlsihCcjwNesjqohoRtVOH1mYpJH94ho9lmVuRl/PI=;
        b=OZWsr1GD4dlvwjj2NBU2swD+Fgj46jnrzHM69UpH98qzKK5A5qz7yFEpVnMJj7iNcY
         ME9jP4CkSsnA+gjuaNEZJtMm1DFTG4rSYerrLxMg1M7q1O14vIogihVG+zKabKDVjGxX
         7Po13dTSHDxpexvy5ujTodk+PG4HLuBdZp9CM=
Received: by 10.229.65.85 with SMTP id h21mr4713394qci.215.1322480950529; Mon,
 28 Nov 2011 03:49:10 -0800 (PST)
Received: by 10.224.86.11 with HTTP; Mon, 28 Nov 2011 03:49:10 -0800 (PST)
In-Reply-To: <20111128113127.GA23408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186013>

On Mon, Nov 28, 2011 at 12:31 PM, Jeff King <peff@peff.net> wrote:

> Certainly on non-Windows something like that would not be welcome. The
> user can already have specified GIT_ASKPASS if they don't have a
> terminal. And once the credential-helper code is in, they can use a
> platform-specific helper that provides a nice dialog if they want it.
>
> So I would say trying to do something graphical would be surprising and
> unwelcome. But then, I am a very Unix-y kind of guy. Maybe on Windows
> something like that would be more favorable. I'll leave that decision to
> people who know more.

I would say that also on windows it would be surprising if you are
working on the command line and suddenly a pop-up appears asking for
input. So even on windows you should probably keep away from gui stuff
in a cli tool, although there are tools that don't.

Frans
