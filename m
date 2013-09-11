From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Windows: Do not redefine _WIN32_WINNT
Date: Wed, 11 Sep 2013 22:03:27 +0200
Message-ID: <CAHGBnuPdixkH42SNW0enF8C-GFwH8gX8NOXb69VscV3qvA6bxg@mail.gmail.com>
References: <52309507.1090908@gmail.com>
	<xmqq4n9rtdol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 22:03:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJqdY-0006If-9V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 22:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137Ab3IKUDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 16:03:30 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36093 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757153Ab3IKUD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 16:03:28 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so76688lbi.39
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bgBAyVz3Pqw0enGMEEMUB8YgY+ou4Df3qjBLyGs74T8=;
        b=y3Ngkby//F1eMUhYvChZlCKfTMwN/2V8i4iE66FbjoRIJLpf6/DJa9jbCNm7sVsRSS
         TbZbftrWtqUMGkbd/GKX1bSFUzKtHCWiLCQTC1n748Xrv05Rakcg/isDTvPU/PBHj967
         pe8Vt8xArzXOMY4BDS8YQHPgUneg1im1LA3mez9ONL/SLj12bkQu1s/BVKbw1JxjJi+f
         mu4+KMN1Mg73IcjpeEiLo5ZWeu755f8c/Xm5ZEmL89rK4R4DCTtqE90u7nvehi8wMFQJ
         N5ftZ4QAPUULe93XDlc3QELVzGGzz/pj3yiOp1dZmNGiVRXyzeeFvdpn1khEyYed9L+G
         kMXg==
X-Received: by 10.112.155.39 with SMTP id vt7mr3987060lbb.29.1378929807170;
 Wed, 11 Sep 2013 13:03:27 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Wed, 11 Sep 2013 13:03:27 -0700 (PDT)
In-Reply-To: <xmqq4n9rtdol.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234606>

On Wed, Sep 11, 2013 at 8:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

> This unfortunately does not seem to match what I have. I think the
> patch is based on the codebase before these two:
>
>  380395d0 (mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE, 2013-05-02)
>  41f29991 (msvc: Fix compilation errors caused by poll.h emulation, 2013-01-31)
>
> I could of course wiggle it in, if you want, but I wanted to know
> what is going on.  Is it a pre-release freeze period on your side or
> something?

That's right, I currently have a code freeze at Git 1.8.3 because I
need to solve several other issues with Git 1.8.4 on Windows first.
I'd be grateful if you could "wiggle it in".

-- 
Sebastian Schuberth
