From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Why not git reset --hard <path>?
Date: Mon, 28 Sep 2015 13:53:45 -0700
Message-ID: <CA+P7+xoTHFL_KU+qBz1KwytxqNTxf1JkjXK7_Ej79uLLnCWD8g@mail.gmail.com>
References: <20150928203449.29024.qmail@ns.horizon.com> <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: George Spelvin <linux@horizon.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 22:54:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgfRA-0002l2-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 22:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbbI1UyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 16:54:06 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35520 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbI1UyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 16:54:05 -0400
Received: by igbkq10 with SMTP id kq10so62594710igb.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=udVJnwWLul2oWVtvRDYh4CrSPNuTXPX0X8iLDRFiDBE=;
        b=nzI8PP9w6thimRfg0BbFX/t0VqB8s3AiRt3RZGYTkMKzQwISmZarukuPGSye8mq2li
         pbIstHC9KjKOrXwooYXBEsDTcDXlV1mvf9ooqw+5noapjV8l7j+vLDq0piJ+yLxyiobt
         bWmIqEhIgYxc7yInmWmGDpEgjeIff7DqPkiTwXeq9uj5XoTXG4reKVopoB6qhddYr6qw
         oCiwlqpSOJTH2eE80x/JqsdKNa/HWYnLOgmooVjHUmy8B1qSR3JYUL7bT6GfFgR5RFWW
         xhz8nLnGbb94GXYTwZAleigMBoKlNj2q3Dew9v9NAsgIyyVdBig/lWqgvH2njLdttdt8
         y5bw==
X-Received: by 10.50.178.145 with SMTP id cy17mr19445322igc.92.1443473644769;
 Mon, 28 Sep 2015 13:54:04 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 28 Sep 2015 13:53:45 -0700 (PDT)
In-Reply-To: <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278752>

On Mon, Sep 28, 2015 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "George Spelvin" <linux@horizon.com> writes:
>> I understand that "git reset --soft" makes no sense with a path, but
>> why not --hard?
>
> I do not think there is anything fundamentally wrong for wishing for
> "reset --hard <pathspec>".  It probably is just that nobody needed
> it, because "git checkout HEAD <pathspec>" is a 99% acceptable
> substitute for it (the only case where it makes a difference is when
> you added a path to the index that did not exist in HEAD).
>

Personally, I would like to see this simply given the number of times
that I use git reset --hard <path> and then realize I should have used
git checkout instead. I conceptually think reset --hard should do
that, and that checkout is really not meant to do that as a concept.

I may have some time to try and give this a look in the next few days...

Regards,
Jake
