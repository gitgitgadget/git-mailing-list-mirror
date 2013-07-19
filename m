From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Fri, 19 Jul 2013 18:30:16 -0400
Message-ID: <CAPig+cT83Zv5aDDTYhfLOQ-ymCckwHDhxE6ChHUQKWQbfPdG6A@mail.gmail.com>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan>
	<871u6v93a8.fsf@igel.home>
	<7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
	<7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
	<CAPig+cTXn4hdKoCjnNXmybNxYt0Bt_QuxsfFxiA5b0J1FxUUmQ@mail.gmail.com>
	<7vy592wmcs.fsf@alter.siamese.dyndns.org>
	<CAPig+cQEtKc+tfDgqVWYL2JtxXc=wvS=P7_O=XJzizz1BN=n4A@mail.gmail.com>
	<7vzjtitco6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 00:30:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0JBv-0003A3-0I
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 00:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067Ab3GSWaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 18:30:19 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:63544 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab3GSWaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 18:30:18 -0400
Received: by mail-la0-f42.google.com with SMTP id eh20so1506619lab.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=K2hHReoOvc46SeAkiO+Q1SEZzp3IH4HGv//4FUzbsOY=;
        b=TyhjDZDWPsKMv25QYXEFCLF0C+mJio5wzXZiV2FG7MQYX1E6wBtpuDbLIGtWvV7xk3
         ZyJMUfb7g9035XLr6WyRVdmkYYJ+OMaxxnlPIhtUFBVyPp13BgMwotDj3atsdwqY9jpo
         oo2wY4+N3zhqWqONEXFA60UJhfXMdSqTL/zCZuevyCEfn25faSKuI9k2KsLsk7ymLqM1
         wSEsP2hwjS5iHpO9+av9iSAVBFxYfk/OydsxXkbPZUy3ZeVIjvr4+8IoP/a4Y4N599hW
         dg0lAPl2ozbmnSg19IIRetT1Xbuc74Zu+cwCtbWitD3ChTh8AAShN0YrLXJRTiQXQ8bA
         VsAQ==
X-Received: by 10.152.43.82 with SMTP id u18mr8068168lal.86.1374273016651;
 Fri, 19 Jul 2013 15:30:16 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Fri, 19 Jul 2013 15:30:16 -0700 (PDT)
In-Reply-To: <7vzjtitco6.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: r2kpLnr3DyLGi-p7RQkKRl2vZwI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230854>

On Fri, Jul 19, 2013 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Dropping the parenthetical comment might improve flow slightly:
>>
>>     Without repository or branch on the command line, `git pull`
>>     needs to be told how to integrate the changes with your history,
>>     via either `--merge` or `--rebase`.
>>
>> With or without mention of the configuration options, either phrasing
>> seems pretty easy to digest.
>
> Yeah, that reads much better, but I do prefer to see something that
> explains this is often "just make sure you use the one that suits
> your project and always use that".  How about something like this?
>
>     With no repository or branch on the command line, `git pull` needs
>     to be told how to integrate the changes with your history.
>
>     This can be done via either `--merge` or `--rebase` option, but most
>     people would want to decide which method matches the workflow of the
>     project once, and set the configuration variable `pull.rebase` or
>     `branch.<name>.rebase` to stick to it; see linkgit:git-config[1].

At this point, I'm probably just bike-shedding. Perhaps?

    With no repository or branch on the command line, `git pull`
    needs to be told how to integrate the changes with your history,
    via either `--merge` or `--rebase`.

    To match a project's workflow and make the choice of merge or
    rebase permanent, set configuration variable `pull.rebase` or
    `branch.<name>.rebase` (see linkgit:git-config[1]).
