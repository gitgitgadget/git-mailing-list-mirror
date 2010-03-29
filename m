From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Mon, 29 Mar 2010 11:25:35 +0800
Message-ID: <be6fef0d1003282025p4a472b79hb02959fea7481065@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 05:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw5jO-0002nI-ME
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 05:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab0C2Ddd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 23:33:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60491 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765Ab0C2Ddc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 23:33:32 -0400
Received: by gyg13 with SMTP id 13so1220761gyg.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 20:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=D3KFuV0Yd/KolvrR/v4OTupLB12GV7jeZaOZNLgLTRc=;
        b=kySoT4fvZU7EGeuvvSuqLZSvNVvLQXOlRy+2/pA5RbMJxDo+Ok15ZXAoYiIW9etZeq
         zHofJ4uoH7lR7WjNg1tJdwNyrizW2WckB/yp8x18UsAL+AbxndX7qDbLFvf6becuXRUO
         uyp6NC4O6gtd92o3Bj3KrNYT8XxU7UFsRGZQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rDNKHzLM3tuf2ZPG9vyvjj2lVvamOWCO6ArOtSKi5yBldzSxsLtdmQ5GyLtba18RQK
         Wp7+JOB51zVjg5RoxJzYd3mas87uV9wect45evCncgY4Z1GuecaulZyg5Ad7W9D8XRab
         SprErrpZpwCXj3k6K7Ti50OiKTxn6MW11qcrI=
Received: by 10.231.37.5 with HTTP; Sun, 28 Mar 2010 20:25:35 -0700 (PDT)
In-Reply-To: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
Received: by 10.101.174.5 with SMTP id b5mr92831anp.27.1269833135476; Sun, 28 
	Mar 2010 20:25:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143430>

Hi,

regarding...

On Mon, Mar 29, 2010 at 2:03 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> [snip] Also mention the curl family of
> remote helpers as an example.

and...

> +Git comes with a "curl" family of remote helpers, specifically
> +'git-remote-http', 'git-remote-https', 'git-remote-ftp' and
> +'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
> +and 'push'.

I think "family" is confusing. They're all symlinks of
git-remote-curl, if I remember correctly.

But then, I suspect you'll be rewriting this portion, since Ilari's
notes has a thing or two why helper names have the protocol in them.

-- 
Cheers,
Ray Chuan
