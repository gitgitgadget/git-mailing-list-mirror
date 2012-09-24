From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 19:22:20 +0700
Message-ID: <CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com>
References: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 14:23:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG7gi-0004rx-R6
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 14:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2IXMWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 08:22:52 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46951 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab2IXMWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 08:22:51 -0400
Received: by ieak13 with SMTP id k13so10607838iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LKpCOtQMZhP0NuPirFUSSEADLyo2GPiTzGUQWHjmZEU=;
        b=XugXSi0TvBKU/0AgEHZr4hKqKWM6js2ZqlvzdP97Dk4Z1XNa7gK1nBMbQz5hQVwQWW
         tDhYBAGINQkJ4IY3Bk6Oq0iSJpVjGJsah6tJ9zTmdFk5Maqh1eNuNz/dY0PGQ5loSjXU
         Lv57BXa3mhmD4eb7FS1bqqgZuqVJVK/+IPObwjs7I1337EsAVnOb7qu//k2T2LQJTDMs
         aBmLNkFOD2g/JSgwktqIpnq0E/uZ0e++XyiqnWgstWBkuY1izZi979GxtEVGE5eA2yt6
         tIBKS+5O29oFfkP0dmFiEvF9UBBFY8q4RxErPPeReugj6eodF31YMxc3ciEfuFWtgU46
         cTug==
Received: by 10.50.154.225 with SMTP id vr1mr4984955igb.26.1348489370658; Mon,
 24 Sep 2012 05:22:50 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 05:22:20 -0700 (PDT)
In-Reply-To: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206262>

On Mon, Sep 24, 2012 at 6:59 PM, Johan Herland <johan@herland.net> wrote:
> The following works in the git.git repo:
>
> $ cd t
> $ git log -- /Documentation
> [...]
>

What version? Mine (recent master) does not work

~/w/git/t $ ../git log -- /Documentation
fatal: '/Documentation' is outside repository

> but the following does not:
>
> $ cd t
> $ git log -- /Documentation/RelNotes
> fatal: Could not switch to '/Documentation': No such file or directory
>
>
> Is this the intended behavior?
-- 
Duy
