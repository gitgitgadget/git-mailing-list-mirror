From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Tue, 16 Jun 2015 21:31:21 +0530
Message-ID: <CAOLa=ZTbipvpL+RUxH5TqAVYaF+dKFLR6FDbSRE3ph4ERcXD4g@mail.gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
 <1434464457-10749-1-git-send-email-karthik.188@gmail.com> <vpqmvzz8yr4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4tJF-0007l6-TG
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbbFPQBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:01:54 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35297 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbFPQBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:01:52 -0400
Received: by oiax193 with SMTP id x193so14666183oia.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GVF7As3Osr82WW25rT/OZx+IT/tBQBOY2/aJmn2nWsU=;
        b=BNx6vJbyhqhARJjyy65g7vihxAq3E9mPjv8YiPJ7xLAh0zivD93LpNWA/oVwQmtUhJ
         H9GFetZJtaOIjk8EGyzwDFWUTgzrbaSD/SfswbnstU+wpcsmsolsBROMr4VcTl4xbGl/
         9BIYkiemoBqcYDrnmbiHJY09RY7FVhEs/7nrsdprQHtENfdKT7v53I+/nFOrqLYh2Ikb
         h9CqNSvCJ+8nCoJBNAIjdpa7zL/D+LpvydYDP57VgrCnH4wansaBAA4zm2rlXcxLussT
         ouBzNax2VbGSl3Rf93l7ybZeSs0t1kmV3K/jUsao2bpopgY9miMwzlMpBkODcTwsPv9M
         twTQ==
X-Received: by 10.202.186.132 with SMTP id k126mr855029oif.60.1434470512149;
 Tue, 16 Jun 2015 09:01:52 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 16 Jun 2015 09:01:21 -0700 (PDT)
In-Reply-To: <vpqmvzz8yr4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271773>

On Tue, Jun 16, 2015 at 8:51 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add tests for 'for-each-ref' which utilizes the ref-filter APIs.
>> Currently it's redundant with the tests in 't6300' but more tests
>> will be eventually added as we implement more options into
>> 'for-each-ref'.
>
> Actually, I'm not convinced that the actual tests have a real value
> (since as you say, it's redundant with t6300). Perhaps we can limit this
> commit to the setup.
>

Well I just wanted some minimal tests, but yeah, we could limit this only
to the setup.

>> +++ b/t/t6301-for-each-ref-filter.sh
>> @@ -0,0 +1,36 @@
>> +#!/bin/sh
>> +
>> +test_description='test for-each-refs usage of ref-filter APIs'
>> +
>> +. ./test-lib.sh
>> +. "$TEST_DIRECTORY"/lib-gpg.sh
>
> You are not using lib-gpg.sh, right?
>
> If first thought it was an incorrect cut-and-paste, but I actually think
> that you need to setup a signed tag to properly test the --points-at
> option (it does not only list refs pointing directly at a commit, but
> also refs pointing at a tag pointing at the given commit).
>
> Such signed tag could be added here and used later in PATCH 04.
>

It is a cut-paste error.
Thanks will look into it.

-- 
Regards,
Karthik Nayak
