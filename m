From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 08:53:14 +0800
Message-ID: <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <7vzl4frl7i.fsf@alter.siamese.dyndns.org>
	 <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
	 <20100116090321.6117@nanako3.lavabit.com>
	 <7vk4virjzh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:53:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwul-0003CL-6R
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361Ab0APAxQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 19:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758296Ab0APAxP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:53:15 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:35663 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758169Ab0APAxP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 19:53:15 -0500
Received: by iwn35 with SMTP id 35so940283iwn.4
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 16:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TIs3x1KVR2BhotJxa5IkHfJ0IQv1nrL0RdsHtwfC9WA=;
        b=RUtGsTWE1Y17z5dLkJPFEvKgxFYQSJK5lKEFr2gOuZIgY9IcdvgHcmEaOovynM5WTC
         33L4wC1FpBHjQLAPNKDxUMUvdK/YWSUYBFyfM0aur+YzwDkt05hAa72VS0wvxMS8ijt3
         R/gpJe2Sr/YHak19HXaDq0j3jEYDLtadQp/sU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zm0NR+i1MaFdG+TzP7q7VX1Thom3/xIqBbVib39GptDAAdGicaONpFuQ9NCy6YH3lX
         6B1B3Z8fzoMGT2qHwZJbmgR3ydz+qLLj1JnucklENfuTBmmUy3VkVeemE+Lzcm1BLvyp
         2dBZNJA58QSSJ5VzUIfhHyM5g0kZzzxH7u7+8=
Received: by 10.231.125.13 with SMTP id w13mr466019ibr.32.1263603194121; Fri, 
	15 Jan 2010 16:53:14 -0800 (PST)
In-Reply-To: <7vk4virjzh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137176>

Hi,

On Sat, Jan 16, 2010 at 8:06 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Junio C Hamano <gitster@pobox.com>
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> =A0 =A0 =A0 =A0 # Ok let's do it for real.
>>>> =A0 =A0 =A0 =A0 git push =A0 =A0--track there this
>>>
>>> Ugh; s/--track/--set-upstream/, of course.
>>
>> How can I use this to say I want to use 'pull --rebase'?
>
> I dunno; "git push --set-upstream=3Drebase", perhaps?

how about --setup-merge and --setup-rebase?

After all, there's already the config called branch.autosetupmerge and
branch.autosetuprebase.

--=20
Cheers,
Ray Chuan
