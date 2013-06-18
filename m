From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Tue, 18 Jun 2013 13:17:09 +0530
Message-ID: <CALkWK0mOsSskGE2ukS4M8QN_Nuf7+rVosWG6E81QXgoQO8Zz-Q@mail.gmail.com>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com> <vpqvc5dj3hy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 09:47:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoqdt-00059d-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 09:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab3FRHru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 03:47:50 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:41431 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab3FRHrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 03:47:49 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so9156589iea.39
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NqtyNLeJi2y6uuYnTQPw67fqfx5l+txBDbe51negsoA=;
        b=BUQ3j7Py95SDZ10B/59PkPb7oM0qNtX/F0ABvsPH8Bv+6adT5SswuqfWpbic0KwINC
         k5MgXDvYrLASVf2hHrOtj2Wvd8tvNTkF9U+6xrJYnoJFY927YiQMp1jt/DDhsdRmR9zY
         +NDNInfxymICBt0C0IF8/Sw08DBUxnlB58pP7OkjAzZ84Ic4xWJ1c0JwSTt3a6tgAPDU
         9NnfpY5VplQyUX/uIP0JAQKI5NE7pg8GPKVoaKCQmpWebDCUWD3/fxB2r9W9kBBAf1l9
         qFHZEbG+6nvirp2otr+/PHX4qZ7ix1c7J6orOTPGL/x5+iTaBq6ctEXpYMfVcINdgLvL
         AQ/Q==
X-Received: by 10.50.23.8 with SMTP id i8mr6963365igf.42.1371541669471; Tue,
 18 Jun 2013 00:47:49 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 00:47:09 -0700 (PDT)
In-Reply-To: <vpqvc5dj3hy.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228170>

Matthieu Moy wrote:
> I'd put it the other way around: the intuitive explanation first, and
> the technical one after. For people not totally familiar with Git, the
> first part does not make much sense (and when I learn a new tool, I
> really don't like when the doc assumes I already know too much about
> it).

Good.

> Also, this $HEAD Vs HEAD doesn't seem very clear to me. I don't have a
> really good proposal for a better wording, but maybe replacing $HEAD
> with $branch would make a bit more sense, as having $HEAD != HEAD is
> weird.

Good.

>> +* `simple` - in central workflows, behaves like `upstream`, except
>> +  that it errors out unless branch.$HEAD.merge is equal to $HEAD.
>
> "... except that it errors out if branch.$HEAD.merge is not equal to
> $HEAD." ?

Good.

>> +  single command.  Dangerous, and inappropriate unless you are the
>> +  only person updating your push destination.
>
> Here also, I'd have said "Dangerous, and inappropriate if you are
> not ...".

I might have overplayed the danger a bit, as Junio points out.  I'll
have a look at your --force documentation patch.
