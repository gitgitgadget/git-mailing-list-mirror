From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Thu, 30 May 2013 02:42:24 +0530
Message-ID: <CALkWK0nQvCJkf3nOEZqT3yy_m7jvCPxHSnY-9_QSUaPXDmJWjA@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
 <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
 <CALkWK0kv-5vAMsrtpPffBaSZrHfm98KNDL8Jw6_pSLsL=8=8iA@mail.gmail.com> <CACsJy8Dvpn0u1i8M7uxsB=t4NE5v78=gYiY=XFC=KK7f4D=N=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 23:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhngG-0005xD-5l
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 23:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967001Ab3E2VNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 17:13:08 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36537 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966994Ab3E2VNF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 17:13:05 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so9697929ieb.34
        for <git@vger.kernel.org>; Wed, 29 May 2013 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1nfHiQConXyUYHGQ0qnrd/vatJNij+LQF9ABf0MhDYQ=;
        b=yt6tZvknuqyOxUNZ0hqY4zXl6SyUCPIQ2aSfniLBNzXDzxLj81XB1c2VBh9soNfPeF
         51qk8ERIZWf1r4ssR4JVFocnbBHs8PDauGM2ugj9rWpnAZDH/SgbLzBi70TDlS4OSzGJ
         x0lwxUMHmlMRvb/rKfvokqSiqbVUvH5+UqOXpVH4F/8ue3XIA+Z+vM56ec1U9HjgoLhL
         DWOudU0aZ3wXvEyneLPCOz4YaSpfBKS2I1HMwwdtvRThPpWD/p0wMW7dIf28pWGeEeS2
         z0Lq15slZO8tzbtysbqb1MZe6Auh6Evk3bW0VlREIcePthpRgCi65vMFZTSR4ey7mIES
         baYA==
X-Received: by 10.42.31.69 with SMTP id y5mr1888300icc.44.1369861985031; Wed,
 29 May 2013 14:13:05 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 14:12:24 -0700 (PDT)
In-Reply-To: <CACsJy8Dvpn0u1i8M7uxsB=t4NE5v78=gYiY=XFC=KK7f4D=N=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225889>

Duy Nguyen wrote:
> It's because you don't pad enough spaces after %(refname:short) so the
> starting point of %(upstream:short) on each line is already unaligned,
> I think.

Yeah, my stupidity.  I really meant %>|(30), and that works fine.
