From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Sat, 4 May 2013 01:16:51 -0700
Message-ID: <CAJDDKr4CQ9D8RewcR4uMd4iGS3HtKo+-knex+NshVxmc_4517Q@mail.gmail.com>
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
	<CAJDDKr7JxmfCDSdPCFhK87g8AuuBexLn-v6SkQh6k0uAbH7j0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 10:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYXee-0008GT-Mp
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 10:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab3EDIQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 04:16:56 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:53184 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3EDIQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 04:16:53 -0400
Received: by mail-wg0-f43.google.com with SMTP id c11so2252811wgh.22
        for <git@vger.kernel.org>; Sat, 04 May 2013 01:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4fzVNIF+Q6tTXEef1c7ECpxNEJ47SDT8JVyIRvnYwqs=;
        b=kvaPj/ypkpKqmwYQYO/3cxw8ix1VKwWV+T6hacDe76Dbxs5NRdswuCtfGeX2yfVkU5
         79jWtDVVFO6cYFAsbGQwvqN8/1s/agPGoJB+6EizW8+5t5xZofR6CXhmugns8ezaZsRO
         wCDvXoj9QeNYXxZKQlXZxFMIabTKwenZLfi1/it+kvsfh4XlKc5Jz+UIw0Z2m+GhsR9r
         qCbaNh1729tQRK6oEZ3Fhy0dc94eWUxPDq1Mco7kHmeO+PkyCdFJ/F4LjoYqseZJ2br6
         5rvcxKMk/pf4lXmB74OjapYxv7FRv/0cz7lZ2ffulJagA6Y5xo6Xpsl1ofroks+HbtN4
         IBlA==
X-Received: by 10.194.89.234 with SMTP id br10mr17537218wjb.43.1367655411925;
 Sat, 04 May 2013 01:16:51 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Sat, 4 May 2013 01:16:51 -0700 (PDT)
In-Reply-To: <CAJDDKr7JxmfCDSdPCFhK87g8AuuBexLn-v6SkQh6k0uAbH7j0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223360>

On Sat, May 4, 2013 at 1:10 AM, David Aguilar <davvid@gmail.com> wrote:
> On Thu, May 2, 2013 at 10:09 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Felipe Contreras wrote:
>>> We probably should fix those, but that is orthogonal to the '@' shortcut.
>>>
>>> We can have the '@' shortcut *today*, with minimal changes to the code
>>> and the documentation, in a limited and understood scope, with no
>>> surprises.
>>>
>>> We can fix the symbolic ref stuff slowly, step by step, no need to
>>> delay the '@' shortcut for that.
>>
>> Agreed.
>
> If only we didn't care about windows then we could have this feature today:
>
>     cd .git
>     ln -s HEAD @
>
> ...and everything works, in the most natural way.
> Has anyone else tweaked their repo this way?
>
> Is an alternative implementation to change the template repo to ship
> with a symlink?
>
> For windows, perhaps we can use this new code behind an #ifdef?
>
> Anyways, it's just a crazy idea.  I very much like this feature,
> and in a tweaked repo @{0}{1} actually works.
>
> Is there no way to tweak this at some really low level to trick git
> into believing the link exists (even when it doesn't)?
>
> I guess that's what these patches do, but the limitations seem unfortunate.

Nevermind.  @{0}{1} is nothing special and symbolic-ref happily
replaces symlinks with a file, so new code is needed regardless.  I'll
start testing these patches instead.
--
David
