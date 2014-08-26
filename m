From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Improving the git remote command
Date: Tue, 26 Aug 2014 18:19:20 +0200
Message-ID: <CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
References: <53FC537C.4080206@gmail.com> <20140826124027.GE29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?R=C3=A9my_Hubscher?= <hubscher.remy@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:19:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMJTQ-0008HA-JY
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 18:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbaHZQTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 12:19:52 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:59612 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaHZQTv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 12:19:51 -0400
X-Greylist: delayed 22407 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Aug 2014 12:19:51 EDT
Received: by mail-oi0-f54.google.com with SMTP id i138so10836022oig.41
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fYxSo6h4Tb9vk6lViYPH6WGch2rxuGituoozCDQYBNw=;
        b=j9acjDiUTj/W5HUYK6VGHLnHfxXQbDJF4Pzmk1n99qm6ws2apCyfOCUrwua2xglxxn
         fKy+R/f9eStW1eFiViSSafitapVVDyVWOws99bg+g/9ClLUJQ87qsDsKJ752wykdfT1v
         VdkCBJ//LUKd/ZOmJoCfU/DQQGN8C1dFxa2+8YevCSy9mtPvGdmJiEA92/4pLHsGnI20
         2jK6O3aXDUH2+TES54lqs+wniiaXlurXhSoTi/ooKkBAygYiX/KOuPyvnbHZvWvfaxKl
         zyH2DsMazYl8n3pIw2GN0R5LoYcXFKvW9FgwxiWXEYDgAeub478p4CorZgh0N1mEKoET
         nJSQ==
X-Received: by 10.182.20.242 with SMTP id q18mr28770047obe.52.1409069991169;
 Tue, 26 Aug 2014 09:19:51 -0700 (PDT)
Received: by 10.202.93.131 with HTTP; Tue, 26 Aug 2014 09:19:20 -0700 (PDT)
In-Reply-To: <20140826124027.GE29180@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255915>

> Perhaps "-v" should have been the default all along.  I do not use "git
> remote" myself, so I don't know if "-v" is what most people use. But
> changing the output of "git remote" now is probably a bad thing (I
> expect some people may depend on parsing it to get the list of remotes;
> they should probably use the git-config plumbing to do the same thing,
> but it's actually rather tricky to do it that way).

Just to be clear, the proposal is not about changing the output of "git remote".

Anyway, it got me curious about other git commands reguarding "list",
and I was very surprised because I couldn't find another one. I mean
"git remote" actually behaves like "git branch" and "git tag". I have
no clue why I expect "list" to work with "git remote".

It's probably because "git branch" and "git tag" expect a name, and
there "list" can only be expressed by "no name" or with some flags. On
the other hand, "git remote" expects a subcommand (add, delete, etc)
and there what logically maps to "list" is the subcommand "list", "no
name" being more expected to produce a list of the subcommands.

Philippe
