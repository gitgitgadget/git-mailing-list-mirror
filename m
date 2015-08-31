From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PUB]What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Mon, 31 Aug 2015 08:21:30 -0700
Message-ID: <xmqqmvx7xz45.fsf@gitster.mtv.corp.google.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
	<vpqzj17hpt8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 17:21:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWQtv-0004S2-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 17:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560AbbHaPVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 11:21:35 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35382 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbbHaPVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 11:21:33 -0400
Received: by pacdd16 with SMTP id dd16so142451142pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WQXjZGWR9rulA07rHTmN0HunpaqmkqWjsBl17J6xxPU=;
        b=D+Z+/TRNo7RLAFGiyMz4A2eAiUrmebXRXhgB2VLIUc5MbRCGXzhwBiRVvuaiQGOyin
         ftrVuBw6IezNj5xB/cfX8Bl0L8OZVPkyS9JxLBv2sWzSTXu22aB0Gi80YRuxKPsX7wjt
         hZFlXqjx678bhCB5cYFjnMjCdqgq2v1TpFXflisXSUYVw7649BMfpZSOGR+LuSZ+LLZc
         XxL8jXOveuX8PP6uUZpoWvdol4LOoyeStH60+xDDAFXNEE5Xd4GeAw0mdQcerhH7kHOO
         eeGoD8QB+ve5nGyQFoJpYV7S48cfaYEBw/RbaI1poMwqusJPEcrJ6GoftTN4f2ziTOgt
         ACyQ==
X-Received: by 10.68.138.200 with SMTP id qs8mr38941226pbb.19.1441034492477;
        Mon, 31 Aug 2015 08:21:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id v5sm14967095pdo.87.2015.08.31.08.21.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 08:21:31 -0700 (PDT)
In-Reply-To: <vpqzj17hpt8.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	31 Aug 2015 09:36:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276883>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ad/bisect-terms (2015-08-03) 4 commits
>>  - bisect: allow setting any user-specified in 'git bisect start'
>>  - bisect: add 'git bisect terms' to view the current terms
>>  - bisect: add the terms old/new
>>  - bisect: sanity check on terms
>>
>>  The use of 'good/bad' in "git bisect" made it confusing to use when
>>  hunting for a state change that is not a regression (e.g. bugfix).
>>  The command learned 'old/new' and then allows the end user to
>>  say e.g. "bisect start --term-old=fast --term=new=slow" to find a
>>  performance regression.
>>
>>  Michael's idea to make 'good/bad' more intelligent does have
>>  certain attractiveness ($gname/272867), and makes some of the work
>>  on this topic a moot point.
>>
>>  Will hold.
>
> This topic has been there for a while and unless I missed a discussion,
> nothing happened. While I agree that Michael's idea is good and makes
> this series less useful, I think this topic also makes sense.
>
> I'd be in favor of merging it.

"Nothing happened" is never a good enough reason to argue for
merging new stuff, but now you are starting a discussion here, let's
see where it takes us to.  I am neutral myself at this moment.

Thanks for helping -- reduction of the number of topics in stalled
bin is always a good thing to see.
