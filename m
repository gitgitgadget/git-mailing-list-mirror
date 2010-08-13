From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 19:47:11 -0600
Message-ID: <AANLkTi=hJMCVP4sfSr6Ru82aXVoj6OcLxKaj-cV_1GJ1@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
	<1281592569-740-3-git-send-email-newren@gmail.com>
	<AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
	<AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com>
	<7vhbizpirg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 03:47:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjjMd-0003sB-4b
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 03:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab0HMBrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 21:47:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44768 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0HMBrN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 21:47:13 -0400
Received: by fxm13 with SMTP id 13so1185150fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lT7n6pcNOd7M4YuPiBZgRD8KRJfQtuVk/liUgj2jLi0=;
        b=K6IyIE8T4xWA+faZ16XTb8kYSCJNxBVqO4wB8b7b5bIynWCxY9JNrOINhrLnI18YRt
         rpXNACqRqKkb5Ko5wre7LCe9uf/tW8CThhT4A4BJ5vz2R5rgfMdfDb9+Pi1qoYc0MSMY
         hHIzyja4aWO+3k2H4tQSy8NqbUrw1oBqJK9CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bvfF6eyjGIc78sX5bEameZwlocJyk0LxkMFITCl1OvUxuukylTHQ6WrmhsGoELz79W
         Z1WZId49Lk/rnhLTtrCi2FBZlw6qLfzUdOQ+b7yZl41OiLw6BRjikGOPdv7NwB8ATeoZ
         7/UYs8p+eO5kek0LrLXRdtCxun6NhSrYCzhf8=
Received: by 10.223.104.15 with SMTP id m15mr1041079fao.103.1281664031355;
 Thu, 12 Aug 2010 18:47:11 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Thu, 12 Aug 2010 18:47:11 -0700 (PDT)
In-Reply-To: <7vhbizpirg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153455>

On Thu, Aug 12, 2010 at 4:29 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>
>>> Can you refer to commits with something like this?
>>>
>>> c85c792 (pull --rebase: be cleverer with rebased upstream branches,=
 2008-01-26)
>>
>> Sure, I'll start doing that.
>>
>>> You've moved all the lines after the call to "git fetch". It change=
s
>>> the behavior when the reflog is not enabled, as the old value of
>>> remoteref is lost.
>>
>> Doh. =C2=A0That's what I get for trying to 'clean up' some code and =
put all
>> the references to setting oldremoteref together. =C2=A0I should have=
 stuck
>> with my original 7-line addition patch. =C2=A0I'll resend the simpli=
fied
>> patch.
>
> Then I'll wait for the re-roll of 2/2 with updated message and
> corrected code; thanks.

Ok, sent.
