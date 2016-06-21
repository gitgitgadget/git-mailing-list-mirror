Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FAF1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 12:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbcFUMtH (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:49:07 -0400
Received: from mail-lb0-f193.google.com ([209.85.217.193]:34081 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbcFUMtE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 08:49:04 -0400
Received: by mail-lb0-f193.google.com with SMTP id w10so1753587lbo.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 05:49:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J3qrdDIykEBVimx4PHxWc+iqc8IEVr7lI/aUiY9c2a0=;
        b=hpH9IFa7ysn9oxQr5sqxmbbirVObAEhjDmk29IVFEv9YSKrA12i+5/w8fusJWDP0lH
         yIMn6fRBtTbuWUjssWSNkXbilI5F93gJpzncLxGnm6Frefm1LrmYaIcZw56WsNOKeM2u
         G8LoNcVHgdbZDkVSne2zIImmm474AyABGE40ie57RSCVQSkSczKGQC5+jvWRZ+0D++ml
         nkrx5kgUfs0/3vZf1YTXBA9EjqF7qaULNb3UAEvjSPtzx+1hgakZtdhS6S7eWajbdSus
         vqU43Z/TqQ5udlxeAUTqUpRGnrbPjqVcpr0ORnW4QaKK38s78z4Gr16pz+R3pkbZYhrV
         SygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J3qrdDIykEBVimx4PHxWc+iqc8IEVr7lI/aUiY9c2a0=;
        b=MkirvvgnGfWBljjZg2oFBxfog5iQFO8VpkJVqZAA/n4dcWVKzccka0s3UkDyZjvmL6
         FdDlU6bF38DampH39jtjDb3WUYU1TOMHHxhOYXO01YG41fDa5q1brsvKEpAmscGW66lQ
         AeBs8KPmSWqfpo3AYlZOAFdGsEs2xpK+Pk3XtkHKNjNVgzpWIkXZFcU1pDSUmx+BOXtr
         ETIzBMBmo9LTAW5we+d/QIAafLnAlSwqYSAhww76uXMNzD8vu925Xz/Cppt3Wia9Gq6a
         P7Q31zyPgOZ8iHixEt50w3Ip+FRwO5PhprYnvax0pdAj2URnso/HyuqkBF0KANHF4ZPu
         qTBw==
X-Gm-Message-State: ALyK8tLrbkT2OjrSW7xBzlvZTyS5ZHzI2ZiQhjVQ9tOAQm2ZV0c07F0xOX9ZtctKLevAhg==
X-Received: by 10.194.109.232 with SMTP id hv8mr19832571wjb.115.1466513342801;
        Tue, 21 Jun 2016 05:49:02 -0700 (PDT)
Received: from par3bztk12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id k6sm3568836wjz.28.2016.06.21.05.49.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jun 2016 05:49:02 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] perf: accommodate for MacOSX
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1606211350470.22630@virtualbox>
Date:	Tue, 21 Jun 2016 14:49:00 +0200
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CD0404AE-529B-44B7-AE05-022D3062E596@gmail.com>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de> <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com> <alpine.DEB.2.20.1606200840350.22630@virtualbox> <xmqqa8iftzex.fsf@gitster.mtv.corp.google.com> <F67587B5-0EA8-4F2F-AADB-4343B4FEEA21@gmail.com> <alpine.DEB.2.20.1606211350470.22630@virtualbox>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 21 Jun 2016, at 13:55, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
>> ...
>> I think we definitively should take the "perf-lib.sh" part of the patch
>> as this makes the perf test run on OSX and therefore is a strict
>> improvement.
> 
> Yes, it was meant as the starting point to get more things to run on
> MacOSX.
> 
>> If we don't run any perf tests by default on Travis CI then I wouldn't
>> take the ".travis.yml" part of the patch just to keep our Travis CI
>> setup as lean as possible.
> 
> Maybe commented-out, so that people like me have a chance to use Travis
> for MacOSX perf testing?
> 
>> Running perf tests on Travis CI is probably bogus anyways because we
>> never know on what hardware our jobs run and what other jobs run in
>> parallel on that hardware.
> 
> While I agree that the absolute timings cannot be trusted, I have to point
> out that the relative timings on Linux at least are consistent with what I
> could test locally.
> 
> Could you let me know whether a commented-out
> 
> 	# Uncomment this if you want to run perf tests:
> 	# brew install gnu-time
> 
> would be acceptable? I will reroll the patch accordingly.

Commented-out would be fine with me!

Independent of your patch:
Given that the relative timings are consistent for you. Maybe there is
value to run the performance tests (e.g. only on the master branch)
in a separate Travis job. Then we could chart the timings over releases.
I dunno.

- Lars