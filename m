From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] interpret-trailers: allow running outside a repository
Date: Mon, 7 Sep 2015 22:08:32 +0200
Message-ID: <CAP8UFD1x+fCG5Zv106r0cHFX+sQ6nt37KCrxVoVgenHgcjKFZw@mail.gmail.com>
References: <d8a4735a50d84010b81fd6a07a7c7403074fbb74.1441460208.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Sep 07 22:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ2iT-0004uO-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 22:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbIGUIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 16:08:35 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34623 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbIGUId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 16:08:33 -0400
Received: by lbbmp1 with SMTP id mp1so43441073lbb.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V6po1KF/IT2L14v1BZQj9Dy66aN94u2BnrSQlfvjBOY=;
        b=Eer/l+sIhA5/ngrrG4KiHCjJnw9YyujfzCI38Vv8pCX7DVlrnxBzAaPxpjcCh1ceeE
         ELtYSqLHl3iA6peedtqIcTfULN9pa7ZWG3oRhp/s1eWQhq8ez0f/MyLxSEEdV4gv/6Hc
         xSaIaTWjEY+A9F3WTjERx95tD+c86NqgcD+DS9oxBoCCOWO0Go4xiNph1wDWwwIoVa6C
         N/deu/C68HKTtPcYVj11xeZL0Tma84XdPpb/T8EMV9x9eaXYbOCjkAHGbSc/O9S0wYkb
         UAQqS4v0j+yULir8DO6t8SHCRP8GXnkgIBGvde4EhLS6UevwcHoOB7fIM5RqMLDkk9EW
         XjKQ==
X-Received: by 10.112.17.70 with SMTP id m6mr18501639lbd.113.1441656512198;
 Mon, 07 Sep 2015 13:08:32 -0700 (PDT)
Received: by 10.25.135.7 with HTTP; Mon, 7 Sep 2015 13:08:32 -0700 (PDT)
In-Reply-To: <d8a4735a50d84010b81fd6a07a7c7403074fbb74.1441460208.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277475>

On Sat, Sep 5, 2015 at 3:39 PM, John Keeping <john@keeping.me.uk> wrote:
> It may be useful to run git-interpret-trailers without needing to be in
> a repository.

Yeah, it looks like it works fine outside a repo.

Tested-by: Christian Couder <chriscool@tuxfamily.org>

Thanks,
Christian.
