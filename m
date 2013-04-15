From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 23:20:56 +0530
Message-ID: <CALkWK0=S3=cLxJ85M-efD7fym29Y_pD5XyeBsunkiuPV=vVR4w@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Apr 15 19:51:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URnZ9-0006CP-8c
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 19:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933716Ab3DORvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 13:51:39 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:33535 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab3DORvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 13:51:38 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so2487064bkc.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xnkbRTVw3vYRriCTjIIjwMLEmyfTXw6sxvInhhAbdks=;
        b=rb5W8IvWe6XBrxhWTmNX9+1+mg+ei+V3UUuJ3+GFE9bfn3sri1tYbvPRzfNorgTLMR
         P1DCcxHXMkl7bZX2dZe6rL+ccL+cOZXOnIuKnfcHe28eqSP6fYwVcXj6fpusYQo+wfIq
         PWruYOnxOvaPo9KmRy67Ix2yU13nLodRXhsG4eZTlTMJT66dKaRUCQFz0aQ1KswAcY70
         TbgBBQwPJ19tVuuba2jQyBRK4pELx1T4cVqvo8oHjF4TBxKeL5pw+Sk1mnVDgSmP84Uc
         6HsmW81yBNmC397ecAJcEH8t33+XRFGHUhvDE60jYT+vL90jAtF4PZpTTPsbCF1suTr3
         5XBA==
X-Received: by 10.204.189.76 with SMTP id dd12mr8644163bkb.80.1366048297007;
 Mon, 15 Apr 2013 10:51:37 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 15 Apr 2013 10:50:56 -0700 (PDT)
In-Reply-To: <516C21CF.5080705@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221274>

Marc Branchaud wrote:
>         git add ssh://host/blammo.git

Heh.  And I want git add *coffee* to make me coffee.
What's your gripe with git submodule add?

> I could have
>         ~/.git/
> to maintain revisions of various personal files, config .dotfiles, scripts in
> ~/bin/ and so on.
> [...]
> Now, are these Code/* repos inside ~/.git/'s worktree or not?

Please don't version your entire ~, effectively shooting yourself in the face?

Use a dotfiles repo and write a simple Makefile to symlink ~/.etc to
~/dotfiles/.etc.  If you're looking for a good example, see
https://github.com/artagnon/dotfiles.
