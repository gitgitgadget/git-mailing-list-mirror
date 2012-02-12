From: Scott Chacon <schacon@gmail.com>
Subject: Re: Git documentation at kernel.org
Date: Sun, 12 Feb 2012 15:04:59 -0800
Message-ID: <CAP2yMa+2E6101fe3Z2WTCfuGnq17WT7nDUQr7PVH6_YKRnNifw@mail.gmail.com>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <20120210200401.GB5504@sigill.intra.peff.net> <vpqehtz909k.fsf@bauges.imag.fr>
 <20120212222508.GA25619@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 13 00:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwiUQ-0006Vr-Pp
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 00:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab2BLXFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 18:05:20 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46473 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab2BLXFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 18:05:19 -0500
Received: by daed14 with SMTP id d14so3970156dae.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 15:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JXx8W41y/XAfG+fvkfVul2jDPy/BUe6M17T0mwN8Umo=;
        b=wYoF3qOms+1d/T0pLPKcWe/lECiRfCQ3VO6ok1ZwXCwkCK/6ZSCaOf/Lvy/tUnksLD
         u8C0S8pPgSpKZWpU8rbxdJ8xHEWcGGzuv3W0wdrtUmgr26tgnf9nmvmfKwqe9SGwa9+Q
         ivH5OsS7+fWX7SEf9jejS508DDzgrt9o30N8k=
Received: by 10.68.74.134 with SMTP id t6mr40836528pbv.26.1329087919233; Sun,
 12 Feb 2012 15:05:19 -0800 (PST)
Received: by 10.68.22.72 with HTTP; Sun, 12 Feb 2012 15:04:59 -0800 (PST)
In-Reply-To: <20120212222508.GA25619@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190593>

Hey,

On Sun, Feb 12, 2012 at 2:25 PM, Jeff King <peff@peff.net> wrote:
>> kernel.org is probably the most "official" place for developers, but for
>> Git users, http://git-scm.com/ is most likely the best entry point. If
>> it were not for historical reasons, I think http://git-scm.com/docs/ or
>> so would be the most natural URL to host official docs.
>
> Good point. That is probably the best place to host it.
>
> As far as historical reasons, perhaps the right answer is to put the
> documentation where it makes sense to go _now_, and ask kernel.org to
> issue http redirects for http://kernel.org/pub/software/scm/git/docs.

I would be happy to set this up.  I'm currently in the process of
revamping the website and this is one of the things I'm planning on
doing anyways - not just hosting the generated docs, but also making
them searchable and whatnot.

Actually, as long as I'm on this, what do people think about git-scm
hosting the wiki as well?  As far as I can tell, it was down for
months and now it's back in some sort of weird read-only state.  If I
imported everything into a different wiki and hosted it on git-scm
would that be acceptable?

Also, something that I realized I am not willing to maintain any more
is the Git Community Book. It was an experiment at reorganizing some
of the docs, but instead I spent my time on Pro Git, which is CC
licensed.  Would anyone object to me removing the community book from
the git-scm site and more tightly integrating the Pro Git content?
It's more up to date and better content, I feel - I would rather have
one book to maintain than two.  However, since it is a commercial
product (albeit a Creative Commons licensed one), I wasn't sure if
people would have an issue with it.

Scott
