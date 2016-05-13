From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 2/2] travis-ci: build documentation
Date: Fri, 13 May 2016 08:26:19 +0200
Message-ID: <87079FFA-996D-4F8D-A2A8-7C8917CEF545@gmail.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com> <1462351116-19308-1-git-send-email-larsxschneider@gmail.com> <1462351116-19308-3-git-send-email-larsxschneider@gmail.com> <xmqqpostrg67.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 08:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b16YN-0003RJ-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 08:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbcEMG0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 02:26:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33429 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcEMG0X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 02:26:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so1632132wme.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/H+skWWuEIIvGFu+VFZQYF5SN2PUFya3U7xAi3E7/Ok=;
        b=Y5a8LRGC+cu0O3/AOUm1/84ks5LqSVYDW8rRZrBSJ8u63Evb4JiB6NVg5FkLC/Fxlm
         7RF9xkrbeDTrnb7Rdyp7j2omOuHrswarT5QwzOqUSLMnn0t6zn7CPgvNunZ88mJhNagS
         8htjBbthx41NwawEGNWENrolqPB+yT14Co6mTl+m8N/JB7TTTc43YxJ3kT8V5rX6Ilm6
         FJQgWW/yxonwsBjEbANyQ3i03Cjt1oE8YhGGUl/o5C9tlXtiT9zQWiGitrb+JyeZGmDW
         cZqEtAzXU2O6Y8SPmbWOnhVZKNV8Rkg3hD8jSMBZfzmN+6HyXxpphymloMC9oLQZBPhf
         mLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/H+skWWuEIIvGFu+VFZQYF5SN2PUFya3U7xAi3E7/Ok=;
        b=BOLJlzuwk8+mKFi79v3bNs63itm5JNDM9r4jz9XHj71IYiIb1dRQx6/Mwd5iJm/c9j
         961skoMvwQMA63h2kTGIyX5N+fASs1oS1mNgHP/frj6b/hWN5i2bvkhG87CcBPwqN6qH
         uK/lBEe4wJnlWzRnTwIEMB3kpuHDcZlWgWzH/vphwuaxconCS7UDVWO/CsXFpA9nrjsP
         J9yOUWKyEq+IG+5Ki4r4h2snnFE3Tz6WnxbdFI6BcDFEqqNrNFq8Yo8jdVlKllFkh8pK
         qnm42cer5Aisu+dpu5KIr3Mlh14l6qFeQM4JjtoVS2r6SZzY9xHbTCQOGoFxOeFRVo15
         A7bg==
X-Gm-Message-State: AOPr4FWHD43KzktTFUhbXP/AWxbaBt8B4opLmXFRcdBqdiTvzaZCX1tZylt4msuoq+ospg==
X-Received: by 10.28.18.11 with SMTP id 11mr1573554wms.51.1463120781525;
        Thu, 12 May 2016 23:26:21 -0700 (PDT)
Received: from [10.32.248.65] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f135sm1521758wmf.22.2016.05.12.23.26.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 23:26:20 -0700 (PDT)
In-Reply-To: <xmqqpostrg67.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294506>


> On 10 May 2016, at 19:12, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Build documentation as separate Travis CI job to check for
>> documentation errors.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> .travis.yml              | 15 +++++++++++++++
>> ci/test-documentation.sh | 14 ++++++++++++++
>> 2 files changed, 29 insertions(+)
>> create mode 100755 ci/test-documentation.sh
>> 
>> diff --git a/.travis.yml b/.travis.yml
>> index 78e433b..55299bd 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -32,6 +32,21 @@ env:
>>     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
>>     - GIT_SKIP_TESTS="t9810 t9816"
> 
> Completely offtopic, but this looks like this is made to apply to
> all archs, not limited to OSX?  It of course would be ideal to see
> why they fail only on OSX and fix them, but shouldn't the blacklist
> at least limited to the platform with the problem?

As far as I remember the test was flaky on Linux and OSX. The problem
was not Git. The problem was the Perforce Server "p4d" p4 daemon which
would refuse to die sometimes.

I run a bigger number of Travis tests and it looks like the problem is
gone. Out of 60 runs only just one failed and t9810 / t9816 passed:
https://travis-ci.org/larsxschneider/git/jobs/129383851
(BTW: does anyone know how I can make prove show me the running tests?
I would like to know which test died there..)

It looks like as Perforce solved the t9810/t9816 problem with the update 
from 15.2 to 16.1 that we made in 31f3c86 "travis-ci: update Git-LFS 
and P4 to the latest version". I will post a patch to enable these tests,
again.

Thanks,
Lars
