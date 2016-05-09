From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 13:57:35 -0400
Message-ID: <CAPig+cQS32O0jxJkWRB2r5vQw3LHVeD_vK+3O9Q3ominO38S2g@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:57:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpRC-0001nA-2I
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbcEIR5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:57:37 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36249 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbcEIR5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:57:36 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so19324309iof.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=T1HoLiF5Pyz0EsNPx/RaEOkiS2sASPhf/GvYcbkDCnI=;
        b=fDvUCnd9f2qy7vUQM5Ts9fwbUglpv7uvIIjgkwOg4TUf+ZP5OGV+2ligkyM/Kqxuml
         24UB49FXNyMxz+/aucXEE7THap8mYu/9KIvU55AjRhSn739P8PRWfzJLIMJoYHE3TPuT
         8g/d/8j5lVLrCIInj+hayKDSZq6FwH0b33uLXMtovoV9s1CxhlmvJrT+fFr8V6JBIdr+
         Ja5X10OeMZUL2y365fuTL4n+v+JMo1byB4Q1Rkuii2M0Mm2T182IxkcS9Zt6ZeuLLrHH
         qfT62fyIqf4QMQ5+DBhHV5N/O40kpMswn31tUW9YtBhpMbu2aU5UFxDV6kjHI/Jv4q95
         ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=T1HoLiF5Pyz0EsNPx/RaEOkiS2sASPhf/GvYcbkDCnI=;
        b=CrjLEr8ekte17dmgV/x1akit+e6zbpPnj7oBIRsaT0s9Ljx+0VWnCXmOk1cc4Cs6r6
         1Kxpy1HmGei24wcBwu32vfClws4xmQKCzM8Z5cH6QFo4bM7w57hOfcymPlKURvxgnh0E
         /NxnBusNbPUty2hTLSH4v93DsEBvbcuMqqPEU8fjBqnwEhzOCoyRZxQvbWCx7A+4aZm5
         9FWYak9g+r6/1uu+K48s123bYj9fCKIDW9vHZ/S+0jhafB1/9t8DWOOvchKKt+bzn8lr
         ZAhvapXwoxu9wEtKUBil6FN/ltTtsD6CN2leQvFvI7sqKQYYZeaxJBSc/8bZaLs6mygA
         GkVQ==
X-Gm-Message-State: AOPr4FXQnfk5gY6jEkbqBx3YVbUphP4pykyzyQuH0cqyOd0g4btoJsHutBHyiiJlI4wQr1jNSP0CR5849QtUeQ==
X-Received: by 10.36.55.81 with SMTP id r78mr347965itr.73.1462816655682; Mon,
 09 May 2016 10:57:35 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 10:57:35 -0700 (PDT)
In-Reply-To: <CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
X-Google-Sender-Auth: kJm90wsBq33qbddY7pIDJztpKlU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294032>

[please don't top-post on this list]

On Mon, May 9, 2016 at 12:35 PM, Armin Kunaschik
<megabreit@googlemail.com> wrote:
> Sorry, this was my first patch to the list. I'll do better :-)
> You are right about the "wc -l" parts. Maybe I was a bit over
> pessimistic. Throw away my last mail.

Done :-)

> In my case test 9 ran unsuccessful because of an empty "git ls-files -u"

Okay, that makes perfect sense and does indeed deserve to be fixed.

> This reduces the diff to this one (hopefully the right way now):

Perhaps you can turn this into a proper patch acceptable for inclusion
in the project. If you're interested in attempting this, take a look
at Documentation/Submitting.

> *** ./t4151-am-abort.sh.orig    Fri Apr 29 23:37:00 2016
> --- ./t4151-am-abort.sh Mon May  9 18:28:18 2016
> ***************
> *** 82,88 ****
>         test 4 = "$(cat otherfile-4)" &&
>         git am --abort &&
>         test_cmp_rev initial HEAD &&
> !       test -z $(git ls-files -u) &&
>         test_path_is_missing otherfile-4
>   '
>
> --- 82,88 ----
>         test 4 = "$(cat otherfile-4)" &&
>         git am --abort &&
>         test_cmp_rev initial HEAD &&
> !       test -z "$(git ls-files -u)" &&
>         test_path_is_missing otherfile-4
>   '

This fix looks fine. Thanks.
