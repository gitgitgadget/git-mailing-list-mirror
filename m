From: Egor Ryabkov <egor.ryabkov@gmail.com>
Subject: Re: Git fetch/pull stopped working
Date: Fri, 11 May 2012 22:47:29 +0400
Message-ID: <CADB4Qb2-VB0LTrP8_i75V9e2FDeSjNLc+Pc4m73UJ0AX9NfX=w@mail.gmail.com>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org> <CADB4Qb35FfTL=XX04iR71+2Rg8p4s2roqAF8b_BdFNP9YN=sfA@mail.gmail.com>
 <7v8vh2v501.fsf@alter.siamese.dyndns.org> <20120508200842.GA14779@sigill.intra.peff.net>
 <CADB4Qb3sqy859k6QPuqU9u1cdxwz0LSQ7bdUXXFW_gQqaT+P3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 11 20:47:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSusZ-0000V4-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 20:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760357Ab2EKSrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 14:47:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49588 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759374Ab2EKSrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 14:47:45 -0400
Received: by yhmm54 with SMTP id m54so2911991yhm.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9X5ywRUPvKeZ7PIKL4nzKrH2JUdIpa7OKfzqWYPSkHo=;
        b=mEnnZV4qTwVLHP+odqW9f9PjtNF4ef3szi4iyx077udvcklFu94eT+62KtFcLn/rza
         NjHgxMKC+pcBXPUKk7ZK5a0oJv4SlznYzoa8DMe3vQFCZRHycQ2F/U+qwsPe8IxhZG+R
         llHOTkDcl0FKfflyOiRUcRJBpqZV7HORw3NqRRp03erHXylBjA2n0F7sK20dU3JTzr3J
         PYoSLvVy4guPjnLJmfTkEyod8VPFDnn52eUzxsVkpmkdWFcfykZDPUFpCDtwUcch3ZcS
         gaZl6upNrFt4dMBBNdw637Ihk8QCpVsVQWyL5YwYXi0MzXn86xHV/eKxM0aCCmc5bzra
         tlXQ==
Received: by 10.50.202.35 with SMTP id kf3mr868138igc.20.1336762064631; Fri,
 11 May 2012 11:47:44 -0700 (PDT)
Received: by 10.42.60.200 with HTTP; Fri, 11 May 2012 11:47:29 -0700 (PDT)
In-Reply-To: <CADB4Qb3sqy859k6QPuqU9u1cdxwz0LSQ7bdUXXFW_gQqaT+P3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197687>

Problem solved.

Turns out that was a miscommunication on out side: the guy who setup
the keys on that box left, and his access to GH repo has been revoked.

And GitHub returns "repo not found" rather than "you have no access
rights for this repository".


On Wed, May 9, 2012 at 1:28 AM, Egor Ryabkov <egor.ryabkov@gmail.com> wrote:
>
> > Agreed. It's hard to tell if there's a real problem or not. If the
> > redacted bits are the same,
>
> Yes, I checked this a few times and tried re-creating remote with the
> address copied from GH site.
> HTTP worked, SSH didn't.
>
>
> > then it is probably a github issue. In that
> > case, Egor, you should email support@github.com about it and mention the
> > name of the problematic repo.
>
> Yes, I actually contacted them last Friday, working with Simon Rozet now.
> I updated him on what we've found and sent him the link to this thread.
>
>
> Thanks for your help guys :)
