From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [WIP PATCH] Add skeleton remote helper for SVN
Date: Mon, 10 May 2010 14:31:22 +0200
Message-ID: <AANLkTikFl25Hay7UEvsz5bsdg8fdT8485SxqgAZXCYqd@mail.gmail.com>
References: <1273491574-31870-1-git-send-email-artagnon@gmail.com> 
	<1273491574-31870-2-git-send-email-artagnon@gmail.com> <AANLkTilzn2GLbxz3vLD4SoNIrYDU9_YzFfPI5Wv_WFs2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 14:31:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBS9H-0005sp-1q
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 14:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124Ab0EJMbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 08:31:46 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:49010 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab0EJMbp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 08:31:45 -0400
Received: by qyk13 with SMTP id 13so6042524qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=ZVnOw6Qyy4FROzvw673h/6UZyLrgfrFuoYXS6EtoCSE=;
        b=hK1RokNeIsitySV9bQoy1ZNfzMXioKvmeLvFXEuIdsjakaRbcjGkAbbtFT0P9cNfSH
         3BzZZr3lZrVuUukhZiU17zPlxJ9h4mt/qea/EoRKfR4zU2Bemp82Hpvg7WjOyJZwQQTV
         NHNjv0qW5Mukd/OqSWTvhz9p7YwEHiWtaUvjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=x9ZCx7q+YBzG5NXmWWs/aT1B6VERFpkilgIciQ6a1AU+LKov2ah1bMurJk5Ibe1Lrq
         n2BEki18UeYHMNh9h0SPMmnM4pBBA991rv5HTbRe5Y25j+n4rMT5QQAGkFgTEKGswvVX
         srB1NNbPSrkD+78cLkYdF68MmW22WcQBifcy8=
Received: by 10.224.31.18 with SMTP id w18mr2584351qac.22.1273494704152; Mon, 
	10 May 2010 05:31:44 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 05:31:22 -0700 (PDT)
In-Reply-To: <AANLkTilzn2GLbxz3vLD4SoNIrYDU9_YzFfPI5Wv_WFs2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146806>

Hi Tay,

Thanks for the style nitpicks.

On Mon, May 10, 2010 at 2:00 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> Johnathan (Cc'ed) had a recent patch
> (<20100509035728.GA8198@progeny.tock>) that changed this area, and I
> think it would be good to build on top of that.

This'll probably be ready for inclusion atleast into `pu` in a few
weeks- I'll rebase it on top of the `master` then before sending it
out anyway. It'll be good if Jonathan's patch makes it to `master` by
then, but I don't think I should prematurely rebase on patches that
aren't in `master` yet.

-- Ram
