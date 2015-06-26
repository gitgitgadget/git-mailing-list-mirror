From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 10:47:31 -0700
Message-ID: <xmqqd20iuzt8.fsf@gitster.dls.corp.google.com>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
	<CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
	<vpqmvzmwrng.fsf@anie.imag.fr>
	<CAP8UFD3y3gBp6bdLHus4TNo3LSwWLLOOWgzRR+6Yqh-rg4ASRg@mail.gmail.com>
	<558D68A7.6010608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:47:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Xj1-0006IQ-5b
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbFZRrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:47:35 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38663 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbbFZRrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:47:33 -0400
Received: by igrv9 with SMTP id v9so5819807igr.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lkeH7dG7+2OquUyaU4ZWWxmzDdKTIt0ENGaGQfW4iRo=;
        b=qCxq/LzkhKu/WOlGHpEDn0QOAXYJmFJk0RjPJiD89gNYfJcW3FZ5kkDx+nmLzvGtoU
         J4l9MBtY0IuNRak8TOlXs+AcyZUDeQlKzmx9beiGQ/DdWRMUY7eixxiEP+txl6u+2DD5
         pRWuaEmCVkddINfi0Dfy6H/l8iDf5aC5kqj3kgNMzShMHqWqf0KJOyvXRbxVNLlRoDXt
         tKrFxn/OXGmcK51IypMdQDwaZ0QsfxX1f7yqKhI1r6B5ifZ5ggcRFKFhdmJQ1zcsVokv
         nnrd6tdjtJwTrw57dHGINo44pYw+UhDWFcfiYcMuFi4tEex3yUVFWUzrx0Gc4CTdkhv6
         yoqA==
X-Received: by 10.42.81.6 with SMTP id x6mr4831007ick.89.1435340852975;
        Fri, 26 Jun 2015 10:47:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id l67sm13962743ioe.3.2015.06.26.10.47.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 10:47:32 -0700 (PDT)
In-Reply-To: <558D68A7.6010608@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 26 Jun 2015 16:58:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272805>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> Eventually there will be no more revisions left to bisect, and the
>>> command will print out a description of the first bad commit. The
>>> reference `refs/bisect/bad` created by bisect will point at that
>>> commit.
>
> I agree that is better.
>
>> For the last sentence I'd suggest:
>> 
>> The reference called `refs/bisect/bad` will point at that commit.
>
> Or maybe
>
> The reference `refs/bisect/bad` will be left pointing at that commit.

Sounds good.

I had a trouble with "will be no more reivsions left to bisect",
though.  "left to check" or "left to inspect" I would understand.
