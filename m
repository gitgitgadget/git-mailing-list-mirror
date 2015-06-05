From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate "index" as "Index"
Date: Fri, 5 Jun 2015 21:20:34 +0200
Message-ID: <CAN0XMOJ8AWzOgOsAqU61DbWTUBfC8Qc57AnVxtNjHeEOkpvOLg@mail.gmail.com>
References: <1432925644-26231-1-git-send-email-ralf.thielow@gmail.com>
	<556C0BFD.3060806@drmicha.warpmail.net>
	<3813728.oJDPxEPYet@cs-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:20:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0xAX-0005b2-8v
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbFETUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:20:37 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35101 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbFETUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:20:36 -0400
Received: by wiga1 with SMTP id a1so30438867wig.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0hJRbuhKOAhV+pnh/z3ikYHWz+MqOzLZ8XLFpjKCetM=;
        b=RfBB/Ze6G2T/OnppAQsUWLLJ/V32kXKaj7AKM0di2uj7r9a3S7CYBiMFVRGwhd07XS
         QbWo5xpDP6tPZEoM5PUgSj6IASwMOreS8Sr64tcpP5eAl8txjUy1yolCHAh8QwstLJWO
         HNBJudjfCzPyAn38iqI1TgLpTXUB6PrkEtl2ZfYzVtlGEMKAo90q+mEhf+phEgP/leCv
         FvunQk+yUwg9eTDRH4kodZZbLEDZvW3GTjADaFb1pIz7V6so6NN71uSai4/NwtvdPTbl
         JrQ72bqgyBJjDy5xibWkx+D8zBEezZIWVebeDLoxhsYeqkWiK8Henzh3og4InRJZ5GRt
         3ITw==
X-Received: by 10.180.102.74 with SMTP id fm10mr65312227wib.25.1433532034748;
 Fri, 05 Jun 2015 12:20:34 -0700 (PDT)
Received: by 10.194.152.197 with HTTP; Fri, 5 Jun 2015 12:20:34 -0700 (PDT)
In-Reply-To: <3813728.oJDPxEPYet@cs-pc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270874>

Christian Stimming <stimming@tuhh.de> wrote:
> Am Montag, 1. Juni 2015, 09:38:37 schrieb git@drmicha.warpmail.net:
>> Ralf Thielow venit, vidit, dixit 29.05.2015 20:54:
>> > The term "index" is translated as "Staging-Area" to
>> > not confuse beginners who don't know about Git's index.
>> >
>> > Since the term "staging area" doesn't appear in original
>> > Git messages (not even in the glossary) and "index" is a
>> > well known term for experienced users, we should treat
>> > "index" as a Git term and therefore don't translate it.
>>
>> Super! :)
>
> Sorry to contradict, but: No, not super.
>
> Again I question the whole point of such a denglish translation. Do you want
> to present the git wording to those experienced users who know git anyway?

A very good reason why we use denglish translation is that the majority of
German (e)books don't translate Git terms (at least the (e)books I know).
So why should we confuse users, who read books and stuff, with a translation
that translates every single Git term and therefore the user is confused and
can't find it in books, nor in articles on the internet.

Having said that, I think we should translate as "staging area" if the message
is about content in the index. I'll send a new version of the patch.

Ralf
