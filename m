From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: coming from git, understanding mercurial branching
Date: Fri, 6 Sep 2013 12:39:59 +0800
Message-ID: <CALUzUxoa7Lw-_sj3LRj-9=hSh17hi+j4JhfAPKaDfhuE8PnKCA@mail.gmail.com>
References: <20130905212714.636db4c4@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 06:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHnqL-0002Bo-BH
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 06:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab3IFEkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 00:40:21 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39028 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3IFEkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 00:40:20 -0400
Received: by mail-ie0-f170.google.com with SMTP id 16so4997590iea.29
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ivz6NtTrpaGNYWJRIvphEcJ3XHlUcSXp1dQ4UoAXJAA=;
        b=rn1DXemLYo77v3MJwvsL2rl6L6xsQhtF0PuyhoDW1BhYHJTjq4IwCyJ1+1Gy+DTDO7
         YM3p85Qh4EyraBn0/wWrigMGghypn/s6iXGCn9niCQeyCfJU32r9DMvwFKXTLmrt8MNI
         ZEKxhXbHu8Y+M/xIbnb3i2O8MOziLkifRjcodMS3vC4Z2mIzRFkHyFu30wqVCRv973JB
         WB/5EqgmfXRHDqC0WJkRU77zzBBoPcyIB/CddzErOHTwpxPuzYSwzYSkjsAFB71h6TIR
         06UVrllMvPF0PE67mBhPC182l7wggkNfcl4aRdaGBkQhdOCBQk+xq9nD+7fO8LS/FJeb
         qdGg==
X-Received: by 10.50.83.70 with SMTP id o6mr330168igy.60.1378442420051; Thu,
 05 Sep 2013 21:40:20 -0700 (PDT)
Received: by 10.64.31.133 with HTTP; Thu, 5 Sep 2013 21:39:59 -0700 (PDT)
In-Reply-To: <20130905212714.636db4c4@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234018>

On Fri, Sep 6, 2013 at 10:27 AM, Tim Chase <git@tim.thechases.com> wrote:
> I've got a pretty good grasp on git's rather straightforward
> branching, but am trying to wrap my head around Mercurial's
> branching.  There seem to be several flavors, some default to
> push-public, while others are private; some are tracked in history,
> while others seem more ephemeral;

First: recognize Mercurial's branches are entirely different beasts
from Git's. They just happen to be given a same sequence of
characters, b-r-a-n-c-h. The similarities end there!

> often the docs suggest cloning
> instead of branching; detached heads seem more normal in the
> Mercurial world.

Are you referring to this?

  $ hg clone https://... master
  $ cd master
  # hack...

  $ cd ..
  $ hg clone https://... fix1
  $ cd fix1
  # hack...

  $ cd../master
  $ hg pull ../fix1
  $ hg merge ...

In git, you would have your master branch, checkout -b fix1, then
merge them back to master when you're done. The above describes how
one would do this in mercurial.

-- 
Cheers,
Ray Chuan
