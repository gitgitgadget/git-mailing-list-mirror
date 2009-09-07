From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: how to skip branches on git svn clone/fetch when there are errors
Date: Mon, 7 Sep 2009 17:53:21 +0200
Message-ID: <4d8e3fd30909070853u6f4bc179qac96edae5c83a864@mail.gmail.com>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com> 
	<9accb4400909070230n413c6ecfqef8238422dd5d3b@mail.gmail.com> 
	<9accb4400909070634oee46b78g9270586a2b0eb4b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 17:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkgXR-0001lt-0B
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 17:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbZIGPxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 11:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbZIGPxm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 11:53:42 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:39096 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbZIGPxl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 11:53:41 -0400
Received: by fxm17 with SMTP id 17so2073170fxm.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Jp5XbgYk98uYGCP7Xh8VMtcv+QIvTgRsPCsDQVILFy4=;
        b=BEV6QCqWfM2liNMbfgVTk87F7t5DqwrpYS3drZmqcgcjgznyreZlUsxPL2+qvCTuvQ
         wwY5PROUDV6fFd9auC6WrM5/JeeY4gbzVfvbmXar3T0gj6uMtuoE6SYED5erJxJMF517
         1hc7lJvKwerD7U2Q1NMnlvzK68k+WbHTrPiC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TLMVxc2yK2Oc6ZcDxXzDQNO09m88n0GVQ9Q+mnnzQSqXHI+g02pB8ctV4NpzY1vG0U
         fTiAe+gIrIShTQelpDAFld7X/XFSUMO3P3Lin1305I/SKgIDbU9JrYqkNMJ7bgvFcRFJ
         gELjoGl5JKmn4kYJYvJzaL/05l08F8clmwG2E=
Received: by 10.86.10.36 with SMTP id 36mr7801708fgj.61.1252338821917; Mon, 07 
	Sep 2009 08:53:41 -0700 (PDT)
In-Reply-To: <9accb4400909070634oee46b78g9270586a2b0eb4b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 7, 2009 at 3:34 PM, Daniele Segato<daniele.bilug@gmail.com>=
 wrote:
[...]

Ciao Daniele,

> From e8a1a12e83b3f0b18ce842190d8fc8eddaa77f68 Mon Sep 17 00:00:00 200=
1
> From: Daniele Segato <daniele.bilug@gmail.com>
> Date: Mon, 7 Sep 2009 15:30:14 +0200
> Subject: [PATCH] Ignore error 175007 authorization failed on checkpat=
h
>
> I don't know if this is the best solution to solve the issue but it d=
oes
> let me download the repo skipping the problematics paths

Usually these lines are for the commit message, I guess you don't want
to store these two lines in git.git :-)

> ---

So if you want to add comments like you did, write them after the 3
minus and before the content of the patch.

> =A0git-svn.perl | =A0 16 ++++++++++++++++
> =A01 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index a366c89..0ab6453 100755

Ciao,
--=20
Paolo
