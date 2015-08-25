From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 08:13:08 -0700
Message-ID: <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 17:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUFun-0002gc-BP
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 17:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbbHYPN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 11:13:29 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37590 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182AbbHYPN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 11:13:28 -0400
Received: by igui7 with SMTP id i7so13470981igu.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QqvWrVWVWzWpYH5lwvOUvnbMgnxkQCX6GkQ8+e20kGc=;
        b=IT41JyQ+0LLVV0YMyNKGa37KinWpOoMNEOPUkO/CR7tXB7dvN/BYxIXHnfUKykjzxr
         432PgXq4YZ+yPKj5ZB7wWFXFOImojBo8un14Owt91I8VpVFosIM1HfDoECnhI9qVcVMj
         QRmGOuxlA2PoDMcsZ+KNNHggs1imxuLdxNRZzTO6QMrabFY2bODjBu8bjQ9yRVWs+oP3
         peTR4+tkr+tcde+UiNxXZdNegqUbs99yjPc+fMaXjCtDNQfn93OIi80dOLjnDX/fpSp4
         8yAVnIbe3Qn/4rbGmuiU6jNp7xS78nn+8J+nI+m76MlN2KdTik7cOObGRh+7QN3lgQPo
         l5Lw==
X-Received: by 10.50.50.129 with SMTP id c1mr3446179igo.60.1440515607632; Tue,
 25 Aug 2015 08:13:27 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Tue, 25 Aug 2015 08:13:08 -0700 (PDT)
In-Reply-To: <mrh7ck$r0g$1@ger.gmane.org>
X-Google-Sender-Auth: GUpj_QhH2NIhTK-WHdSXdgYzVN4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276532>

On Tue, Aug 25, 2015 at 1:01 AM, Graeme Geldenhuys <graemeg@gmail.com> wrote:
>
> Even though I have worked with Git since 2009, I still have to
> reference the help to remind me of what parameter to use in certain
> situation simply because similar tasks differ so much.
>
> Maybe we could address this in the next major version of Git? Has
> anybody else thought about this or started work on this? Or was this
> discussed before and declined (link?).

http://article.gmane.org/gmane.comp.version-control.git/231478 comes to mind,
which has been linked from this entry:

Discuss and decide if we want to choose between the "mode word" UI
(e.g. "git submodule add") and the "mode option" UI (e.g. "git tag --delete")
and standardise on one; if it turns out to be a good idea, devise the migration
plan to break the backward-compatibility.

in http://git-blame.blogspot.com/p/leftover-bits.html
