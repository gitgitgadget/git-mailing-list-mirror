From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 10:05:55 -0700
Message-ID: <CAGZ79kZ=de7jh7b2OnTuEoTUSJKhoNkjb+Mw41JP7w9SVWH3iA@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ684W46df9zPQATr3zWKt+e1BhGY6DZ84psfXWH4tGNw@mail.gmail.com>
	<xmqqlh564hm3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVBQ-0005kC-LY
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbcCYRF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:05:57 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34833 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbcCYRF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:05:56 -0400
Received: by mail-ig0-f177.google.com with SMTP id cl4so15825037igb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=XacAkbrrz2ajEcIK9bieDejnwByW5snAzrg9XI9pyo0=;
        b=dUJe+C/dJRR4E8hd9zIqPX9a/t3l4hOs9kC+HDsXEWplMaYG6CYHTyac8MmiDqMAE4
         0e2zdulU1Gb8Rb3Dkj0clwQXztutmG6rZBIgqqHasA3Jka7i6LbfLY7eCZueXboCog58
         Uwfi4qTOyIpALyw3tgcqxXsTd9f3jI5Z6ZmreqZZapwJKUvUl7usRUheI8uRam5/ZylV
         QPu8FudtYeTjSZGBXOgb6jKBC5Fky1TwvIL5y8q/ovpDZi4dYbo6iV9L2k95Xwst8Mws
         fF58Q5I1GpX6kbuQAzhgbejgTRlT8ROBt8+wsgKs/+Wf8DBxUNHFVxliJeUlMvJTTv8e
         Iv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=XacAkbrrz2ajEcIK9bieDejnwByW5snAzrg9XI9pyo0=;
        b=XsfW6byFR0OJhSAVnqHRHitKBrzC1MsYG7MfVGd6o/VjxVQABMM1eV8GsdIM84Swgy
         4Somjm/mesGtN0WoXSVY5HL6ofcaj4ZHDogkcleBlNU+QWp4MyYzy1LDpC5a3iDS1DWT
         wbUxq1hhGQqeRDfs5B7PLwUbdk12AQ8TNVqOuV5EQNxBk7CviRHhjM69CMmG51mXxzVJ
         qdDj9FUnV8qpZ3uJBDdusGYSuZUvaVUcJCQftUZ2mlO3W0yl+N5+aFBCFnIa+je18nmJ
         E05fGAgITvW/9q/whqraRhQ22ntwVOJ3VXtKxFBVfxF/Y8gHjBARWlYmm5xxbhxPYHT6
         1P2A==
X-Gm-Message-State: AD7BkJIuRvH3bEiG06jFnEbgvY3l/ygCRU/o0FVVpmNLmihaNCs0WS6vGpt98zays6DOzmt7os6QnR7gk2QO4LBP
X-Received: by 10.50.13.36 with SMTP id e4mr2673823igc.85.1458925555420; Fri,
 25 Mar 2016 10:05:55 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 10:05:55 -0700 (PDT)
In-Reply-To: <xmqqlh564hm3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289909>

On Fri, Mar 25, 2016 at 10:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The other reason you gave below is also convincing: By having it in the prefix,
>> the C code is more likely correct and future proof.
>>
>> On rewriting the whole submodule command in C (probably
>> reiterating): It is not my endgoal to rewrite every submodule
>> related part in C. It would be nice if it would happen eventually,
>> but for now I only rewrite parts that I need in C.
>
> Well, what you personally would want to do yourself is irrelevant.
> Doing submodule--helper in such a way that it is sufficient in a
> half-way conversion but cannot be reused in future full rewrite is
> something we would want to avoid, whether you would be doing the
> full rewrite in the future.  In fact, if you are not inclined to do
> so yourself, that is one more reason to make sure that the C pieces
> in submodule--helper are reusable (i.e. your "correct and future
> proof" above); otherwise you'd be making it _more_ difficult for
> other people who would want to pick it up where you left.

Exactly, sorry for not writing my chain of thoughts down completely.

To make them reusable, I'd assume we want them to be easy to
understand, and by using a well known way in git it is easier to
understand.
