From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Sun, 23 Feb 2014 09:52:16 +0700
Message-ID: <CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Feb 23 03:53:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHPBt-0005nT-4m
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 03:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaBWCwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 21:52:47 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:39412 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbaBWCwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 21:52:47 -0500
Received: by mail-qg0-f50.google.com with SMTP id z60so11393094qgd.9
        for <git@vger.kernel.org>; Sat, 22 Feb 2014 18:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fddokaoLph240xGscYsBMAnA81WI/TzzQZZbFCkqS20=;
        b=vZYLdPJu6E47nHwV/MU8TMo+cKsshycy4K8tyxVVojyEKkv9JfsbRuzmyF6C/+M3u7
         oy70PbJQEkOvxDbEYHvLPYfxJhVSKiiACMUfQ6lo/Tlj016Iv0hzVIA5Zxsn0oF+Uyhh
         r3dSbTJpbRmXireN7DBOe8SVtJgNavGxJC0sB4c8o+1CSQNDGNoFSf8AceFOO8sX17B+
         0d/eeqsbX12sipkwGyjC+dTYQzu5eKJA9zsGwQYyFPThr2hXtHdp514hgpqxg2pOGaW3
         S2koBfPg67orwociSW2JX6atPP73RCbQLbp89jIK/keJIDFadyLxg3BpFCY9Nm0WVIaN
         SzCQ==
X-Received: by 10.224.167.84 with SMTP id p20mr20821146qay.24.1393123966457;
 Sat, 22 Feb 2014 18:52:46 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 22 Feb 2014 18:52:16 -0800 (PST)
In-Reply-To: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242535>

On Sun, Feb 23, 2014 at 9:31 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> Presently if you want to perform a sparse checkout, you must either do a
> full clone and then recheckout, or do a git init, manually set up
> sparse, and then fetch and checkout.

I think you could do "clone -n" (no checkout), set up sparse, then checkout.

> This patch implements easily accessible sparse checkouts during clone,
> in the --sparse-checkout option.
>
> $ git clone REPO --sparse-checkout PATH

Or take a file as input if there are lots of paths/rules.
-- 
Duy
