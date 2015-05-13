From: Stefan Beller <sbeller@google.com>
Subject: Re: [Q] do we have your name correctly?
Date: Wed, 13 May 2015 15:58:47 -0700
Message-ID: <CAGZ79kaNXRbJ8DEfFahSSOgpawt1v=v0eWwAEtPQqPaoE1sb5w@mail.gmail.com>
References: <xmqqa8x89k0x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 00:58:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysfc6-0003wd-QU
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 00:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934535AbbEMW6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 18:58:51 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36117 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965593AbbEMW6s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 18:58:48 -0400
Received: by igbpi8 with SMTP id pi8so152751353igb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k1GC1JaSEFLzxzexmP+5A6eYwQIdWZloDQ1hjm7OKlE=;
        b=iMK5M+C7Ao5RFP65TvrlWLPF6h/reXmDhVzB/AnaYEyO510fzqR+axjg/Gxxz3J6GS
         Xwo3QzWd1bZDAMKLqAuas+UxLJ/pZcxbUDv623F6aPqDY6YenlcUgm7+xgwU8b047Mag
         kT6+Eye//9nFr1/GcdBvW9s4NMA5kQK1b3AioucnKrQHUsqB4l89xxUdqIXQASyMO5Jt
         dUqIjer7Qg49KPm0fayrj1Cj4N9za+PZaWZOK6AT0XP1dWhlxqXeKQrRERMA968vnNao
         5l+S7WAw82rxHc9jbvLhFP7RPFMN3xhLjWfq1zGvT2ETyiiAhvpeqGG1QX4jp4uGPyHv
         BMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=k1GC1JaSEFLzxzexmP+5A6eYwQIdWZloDQ1hjm7OKlE=;
        b=L8A/XBsz0jwmvsayQc42bU7bDZE8IP4s1YXCKWrFV+JfoOMrR5fDGdxKWXkkE0qnFZ
         xv0I//pkW2ACpzbMDrQ11xC3F9PUAt4sT34gVK72ZKZ9/Nrx74AWOW9B2Q1tL7MR0jGB
         JjmNM1+6fEX1L/uBK3CshsdNbrpNHqY94NWcOhoCoVm5L/LR7R4j0BZLlf94S7tGcce+
         fawxqhbKWEq/vfjb6O5ffnnuLj7L7Xr/JFPXebQa+PYdbYabRl5007Tr//bnwgqYx1IG
         e/+VqKrQjgAZuaOehkey9bPsXlmDaSkWNngQnSWSSGjHBfkpAuxR0nxxK8aHQecxsgQ7
         j5+Q==
X-Gm-Message-State: ALoCoQmG/7tbTVo33WGt13zLxevctbNg623v6tfIUmwBQLUmVYKp1/kUY6E3KixHvvHZL0uE8yY8
X-Received: by 10.107.13.11 with SMTP id 11mr1579232ion.70.1431557927339; Wed,
 13 May 2015 15:58:47 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Wed, 13 May 2015 15:58:47 -0700 (PDT)
In-Reply-To: <xmqqa8x89k0x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269015>

On Wed, May 13, 2015 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Before cdb6b5ac (.mailmap: Combine more (name, email) to individual
> persons, 2013-08-12), we used to have this entry in .mailmap:
>
>     Brian M. Carlson <sandals <at> crustytoothpaste.ath.cx>
>
> but then it was replaced with two entries with that commit to
>
>     brian m. carlson <sandals <at> crustytoothpaste.ath.cx> \
>         Brian M. Carlson <sandals <at> crustytoothpaste.ath.cx>
>     brian m. carlson <sandals <at> crustytoothpaste.ath.cx> \
>         <sandals@crustytoothpaste.net>
>
> (they are two lines; backslashes are just for this e-mail).
>
> Because the RHS is searched in the committer and author fields and
> replaced to the LHS when .mailmap is used, this forces your name
> to lowercase, which is against the normal convention on this list.
>
> I *think* the motivation behind the original .mailmap entry before
> that commit was to upcase the name so it does not stand out oddly
> among other peoples' names, and I am suspecting that cdb6b5ac did
> it in an opposite way by mistake.

Yes, it was a mistake. The motivation was the same as in
(94b410bba8 2013-07-12 .mailmap: Map email addresses to names)
which did not talk about the whys unfortunately.

The motivation was to get a clearer picture of the git.git developer
community. If you ask how many different people actually contributed
to git.git, it can be easily answered by counting lines in

    git shortlog -sne

also you would find other interesting data in such a shortlog,
both person related data (How much did person X contribute? It's hard
to find&compare that if this person contributed via 5 different
email addresses)

And other statistics can be learned from a well organized shortlog.
I was reading about gits development model and how much the
community is involved compared to other projects (I must have been
reading The cathedral and the bazaar at the time), so I wanted to find
out the ratio between core contributors and community (those
who just throw a patch or two over the fence and then move on
with life). And specially that question got me into organizing the
.mailmap file in the first place.

I am sorry about the mistakes I made back in the time.

Thanks,
Stefan

>
> Here is a suggested fix; comments?
>
> Thanks.
>
>  .mailmap | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index ece2951..8d42ac0 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -25,8 +25,8 @@ Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
>  Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
>  Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
>  Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> Brian M. Carlson <sandals@crustytoothpaste.ath.cx>
> -brian m. carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
> +Brian M. Carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.ath.cx>
> +Brian M. Carlson <sandals@crustytoothpaste.ath.cx> <sandals@crustytoothpaste.net>
>  Bryan Larsen <bryan@larsen.st> <bryan.larsen@gmail.com>
>  Bryan Larsen <bryan@larsen.st> <bryanlarsen@yahoo.com>
>  Cheng Renquan <crquan@gmail.com>
>
