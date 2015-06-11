From: Gabriel <gabrielperren@gmail.com>
Subject: Re: Minor issue: bad Spanish translation
Date: Thu, 11 Jun 2015 12:56:44 -0300
Message-ID: <1434038204.30669.0@smtp.gmail.com>
References: <xmqqsi9yfdrq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34qe-0006Mo-UQ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbbFKP4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2015 11:56:52 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33636 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476AbbFKP4v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 11:56:51 -0400
Received: by qkhg32 with SMTP id g32so4955337qkh.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dZJoQfjeUqJLJA82fZag2ENvbzdxX17C0twvXdWIXUU=;
        b=mk1EIBjpbPmRYGVVCGfqOxcSQQAKGl0B4fjqshIWGg2TVpPfgbRMdeUNgokRLjzGMK
         iKep8rKKibwGAWsucc+HfEGWS/TvcCtLnLdBTotARW6I4bBGbypOEH20+svka/SP6l8K
         h0XePkYC7GqXdHZ5AAVckt/mQqJ+cXy35N/1va0Uq76LkqyjS22wgR+Jeg0Nwv7Fjb6B
         FLz15/CHc9N+dYlQ4wztlJTkMHoqk68wP659sH+niGd52+PHlEEGvTJZGvV+7qXmS2HA
         Tk3zbQYjq+3eUgAc/nfHzg7ezrqPBqL8RZDfiPz0WjtXcJYmQQHLJ/g2y/0KQsph2E7r
         xI3Q==
X-Received: by 10.55.33.40 with SMTP id h40mr20360099qkh.69.1434038210985;
        Thu, 11 Jun 2015 08:56:50 -0700 (PDT)
Received: from [192.168.1.100] ([181.170.86.23])
        by mx.google.com with ESMTPSA id e69sm412535qkh.19.2015.06.11.08.56.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 08:56:48 -0700 (PDT)
In-Reply-To: <xmqqsi9yfdrq.fsf@gitster.dls.corp.google.com>
X-Mailer: geary/0.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271422>

I think I've found where this issue is located:=20
https://translations.launchpad.net/ubuntu/quantal/+source/git/+pots/git=
/es/+filter?person=3Dfranciscomol

I'll try to fix it over there.

Cheers,
Gabriel

El jue, 11 de jun 2015 a las 12:47 , Junio C Hamano <gitster@pobox.com>=
=20
escribi=C3=B3:
> Gabriel <gabrielperren@gmail.com> writes:
>=20
>>  Hi Johannes,
>>=20
>>  I tried following your instructions but I can locate the sentence
>>  where the bad translation is. Please see here:
>> =20
>> http://stackoverflow.com/questions/30783818/find-instance-of-string-=
in-git-core-with-git-grep
>>=20
>>  Any advice?
>=20
> Perhaps you are seeing a bad translation in software that is not
> ours?  I do not think we have es.po for the Git itself.  gitk has
> one but I do not think it gives that message.
