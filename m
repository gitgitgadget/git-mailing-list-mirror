From: Aghiles <aghilesk@gmail.com>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 16:05:39 -0400
Message-ID: <w2s3abd05a91004141305h28d69d44g2fcb69abe578dbcc@mail.gmail.com>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> 
	<slrnhsba0k.h9q.heipei@dualtron.heipei.net> <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com> 
	<20100414194552.GA5178@dualtron.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O28qg-0001N0-5N
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497Ab0DNUGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:06:07 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44950 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364Ab0DNUGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:06:03 -0400
Received: by wwb22 with SMTP id 22so200607wwb.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=MVWxr7Q/RmqpkIfrVq752hmF8/quZYjSzJjoppgypt4=;
        b=jZ/jYl7U1PyjOMaeM+hHGYxGARujlp8yZ6XnNFLFNyxa1xImNQkkDk8BBRbA3jHDry
         JqH0Nh7lYxa8ouQ2P9VvZvm2xgpnni6w1OR08jX2S3x2Ilp+oYPn0zxObwQfImWGuI4k
         dt3FtZDdRjrKF2ojceLqcZ+e7h0GNjx6EIcGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qZ+G6IjGTVQ8wDoxACZjgmXKy1rPDvU+qN5mZki9Wdm/v464qAG+um88cgd1UWpnHA
         4N2b1qxuSAaGAVZ12XhE4EkKS3QQtUcE+97ZEdLlAXM4gNP6ldn0MMo9i5jyJuaiFY9c
         vYCkLT0EE1lQKyW/GBEYOdkW5RMjCJpdbuoOI=
Received: by 10.216.157.212 with HTTP; Wed, 14 Apr 2010 13:05:39 -0700 (PDT)
In-Reply-To: <20100414194552.GA5178@dualtron.lan>
Received: by 10.216.90.143 with SMTP id e15mr366676wef.110.1271275560611; Wed, 
	14 Apr 2010 13:06:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144900>

Hello Johannes,

On Wed, Apr 14, 2010, Johannes Gilger wrote:
> Major restriction? Have you understood how git works, internally?

I don't need to understand how gits works _internally_ to know what
is a restriction to _me_. ;)

Having a sneak peek on what's going upstream seems like a natural
thing to do, no ?

For example, I want to write a script to say to the user what are files
that could be potentially in conflict from upstream. As I understand it
now, I have to fetch and then check. No biggie but I am must say
I am surprised.


> The
> first thing you'd have to do is to get the data (i.e. your version or
> their version) on one of the sides then do the diff there. Now, that
> either means you have to upload your non-matching objects or they have
> to upload their non-matching objects. Next up, you might not even have
> the authority (or technical possibility) to put data on that server
> (think http), so obviously the diff will have to be done at your side.
>

Understood.

> So, what will be transmitted? Data the server already has but you don't.
> git determines this data and then packs it into an efficient format and
> sends it to you. Which is what? A diff of your version vs. theirs.
> Except we don't transmit plain diffs but pack them up nicely so the data
> is smaller and (because you now effectively fetched it) can be reused
> any time after that initial diff.

Understood.

>
> Now, one might think of some very limited form of log.

In my case, just a list of modified files would be fine actually. Maybe this
is something I can do already ?

Thanks for the insight.

  -- aghiles
