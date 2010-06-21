From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 0/3] teach git-checkout -B WAS builtin/checkout: DWIM with 
	-f -b
Date: Mon, 21 Jun 2010 18:30:27 -0300
Message-ID: <AANLkTimvSubp07W7ylRZVOrBTYtfsdkD6R5HRIiz080C@mail.gmail.com>
References: <7vpqzlrmo4.fsf@alter.siamese.dyndns.org> <1277140782-4064-1-git-send-email-rctay89@gmail.com> 
	<AANLkTikBFKdeuqQZOTRzxKE_6nR3bNDDsEtGIJVT0nhz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	Michel Lespinasse <walken@google.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 23:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQoZz-0007Fk-B5
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 23:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758606Ab0FUVau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jun 2010 17:30:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45250 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758322Ab0FUVat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jun 2010 17:30:49 -0400
Received: by gwaa12 with SMTP id a12so603571gwa.19
        for <git@vger.kernel.org>; Mon, 21 Jun 2010 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tF3447X6km4rekqZZ8IBJ/YqkzBZ6vbhczOWECHN2Qk=;
        b=yAt5Y7szZu89FLl+VbDc5UuFWes1RNYEICPqlKmNjs9A4WrEBhyclXdg0VBONLJQez
         pyD4vxakpzxGDb67AAZZUg9E92C5S4b4yMzI3e3GghSlimUEWiJVh7fU80dEmnft0jGm
         DCFQ8tEgaDvgKHtLJb+u7da4w+mYwiiCnIRtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OfroNoiP92uQ7trHT9UNVyWATvy1THMj90q/Icj3BrnK5oO8GIrDOqcEAEujC5eBQo
         ss5VVy/nvwyD8G6t8WC3ANy6QfUdFxojDRauJL7h5HmN8WJ/jUZ3ZiJwr5d+NpCbE9qh
         Mw953J3F/WGNIA93K1VS9JGnWsfqIU8gNQbi4=
Received: by 10.150.170.15 with SMTP id s15mr4948564ybe.229.1277155848320; 
	Mon, 21 Jun 2010 14:30:48 -0700 (PDT)
Received: by 10.150.178.7 with HTTP; Mon, 21 Jun 2010 14:30:27 -0700 (PDT)
In-Reply-To: <AANLkTikBFKdeuqQZOTRzxKE_6nR3bNDDsEtGIJVT0nhz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149441>

Hi,

2010/6/21 Tay Ray Chuan <rctay89@gmail.com>:
> On Tue, Jun 22, 2010 at 1:19 AM, Tay Ray Chuan <rctay89@gmail.com> wr=
ote:
>> Right now, the -f/--force in git-checkout doesn't carry over to -b
>> operations - ie. you can't do git checkout -b branch on an existing
>> branch.
>>
>> This patch allows you to do this with the -B option, so that one can=
 do
>>
>> =C2=A0git checkout -B branch ref
>>
>> which is equivalent to
>>
>> =C2=A0git branch -f branch ref && git checkout branch

If I need to do that, I would do: git checkout branch && git reset --ha=
rd ref.

Another way to do it is: git branch -D branch && git checkout -b branch=
 ref.

So, we have enough porcelain commands to do it.  I would recommend a
second thought to see if your refinement is really necessary.  I would
agree so if those procedures are needed very often.

> Erick, does this series change how --orphan should be used?

If you be careful It won't make any change.  I will comment that on
the series if needed.

Thanks very much for asking.

Kind regards
