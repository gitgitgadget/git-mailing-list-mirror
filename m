From: =?UTF-8?Q?Alex_Preng=C3=A8re?= <alexprengere@gmail.com>
Subject: Re: compactionHeuristic=true is not used by interactive staging
Date: Wed, 15 Jun 2016 08:24:47 +0200
Message-ID: <CAEtHF9Ne7a25cOF_6L=ZXRnmR4NbnUBDFR+6V-PryjtK8yNO8g@mail.gmail.com>
References: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
 <20160614214211.GB21560@sigill.intra.peff.net> <xmqq37of8mx4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 08:24:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD4Fx-0002Wy-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 08:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbcFOGYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 02:24:50 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37610 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbcFOGYt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 02:24:49 -0400
Received: by mail-wm0-f42.google.com with SMTP id a66so8036223wme.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C6blsaHD9+lYbDnJQ/n7tsifaRwHhheglsin7amT/qg=;
        b=eUflxYrKlGPrLpI8PSoY0OgWrb9I9vpXETmBtau8R2NjXrCJbU+RyCaUwjD2Gqeryq
         +KpBzjPk802YjkBwaBomK0YdbNw+7EVKUhJBkqz0a+Nx2cu7xvZ741kKy7PkB3Vw4/A8
         PGP5u1teOk/V13HMJpbGjLfdUkgLpFXi0wG3JgIOlr443EtwdSH15f/WbQ918/bEc7qv
         O1GEcCxPg+4lufdjVq1n200NOq08tZvDjwrivUDIEuYKVT8jauatoHSD110TPmmHtNzk
         lMi6ouXIgABm3N/d2+SX4vUeQo6nBrdYkO/SWUipkH+j0dChGjRTe+ynDLz/yPWfVVjf
         FJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C6blsaHD9+lYbDnJQ/n7tsifaRwHhheglsin7amT/qg=;
        b=JY73htmsEauECLLo6OJ7tXtFtgIcceNIOlnKk85pkqS9ifUR4qvlf+PfR7W1yMyV0t
         AJaB081/6bCFb128FeML/kw+9qusiTKB3fQE4Uu4XAHG6KJh6+4J7e+VAUKuXAylOe91
         Y3V4bG3cmhgMwblnq3YkDWccBbOFiREqPUGtQEHEJxG/UVsdpAWHZhwThNSAygj6L970
         RKNhQahDbcto8D0jryVZNzRdudoaByJIvsf1W80uhW+RU3kdFutcjIONc2GTOldTWyd2
         ui9W2v9At+VQ8IwNYpPNN+a9FCHewAhB4VFe7YlnAIzj7Q2scvzxk2zigWq3BIrwFI9U
         MNJw==
X-Gm-Message-State: ALyK8tIRnctRSAUIgpu/FUkwsn/VbB2dLSz+6ntCia/Og6+loJI16oFRqEmMTvKn8qv6pjMwEA6v35/IDIvshA==
X-Received: by 10.28.138.13 with SMTP id m13mr10121919wmd.3.1465971887864;
 Tue, 14 Jun 2016 23:24:47 -0700 (PDT)
Received: by 10.28.49.85 with HTTP; Tue, 14 Jun 2016 23:24:47 -0700 (PDT)
In-Reply-To: <xmqq37of8mx4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297356>

I see, it makes sense ;-) Indeed it would seem logical to have all
commands showing diffs (diff, add -p, log -p, reset -p, etc..) respect
the diff options.

Thanks for your quick answer!

2016-06-14 23:45 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>
>> Nobody noticed so far because originally the compaction heuristic was on
>> by default, and so just worked everywhere. But we backed off on that at
>> the last minute after finding a few cases where the diff looks worse.
>
> Yup, and that is why this is called "experimental" in the release
> notes ;-)
