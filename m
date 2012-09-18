From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 4/4] rebase -i: Add tests for "--edit-todo"
Date: Mon, 17 Sep 2012 22:37:02 -0700
Message-ID: <CANiSa6jJTu8QmWTybN77-nMZezCVkcod-+wmEf-T7=nN-H1p=Q@mail.gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com>
	<1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com>
	<1347931690-20625-5-git-send-email-andrew.kw.w@gmail.com>
	<CANiSa6jcBWbeydMViruM1UYanhHiEugfHa5DepjGNdizq2otbA@mail.gmail.com>
	<5058053C.6080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 07:37:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDqUn-0006Bx-7b
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 07:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab2IRFhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 01:37:05 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33491 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab2IRFhD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 01:37:03 -0400
Received: by ieak13 with SMTP id k13so1722202iea.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CK3dYPVZydU1ITEo6NOV7qE08X9U5VFFqhtPvp10Uos=;
        b=Rlrybz6XRWCVzQG/7gqEmCxwLJeuiTi0w08y8kueTWt7nNeCcmsdz4kXxSiJK9vGB7
         IegfCjkD2Jzw82bgqN57EFaI058alyT8wc9id7nNcUaiyKyvVlLLw4aVC22Lo1Rc1QWf
         XFl9nrSbLZhur08xiggA6aX9OsQFcu+ZAeZi3e8YP3AjGaYXrNwzxbXJ9vNjFQhR0LLt
         Hy6TPXq+CctCpeDIdrXZlt8/KHyauj4Ul+F1KUJfkhhqQpXdU8bLecLXSJuADCcbFxBL
         L6ShgoerTuEx0hDDGyCkNeGgz8KJMcvPLoFX91Jc5f3/rh9LirfN937Fri1bWV1/+ZnN
         sP6g==
Received: by 10.50.0.193 with SMTP id 1mr7232382igg.0.1347946622874; Mon, 17
 Sep 2012 22:37:02 -0700 (PDT)
Received: by 10.64.36.138 with HTTP; Mon, 17 Sep 2012 22:37:02 -0700 (PDT)
In-Reply-To: <5058053C.6080206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205791>

On Mon, Sep 17, 2012 at 10:23 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
> On 09/18/12 00:58, Martin von Zweigbergk wrote:
>> On Mon, Sep 17, 2012 at 6:28 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>>> +       test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
>>> +       test L = $(git cat-file commit HEAD | sed -ne \$p)
>> I couldn't find "$" (match last line) in the POSIX man page for sed.
>> Besides, I think $(git show -s --format=%s HEAD) reads better.
> It's under "Addresses in sed":
>         ... a '$' character that addresses the last line of input ...

Ah, I just didn't look hard enough; sorry. Good to know.

FWIW, Acked-by: Martin von Zweigbergk <martinvonz@gmail.com>
