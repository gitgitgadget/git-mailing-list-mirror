From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Tue, 11 Jun 2013 04:29:11 -0500
Message-ID: <CAMP44s2eUiZx6MaZ52Z0Ns40YapiEtzzZK6NJP8pNLiT5Z-pAg@mail.gmail.com>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CAMP44s3NhNUuCvW37UaMo9KbHHxZqBE8S15h845vtRi89Bu6WA@mail.gmail.com>
	<20130609174049.GA1039@sigill.intra.peff.net>
	<CAMP44s35w_ysvd5c8oANF8YpWvsquY50bUjSfjOxtujdpgBCPQ@mail.gmail.com>
	<20130611091807.GA11361@alap2.anarazel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andres Freund <andres@anarazel.de>
X-From: git-owner@vger.kernel.org Tue Jun 11 11:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmKtD-0005Qv-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 11:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab3FKJ3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 05:29:15 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:61525 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab3FKJ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 05:29:14 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so6633984lab.4
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BV9XS5/y5srAl2jORCP1PVTRjsJmInmt6gG0nKuPPHo=;
        b=lj0lpFblNHTFLtlliEAE53ubB3k/Q/oqsMmV0FVfshnxtCO1aiQyjPic2diJMqxMaR
         oVwBzzPuT6D7xgD/6pN+sonOChCo7PoeAHct0UhvSHYoLmamcdXzo/ONDAvDDTFcsjNT
         ZxLcZqXyGfrjXZ9O/3aNQAJPLgyKhESdImljh+1RaufceX4EJDJBzo84tK7/luKp8pmT
         xJZe06/3grBwBNEt0rmPtFg6FGYvsa85wzg6Bd0cZQE1l4a0bcTvR1j2wcrUSEziRW2M
         B4JBFwzAEeNINx7kYIb2ezyPxEI+NsY5XSDfDnl++kBT2Kg44PBTAQ0pMwERAbVulCQl
         McLQ==
X-Received: by 10.152.27.102 with SMTP id s6mr6988102lag.47.1370942951499;
 Tue, 11 Jun 2013 02:29:11 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 02:29:11 -0700 (PDT)
In-Reply-To: <20130611091807.GA11361@alap2.anarazel.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227426>

On Tue, Jun 11, 2013 at 4:18 AM, Andres Freund <andres@anarazel.de> wrote:
> On 2013-06-09 13:01:30 -0500, Felipe Contreras wrote:
>> >> You don't agree that 1) a collegial work environment is overrated, 2)
>> >> that the Linux kernel doesn't put an emphasis on being collegial, or
>> >> 3) that it's the most successful software project in history?
>> >
>> > Point 1.
>>
>> Good, so we agree that a project doesn't need a collegial work
>> environment to be extremely and amazingly successful. In fact, any
>> rational person would keep an open mind to the fact that perhaps it
>> actually _helps_ to not have such environment, based on the evidence.
>
> Just from skimming both lists, most of the time I find lkml to be nicer
> (and more collegial) to read because it has a better atmosphere than
> git@ had in the last year or two.

A better atmosphere, yes, because they know how to avoid flamewars,
and concentrate on technical issues, not because they have a collegial
work environment.

Unless you think this reply[1] is collegial. Even though I haven't
been following Linux mailing lists that closely lately, I still manage
to see a lot of these kinds of replies.

> And yes, a good atmosphere plays an important role. One of the reasons
> is that it makes it easier to discern arguments based on personality
> disputes - which certainly exist on lk - from actual technical
> disagreements that need to be resolved.

That's right, but that's not because everyone is collegial in LKML,
which they most certainly are not. Linus being one of many examples.

[1] http://article.gmane.org/gmane.linux.usb.general/85952

-- 
Felipe Contreras
