From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 12:12:58 -0700
Message-ID: <CAGZ79kbLcRgM5PoTp7DA-c5DneAWJOxNwZVSMxU0LdVtuBfiRA@mail.gmail.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	<xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
	<xmqq8tz93kf9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaV+hQRn6ZraZcG9ZRp1XwPGrEFibBEX5qFJdWDCg0uxQ@mail.gmail.com>
	<xmqqzirp253d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 21:13:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Nwv-0006qJ-VT
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 21:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbcEPTNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 15:13:01 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35254 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbcEPTNA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 15:13:00 -0400
Received: by mail-io0-f169.google.com with SMTP id d62so222196041iof.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7tTVy0cfsXyomB6j1izxTA0s3peeZcBRLSoSSulYs1Q=;
        b=QSNNUi2ZCJi/Ci/iUIYXX9gBH4gFsyjGUBF8mXWMfar+k0bUCmPYtYNGBSO0SHNxoa
         bsCBzCVXb+4ps9seLX81LdUyornc/icCg9m7qjQr56d3JK4tNvtTWE3/jLCDqahrU5O2
         sbPk2UKLHfP6jOwTb60lRqJ+EPR/RZtjsrA20jt9x6iGfaJMl93d2eWDuR2vZDmRdS+A
         9NA1Eedh9k2Y6gdECD8pXQ2HGuj7SWojc3ETbN+6ydf+mb8QXt0uAf8q5Vz+b3c7gte8
         ahFWVzUnfqzo9otaAFN/aUkLrJn/XAdsuV1f+MVSmnoRiLCLqSHYnxt5lLqn+ybGepCN
         UhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7tTVy0cfsXyomB6j1izxTA0s3peeZcBRLSoSSulYs1Q=;
        b=f79fjDT2hqf1Ne3KbSv9fZZKjn4vDzcQIrdWwq8SCXyNBQvCXxbGzGFyTcFcvonqe1
         gRBA4eU3RsA+dlDz5IQjy0JP6yUENONPD5Op9TI1hEdEaXAnFPp/IHrrECDXnrfdeo97
         7Xx02NlCu+/L23fIreYtNGF3e299cZRZKy104/JEBwU26R4/ifraSg2+PRcj+NDUL701
         vNsw5hX2i/RtV/tikT/m31N5aRPsYKFlzf1q9z3irmLaaabOMW9aaRYHG5LCeMi9+XNw
         BKdeXBCmIjOhpz08+V/fg+UH/BkNuknR6lKNQtzFZ5TPmLegJH5mrfznU7CVKFIhLI61
         u68w==
X-Gm-Message-State: AOPr4FXWChxJy5Nsq8xHp3dv4Qb2krqIysQcCVt/rRAOfRgsf8nXybkg/RbyB7VGYDrn8TRvxxBGLNuibSarG7nu
X-Received: by 10.36.14.71 with SMTP id 68mr10112076ite.98.1463425979086; Mon,
 16 May 2016 12:12:59 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 12:12:58 -0700 (PDT)
In-Reply-To: <xmqqzirp253d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294780>

On Mon, May 16, 2016 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> "... but for now Git treats it as if it is not set at all" is a valuable
>> information to the user, still?
>
> Not at all.  "What you are using is wrong and there is no guarantee
> what behaviour you would get" is the message we need to convey.

    "Path '%s': Ignoring label set to false; This may behave
differently in future versions of Git."

Maybe even with s/may/will/

I think that conveys both the message about the future as well as
"what happened just now in that command"
