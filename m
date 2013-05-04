From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Sat, 4 May 2013 01:10:10 -0700
Message-ID: <CAJDDKr7JxmfCDSdPCFhK87g8AuuBexLn-v6SkQh6k0uAbH7j0w@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-2-git-send-email-artagnon@gmail.com>
	<7va9oe5y6k.fsf@alter.siamese.dyndns.org>
	<CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
	<CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
	<CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
	<CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
	<CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
	<CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
	<CALkWK0nqoffHD3mfRqzanEuh4yG-cCO-YBGw8ApnG2uLKJaenw@mail.gmail.com>
	<CAMP44s2suBKMxKTPsOC15PxNrVZKCxDVz=0aaYc2v5h-DMHKRg@mail.gmail.com>
	<CALkWK0mhHDN3fAydTQN_wDhVzfiqo-UiRFG3eajAWk+S2dHGSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 10:11:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYXYY-0002eg-GX
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 10:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3EDIKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 04:10:18 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54979 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab3EDIKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 04:10:13 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so1243557wiv.13
        for <git@vger.kernel.org>; Sat, 04 May 2013 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=T9V/ebWrb82lAvTlLJtKM5OoIgILPqGU9d5/pGNcmyk=;
        b=NelErUDHfTtj0jFGg39kp1QRQUkTJkQ3in8qbP543DVVDIbXk1cqbvQOWyowyV0hOK
         2Vq/kz+ZKDQ3SUC+saMrmgcY8B6wYCBsaZsRFEEqXg/lejJIrlpmyDa2yuelZT6aya7X
         IvGKNd5UnI1OVXd9Ie/FMSvvrR5HpKD4MKW9ILWYiBr1nD6W6iK8RcRKrtdEvG+aGSai
         BF8nEI+3TSlE5AeaclqUEhOyEzJorWxtImWFUYLplBfj8lgfeLLoljGSboOAuwJBN9yx
         DXzF4ZC5r0EafHRUVwq7fz6RkOBAglrMIUBJTOeEtKkaFNL1TSjuaHeX7Une9DHEVbKn
         OnDw==
X-Received: by 10.180.21.243 with SMTP id y19mr1267727wie.13.1367655010176;
 Sat, 04 May 2013 01:10:10 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Sat, 4 May 2013 01:10:10 -0700 (PDT)
In-Reply-To: <CALkWK0mhHDN3fAydTQN_wDhVzfiqo-UiRFG3eajAWk+S2dHGSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223359>

On Thu, May 2, 2013 at 10:09 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> We probably should fix those, but that is orthogonal to the '@' shortcut.
>>
>> We can have the '@' shortcut *today*, with minimal changes to the code
>> and the documentation, in a limited and understood scope, with no
>> surprises.
>>
>> We can fix the symbolic ref stuff slowly, step by step, no need to
>> delay the '@' shortcut for that.
>
> Agreed.

If only we didn't care about windows then we could have this feature today:

    cd .git
    ln -s HEAD @

...and everything works, in the most natural way.
Has anyone else tweaked their repo this way?

Is an alternative implementation to change the template repo to ship
with a symlink?

For windows, perhaps we can use this new code behind an #ifdef?

Anyways, it's just a crazy idea.  I very much like this feature,
and in a tweaked repo @{0}{1} actually works.

Is there no way to tweak this at some really low level to trick git
into believing the link exists (even when it doesn't)?

I guess that's what these patches do, but the limitations seem unfortunate.
--
David
