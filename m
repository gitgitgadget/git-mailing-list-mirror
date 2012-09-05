From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Renaming a remote is 'rename', but removing is 'rm'
Date: Wed, 5 Sep 2012 15:49:45 +0700
Message-ID: <CACsJy8Bi=b1Fuht8q5XcnGE3rFAVojj+MAXvKZAnrqseYnDy+g@mail.gmail.com>
References: <1346831961-ner-2892@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:50:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9BJa-0006YY-8w
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 10:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab2IEIuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 04:50:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56929 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757945Ab2IEIuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 04:50:16 -0400
Received: by iahk25 with SMTP id k25so442818iah.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fV3xO31Doi9WftJzMl5ZMc7PBYAd++1mhEO0W7GlmW0=;
        b=iljD+8Lxu+FyKnxn6tI9xMy+zlpEs6cUB+MwYlxmWeev1BN7nlRVdwi6FOY5m2XTZz
         AQN7Qr33ZlMnQWn650viD1mBEmbD83SmrNhgtKC1PYmHXvD7ZAezc0bEeixJBBQ3RhTf
         EjSc2KU7TvyJMRmP3IKwRQfIUNU+NNcS8rVMVx42rDZr64sy49UbEWCVns7vcLoHN4BV
         CyzFoP22HA02QIdynF8Uyjkr/uKAppfJR1Td85SQoEZhYb8VCwTErC4YhXKUp84zzTfQ
         /m3lpWvNZMPxSgFfwB1pwEjSnF7nK+wPW88gszZU1hziokAoGHIAHocP5Ey7lXxNhKOI
         ahMw==
Received: by 10.50.193.201 with SMTP id hq9mr16870126igc.48.1346835015749;
 Wed, 05 Sep 2012 01:50:15 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 5 Sep 2012 01:49:45 -0700 (PDT)
In-Reply-To: <1346831961-ner-2892@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204804>

On Wed, Sep 5, 2012 at 2:59 PM, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> A fella on IRC was confused by $subject. And it did bother me sometimes as
> well. If you don't use `git remote` often, it is confusing that the commands
> are named inconsistently.
>
> If I know that there is `git remote rm` then I kindof expect `git remote mv`
> to exist. Because I am used to rm/mv and git rm/git mv as the standard unix
> commands for renaming and removing something. On the other hand, if I know
> that there is `git remote rename`, with the verb fully written out, I expect
> `git remote delete/remove` to exist (or something similar, with the verb fully
> written out).
>
> Would there be any desire to make the subcommands more consistent in that
> regard?

Looking at the remote command list, "rm" is the only abbreviation. I
guess we should add "delete" (or "remove") as an alias for "rm".
-- 
Duy
