From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Mon, 1 Jun 2015 07:47:18 -0700
Message-ID: <CAKRnqNKWb5upY5Xm07UgJvk5SfPVdAWhR=MFkAbRDy4RFaLxRQ@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com> <CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
 <CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
 <CAKRnqNJnaLioQPWYDmSiBfLCSMGdFR21bAEXRzdpkChDBf2wgw@mail.gmail.com>
 <CAP8UFD1rKmKgKqCsffCLyOCny3JEACxgmBN_eqOj_=3zBW-MZg@mail.gmail.com> <CAP8UFD0_RCOHUF6BgczgS5kWAFc0QKdw4cUy_bpB2jhd+kYWdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:47:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzR0E-0008C5-T4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbFAOrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:47:42 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38578 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbbFAOrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 10:47:41 -0400
Received: by wizo1 with SMTP id o1so108321270wiz.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/5v3INc/4GfAiEJSR1z+gN1erWoNDsO1dGXuGeKe2X0=;
        b=ZZkZ3VDKMizIVmtM/SsdA0U8XF5N0+MXqDsluz7122v5FT1no//cBJxOBMenxwxxyw
         7fbukqLYDKWfthZEQ3QodT3JpsCEdkruETdkjJJLRZfmy0ccpComWHy/Npnra/zAk+PR
         VOWd7NQiMgvlhoSkHtMaJrf+IN3jS8bxc4uu8DV1lrknCYFoiHreHUejBMaRtfzqiAHW
         eSfbXxiRFhyOZ0ZBmS+5+n/dQHXmp62dqw1bQ3zrvmP42pffWSi2jio1ZvmLQI51M2H4
         9R68aCJjRVotfV0UuZV4AukbsfWTcGiGy4egx6fBuDHiZLtIm+KWeimaWfXZ75uBFBS/
         7IJw==
X-Received: by 10.180.107.70 with SMTP id ha6mr21385656wib.20.1433170060472;
 Mon, 01 Jun 2015 07:47:40 -0700 (PDT)
Received: by 10.194.208.234 with HTTP; Mon, 1 Jun 2015 07:47:18 -0700 (PDT)
In-Reply-To: <CAP8UFD0_RCOHUF6BgczgS5kWAFc0QKdw4cUy_bpB2jhd+kYWdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270418>

On Sun, May 31, 2015 at 4:53 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>> (Please don't top post if you reply to this email as it is frown upon
>> on this list.)

WRT "top posting", two points:

1. Too many sites/lists now *require* top posting
2. MUA's (like Google Mail) hide the old mail as an obscure squiggle
at the bottom of the page.

Time to just get over it and accept the fact that there are two
conventions.  I did.  I only gave up a decade ago.

> $ git format-patch -o patches --ignore-if-in-upstream
> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
>
> It is interesting to note that the last sha1 refers to a tag:

They both do.  I tried "git format-patch v1.3..v1.4" but that didn't work
and I knew that SHA1..SHA2 would, so I got the SHA's for the tags.

> It works when the tag is replaced by the commit it points to, and the
> segfault happens because the we try to access the "parents" field of
> the tag object as if it was a commit.

The other discussion started *after* this one, but thanks for the pointer.
