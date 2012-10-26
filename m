From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Fri, 26 Oct 2012 22:43:41 +0200
Message-ID: <CAC9WiBhZWJihPToMawPCxEVkTKL0e-GzUw3qneJMUx-WqSNbjw@mail.gmail.com>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
	<508ADFAE.1050800@web.de>
	<CAC9WiBjiHLJggUzmmx4sPpXNNq=Kz0TOZAzmRShc1AZcPjGvig@mail.gmail.com>
	<508AED26.3090805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 22:43:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRql2-00089E-18
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 22:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966054Ab2JZUnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 16:43:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35493 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab2JZUnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 16:43:42 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3052198oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OjkH8pj+G0Ut4uLiy97d77GdFZjdwBlfs24/bwokCMw=;
        b=qrOOXjf5SeQkNHByApr4reS+hiYyd1cybO1VEBMELLr9tgFh/J2yoc/jx4Obi1Qbxb
         JxMCCeklVLIb37wYibEvh7Wm84Q6CWV4HIaQ1ckUjz71JiRgo5H4TOud+ZFoBOes69xb
         iCWPVF9YYqGC2YQe6hS9G7a4SSRWLrH5eI1XWX+QwFh2B4U6eS9M/b3/hJzf9Ofl7RWI
         QyJ0py2BLpzb+dimRDrRUzIH/fwitaaDFH1tc1Scsf5HG1o65ABSktLKULOv5VislJMu
         d07p6fE/cUWQXQKtbsl6TScv0Rw6ChJqPasHmzH8BDniqLTSUvP2edKlh+VyOxRTCYlB
         5F+g==
Received: by 10.60.172.48 with SMTP id az16mr20151368oec.64.1351284221764;
 Fri, 26 Oct 2012 13:43:41 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Fri, 26 Oct 2012 13:43:41 -0700 (PDT)
In-Reply-To: <508AED26.3090805@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208491>

On Fri, Oct 26, 2012 at 10:05 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
[...]
>
> That is weird, "git diff --submodule" should show that too. Is there
> anything unusual about your setup? (The only explanation I can come
> up with after checking the code is that your submodule has neither a
> .git directory nor a gitfile or the objects directory in there doesn't
> contain these commits)

Oh now you're asking, I think the submodule has been added by using
the --reference option of git-submodule-add.

  $ cd configs
  $ cat .git
  gitdir: ../.git/modules/configs

Thanks
-- 
Francis
