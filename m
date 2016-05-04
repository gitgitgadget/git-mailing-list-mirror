From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2016, #01; Tue, 3)
Date: Wed, 4 May 2016 12:04:12 +0200
Message-ID: <CACBZZX4maJDn7wF68f0wFkjeN0W0pVcfDrMNwqB78TD2cMOdeQ@mail.gmail.com>
References: <xmqqshxykb9k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 12:04:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axtfZ-0002Vw-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 12:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418AbcEDKEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 06:04:33 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33742 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182AbcEDKEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 06:04:32 -0400
Received: by mail-qk0-f176.google.com with SMTP id n63so21503685qkf.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tJXzoJ8XvesQsnpBBtgnd9XuQp0p7zDR6YNtPL2Ha5E=;
        b=wTAS3ngecgXqFQYdaB1Fld2+KS3eq6P46u9JJfi8pKKl61yt3M48poMN1N2XxgBXk3
         x9UgefPzAaTYhEU6b/xYUCn/kZlGFejvPNghozikoumkuaAM25dP9cmH0CbGeLUC8xYC
         zOcVHfpNA3mNtq2QcWP/s7uzUXvvbIQMwz4D2XUNOJVL4mcIjviFiPMM1O7cRZRFuVbG
         qhbCnlC5JxbgEaEzNZxaPPP/CL3tbDDI+8CjOJQysRU9yhuMfRg6tlrqnldqYn/icluA
         zMVRuOH0IneIPIYQEkJEPs3wRYBSAY7wHci1HGz/Wv/1m7yUWMPhcoLahH4TMhPsKBa5
         jlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tJXzoJ8XvesQsnpBBtgnd9XuQp0p7zDR6YNtPL2Ha5E=;
        b=A1Mfdg9nie4F+q+z9gvlN9z1KemRXfZZDkpnY8iJhQ6n7FSSoyWoKDSQ6vEJnTSgIL
         KY9mDZO8p6IDWjOrnaFkz6hYBid9EOI6gCXdIzUAguwv/JsJ5rQyR+O1SivqTbwNHOga
         NbJKsLECPuZnZ0fS65ppEvznj7XTBq+s2ukubH7xpdLxVdGTvUFYEUnS5iD722/u//eH
         4JzpRQnqnVq2quYLJCeoun3SSbv8dnf4fs40DwJMtcM/4LNCfvgPsatHpkVqj47IA/HR
         d9g0cbIl3Y8oZGDSRciXwgo0jVRm/9Bc1loVvp3lYc0B/7mQkvyVUzUndyfM/NXlJ1RI
         oMdQ==
X-Gm-Message-State: AOPr4FVjfDZBas25I30oziOZwm2lK/m+UYMdGIDfwm8k/nGpeea1T+fqY5TXuU3PCXmYm1XPkwX2GcjxsKBMrw==
X-Received: by 10.55.161.7 with SMTP id k7mr7724455qke.112.1462356271619; Wed,
 04 May 2016 03:04:31 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Wed, 4 May 2016 03:04:12 -0700 (PDT)
In-Reply-To: <xmqqshxykb9k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293529>

On Wed, May 4, 2016 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ab/hooks (2016-04-26) 4 commits
>  - hooks: allow customizing where the hook directory is
>  - githooks.txt: minor improvements to the grammar & phrasing
>  - githooks.txt: amend dangerous advice about 'update' hook ACL
>  - githooks.txt: improve the intro section
>
>  A new configuration variable core.hooksPath allows customizing
>  where the hook directory is.
>
>  Almost there.
>  ($gmane/292635)

I've been on vacation so I haven't sent a v5 yet, I'll be doing so
SOON in a series that'll address Junio's outstanding commets.

If anyone has any last minute comments that haven't been covered in
that now would be a good time.
