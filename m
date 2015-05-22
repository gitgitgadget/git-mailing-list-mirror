From: Stefan Beller <sbeller@google.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule
 does not yield complete logs")
Date: Fri, 22 May 2015 13:44:37 -0700
Message-ID: <CAGZ79kZq=O3igxrSXRE+uFgP5fdzd_31cYpV8PeVFGbD5ee7jA@mail.gmail.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
	<xmqq8ucghf2s.fsf@gitster.dls.corp.google.com>
	<64326DCF30A041379141BB51437E87A6@PhilipOakley>
	<CAGZ79kaLqZCazM9MPR7wswMnVuvwO+Y0Pw9zPPXPEzAW6MQbEw@mail.gmail.com>
	<12d36f8293e517ceb5eaaf67d23056a4@www.dscho.org>
	<CAPc5daX-Kw=tJFAZWnJTQ0t8_mY-_qnP1n7s7Yv6fbHC1rd_FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Philip Oakley <philipoakley@iee.org>,
	Roberto Tyley <roberto.tyley@gmail.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 22:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvtoM-0005hK-Ov
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 22:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbbEVUom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 16:44:42 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34078 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945980AbbEVUoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 16:44:38 -0400
Received: by qgez61 with SMTP id z61so15803162qge.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GJmoDtcIqVFBcOGyflroqWhyPnsgjSs8j9PwK2+ednI=;
        b=OB7xI6lYB3YDo93sv/+1b5nyTmR1the9hIrKK9uITr/Fqt1u6TmH63VckCvgKTyWJt
         6cy2KbfVfp6xY7ZxjmV6ppRw9nf4loXVNCZy0ev8yg9z+WKFFcXalG1REvLr04VWt924
         MN4quKTuq6DdR4zvt/7++ELWriatWMeOTkwRFC3BG8jBTaDEXC/0O0i2auDdF4KXIa3L
         hVlY1ADKnI5WDWKVKlTs7sSPJ5/Roqm7nXsp25AajhPgXswERvw7SW+PKpjyhq6pwr8W
         9W0q8rfxuDwQfYpvCbjHrX41OGrSiOCSVGJTzvY45hUDcGzcc1sn/fNtGDfKPSdRULyc
         i/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GJmoDtcIqVFBcOGyflroqWhyPnsgjSs8j9PwK2+ednI=;
        b=E6hqMqYY80CbSw0ZKd58aaMyJ5BhQs0GJ3z1Xwsf5tbXIh/0GLUwlFK3Go8oSPbiYv
         LMJreRCY9lYPtKO9r1N3MGv4XEuF7t43WbX7I8vCGBqoNc3vcIg9gv9bC0UjP9GCgVNy
         b5XCSkkvLPbURvYVJo4PpIoH6/f6guS4qx4jTA2xjrM1XmsR72JIAKxPsDl1JOQn18DM
         qBw5mFEPqfVQRHnEsdrQa8BrcWZyh13AuTbZFneUi8U81t7NaU+UStwGfQ02QCGRai1G
         5hbHw4xuBJLoJvPi0Tamx7gLy8Pr0Ot1JAyf6wK4UTMv1l0p272fP+lNnR3ZNYNy5BV+
         822A==
X-Gm-Message-State: ALoCoQm4tGrjPOp4zws2NMtnYMNNI4nzrAUZiqp8i+imzk/PKqlbDh4nkSMLXCHgGijAsQp47t+z
X-Received: by 10.140.96.202 with SMTP id k68mr13355427qge.102.1432327477603;
 Fri, 22 May 2015 13:44:37 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 13:44:37 -0700 (PDT)
In-Reply-To: <CAPc5daX-Kw=tJFAZWnJTQ0t8_mY-_qnP1n7s7Yv6fbHC1rd_FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269761>

On Fri, May 22, 2015 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Fri, May 22, 2015 at 12:59 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-05-22 21:23, Stefan Beller wrote:
>>>
>>> So first of all:
>>> Where do I find the Amazon SES account for submitGit, to register
>>> my email with?
>>>
>>> Also can I change the email in the process or change it before?
>>
>> FWIW I did not have to register my email. All I needed to do was to give submitGit
>> permissions to read my personal email address and my public repositories.
>
> Hmph, I was asked way more than that (especially, read and write access).
> Does the site ask different authorizations depending on who you are?

I was also asked for read/write on my copy of git, but as I am not
the maintainer nor trusted in any way, I figured that's ok.
I still have my local copy which would notice any changes on git push.

The question I was asking was the only thing I could not answer
or decide for myself.
