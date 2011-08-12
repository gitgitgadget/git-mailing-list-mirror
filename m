From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] sequencer: Remove sequencer state after final commit
Date: Fri, 12 Aug 2011 07:49:35 +0530
Message-ID: <CALkWK0m68_N3nJD91q=WRvBmGefGYX6vs-exgxkhXajDfzvKxA@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-7-git-send-email-artagnon@gmail.com> <20110811201755.GJ2277@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 04:20:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrhLt-00014H-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 04:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab1HLCT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 22:19:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51484 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab1HLCT4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 22:19:56 -0400
Received: by wwf5 with SMTP id 5so2605756wwf.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 19:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wXhHeV0aQxtemejq3g2NhNlz3y/pPZI9Qut9T9uWKWc=;
        b=CxlBo/x4XqQOTvk+WJ6c1KZQDzZmS2ywuLHZaIlj3gzXd1h3diRUDt1Np4yqEojE+V
         gTEH47HI1bJjOWzBYrewFrMzk0GcHDz8qu8WidpkoGreVNV8+hCptip+kGBHm5s6AQXk
         4mN4VxZvyQCpYLlH715rSRpDDkvfGhgbPScrQ=
Received: by 10.216.160.9 with SMTP id t9mr1992290wek.108.1313115595124; Thu,
 11 Aug 2011 19:19:55 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Thu, 11 Aug 2011 19:19:35 -0700 (PDT)
In-Reply-To: <20110811201755.GJ2277@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179160>

Hi again,

Jonathan Nieder writes:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Dear sequencer, I'm commiting!

Interesting.  I was worried that sequencer_count_todo() might be a bit
of an overkill.  I can't find any other usecase for counting the
number of commits in the instruction sheet right now, and it's
unlikely that I'll find any callers for it in the future either.  I
suppose we can save time by just counting until we figure out that
more than one commit exists -- there's no need to find the exact
number.

Thanks.

-- Ram
