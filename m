From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Tue, 18 Sep 2012 23:14:07 +0100
Message-ID: <CAOkDyE_oMz9ZHuHTBH3_Q_75qvzqiNcfFnt6orcj1dJ5uDsWtA@mail.gmail.com>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
	<7vboh4tluo.fsf@alter.siamese.dyndns.org>
	<20120918213617.GB2567@atlantic.linksys.moosehall>
	<20120918215929.GA30346@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:14:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE63g-0006yV-03
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 00:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab2IRWOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 18:14:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59218 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab2IRWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 18:14:08 -0400
Received: by bkwj10 with SMTP id j10so185849bkw.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=8XIraa6BhKH3Q8Mi25UVaOcgCRROw427X2dUzX3bAkU=;
        b=BjNHknSpAMOt+dhmetM+5ic5vtRatPUPJcJi8c2gfbQrKWXvvOoRW6gsNT7Jm7m6d3
         o8AHd1zlfj8OGVnpYVPuB6fjhpCgAiMXAv6iQfw5jDmbGBE8TDYyKqh7KbSfEh2g6mXC
         pHmS/Fp7v8cTlSMcR4NhEL+QuClSqLyiuBB9H5INWdci4BliB+5NWZL7UV0j1EYyc55N
         GcDyPrR0rr316NrGM4dYTTkq8FEgg6lQ9XNF73p/kfzauB/4XiXhOBHnUHpzfYvBhlmN
         tcbplJGI9VO2IXHdKPFv/CHhzwsTJYcJHg99gJOx8LzyoTd/TTcgTJhrPKMm0IybkaZR
         Ifqg==
Received: by 10.204.152.207 with SMTP id h15mr693280bkw.5.1348006447239; Tue,
 18 Sep 2012 15:14:07 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Tue, 18 Sep 2012 15:14:07 -0700 (PDT)
In-Reply-To: <20120918215929.GA30346@sigill.intra.peff.net>
X-Google-Sender-Auth: mrEohxLzjskT9QUT1OxZS1E0V4o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205882>

On Tue, Sep 18, 2012 at 10:59 PM, Jeff King <peff@peff.net> wrote:
> TODO is a special token[1] respected by TAP harnesses like "prove". I'm
> not sure what practical impact it has, but it should probably remain.
>
> -Peff
>
> [1] http://testanything.org/wiki/index.php/TAP_specification#TODO_tests

Thanks, I didn't know that.  For reasons I just stated elsewhere in
this thread, I don't _completely_ agree with the specification where
it says:

    "Should a todo test point begin succeeding, the harness should
    report it as a bonus.  This indicates that whatever you were
    supposed to do has been done and you should promote this to a
    normal test point."

However those semantics are well-defined enough to warrant keeping the
"TODO" as you suggest.
