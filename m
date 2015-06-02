From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC v2 2/2] git-am: add am.threeWay config variable
Date: Tue, 2 Jun 2015 10:01:08 -0400
Message-ID: <CAPig+cQZCekq+7UuO8t7+xxU0SR0t42zNn10gY1B5kVeeh7buQ@mail.gmail.com>
References: <1433251472-29460-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqvbf6jko8.fsf@anie.imag.fr>
	<87vbf6tdyu.fsf@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:01:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzmkj-0001xS-HE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbbFBOBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:01:11 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38572 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbbFBOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:01:09 -0400
Received: by igblz2 with SMTP id lz2so11072128igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gfOPHhQjXXMHB0inCxMfFU/ORr3ag49sirl2EIDcODw=;
        b=0KFyq41aJ9+Yvxs1iN+RTSe0baahUpmScz/LK8gYZsHPjJ1OlDOGLQ/OOrlwlZVgzG
         pEd2l+bzjfyGr+lKhSIudTr2m3D+W1t5XGYy+mI3GdPSeE7IIdvZDeM/wkAqvLDpmPVa
         5NEil0kxKJldu+F4YbPLdeAVrIxp/AaCI6R1f6ab/07Cxn3zlRueGcsf0mz5VjCu4SVN
         0POmrX6ArW0sbbJQsDIwROARaDI/87TiKttsFpYSTRXoDatwAqRHVd9C61v7JHJiHz8R
         wHNdu4mUAnVTtTG0u5Sr+ijub9b0vIBLzaLNDZFQRux3YWfImY+jjs1DVv4iOZmGBKZc
         9fOA==
X-Received: by 10.43.135.5 with SMTP id ie5mr35399362icc.78.1433253668743;
 Tue, 02 Jun 2015 07:01:08 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 07:01:08 -0700 (PDT)
In-Reply-To: <87vbf6tdyu.fsf@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: eAQYmphqVFBH90332hVa8p_Y2xM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270537>

On Tue, Jun 2, 2015 at 9:52 AM, Remi LESPINET
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>>
>> > +if test "$(git config --bool --get am.threeWay)" = true
>> > +then
>> > +    threeway=t
>> > +fi
>>
>> I think you missed Paul's remark on this:
>>
>> http://article.gmane.org/gmane.comp.version-control.git/270150
>>
>> Not terribly important since am will be rewritten soon, though.
>
> Oh right, sorry about that, I modify it and I resend the patch asap

In fact, it looks like all of Paul's remarks were missed. (The bit at
the bottom of his review is also important.)
