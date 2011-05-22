From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Sun, 22 May 2011 19:41:07 +0000
Message-ID: <BANLkTinx1oaqcUSZo-fRAZeHfuoFifVNGQ@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 21:41:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOEX0-0005ni-LQ
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 21:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735Ab1EVTlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 15:41:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55491 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab1EVTlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2011 15:41:37 -0400
Received: by iwn34 with SMTP id 34so4214945iwn.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=tQCHwgmXVWLfI+Wz2r/N2V5kXn0qS4GFALRMKqmicCE=;
        b=SUJSswgk8SvIhBfPfHBY9NLQ7/YWO2LhYZH0CqH5Ol1YNS0HgrPi2LRUQK3KtEiFpl
         nQuPx7Fs4HlvIxKLd2yannN6Ki5pvZk5qKhmuAcbKsBaG2BQupwnxIlHj0tx0NRw272e
         pblLKA3+CdGYuDQj4yQjzRXTGiY/bjtD//CBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IHEqsLUy0ObaFEYLjLgsG1Km2YiWm7AMt+E0HMiGgM7+KSbaWh2yLbIh7LBRLj0CRt
         Lg5mszHjUOomiTkOwJqvBdH1DAxlRD06eFUDHSZIIxx/Gwfdo3zGD93v5lJBdNZytGUY
         0CHlgW0ob1yexmCQ2ckVhJhs2KhHqCz3pMLIc=
Received: by 10.42.168.132 with SMTP id w4mr1657034icy.217.1306093297122; Sun,
 22 May 2011 12:41:37 -0700 (PDT)
Received: by 10.42.173.72 with HTTP; Sun, 22 May 2011 12:41:07 -0700 (PDT)
In-Reply-To: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174197>

On Mon, Mar 28, 2011 at 09:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> But instead I have to do:
>
> =C2=A0 =C2=A0$ git bisect start
> =C2=A0 =C2=A0$ git bisect bad
> =C2=A0 =C2=A0$ git bisect good HEAD~100
>
> And then proceed to mark good revisions as bad, and bad revisions as
> good.
>
> That works, but it's very confusing.
>

To me, at least, that seems perfectly reasonable.

In particular, the problem seems to be your own thinking:

> And then proceed to mark good revisions as bad, and bad revisions as
> good.

Don't think of it like that.
