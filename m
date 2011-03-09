From: Ruben Laguna <ruben.laguna@gmail.com>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Wed, 9 Mar 2011 17:35:50 +0100
Message-ID: <AANLkTikxPPo4pGqrvo4rdDUOwp1PYYEdcERVfXfLnsVh@mail.gmail.com>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com>
	<AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
	<AANLkTikuuzHZ897kOY2u0Sv=0JTDffo0UhcxkyynVQAZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 17:35:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxMMf-0002Xl-1J
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 17:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab1CIQfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 11:35:52 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39378 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab1CIQfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 11:35:51 -0500
Received: by iwn34 with SMTP id 34so655290iwn.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 08:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VPk3wRswjdiYAtDMAd1FL49pQ8wtVt2yYUFlTOXOdWE=;
        b=SKiv8+PHHZ/bzTU5W+AUtPRT/Xvn6srA/88tGT2UXUGQdrkCq29F2IveH848+qQnBp
         xBrVHx7pjqbsP6WmoCQQyT8TvKxp35VGOUgrfDEpHI3Ga5s1TgUCHzJM8gWDUvB+Z4zS
         GYpNDdGXl9AV6/299yQEhBkQoNtcT/Qgeq4tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oEboNnAd/60m47oDYaGgLlmBLLFhLnUZqVWrjAhlP/Ynqr2qie5GkR6iP634uLY4KQ
         9BMYjamqFvJvs/t5elJGUlBF2bbR8l0ilkHLPrl6PmDEoF5BKYwAk7yoHynTC+rqkCW9
         SLUSf1QTWxVMhr0AHqzn6HbmMqo6rL7YrM6rE=
Received: by 10.42.200.133 with SMTP id ew5mr8549890icb.182.1299688550949;
 Wed, 09 Mar 2011 08:35:50 -0800 (PST)
Received: by 10.42.18.202 with HTTP; Wed, 9 Mar 2011 08:35:50 -0800 (PST)
In-Reply-To: <AANLkTikuuzHZ897kOY2u0Sv=0JTDffo0UhcxkyynVQAZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168736>

> I just thought I'd mention that the git-remove-history script that yo=
u
> mention does filter-branch on HEAD, and not using the --all parameter=
=2E
> I thought --all was the best way to "catch all" branches in one go...
>
> =C2=A0 =C2=A0-- Tor Arvid
>

Much faster this way, thanks Tor,

But it still gives the same result 88MB


$ git branch -a
* develop
  master
  remotes/origin/HEAD -> origin/develop
  remotes/origin/develop
  remotes/origin/experimental
  remotes/origin/gh-pages
  remotes/origin/master

=46inally I have deleted my public repo on github, created a new one an=
d
pushed master and develop to the new empty one.


--=20
/Rub=C3=A9n
