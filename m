From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Tue, 3 May 2016 10:12:44 +0200
Message-ID: <6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com> <1462220405-12408-1-git-send-email-larsxschneider@gmail.com> <1462220405-12408-3-git-send-email-larsxschneider@gmail.com> <xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 10:13:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axVRz-0007SU-UO
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbcECIMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:12:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36566 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcECIMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:12:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so2335708wmw.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b2egU/P1xYq88VkZyHb9hj4p3X6znfDIpo10AbRXFgE=;
        b=k8tjzNLRD/mf1VHz0XAIQ2OcuDMRAPPt8HQVi1G0+2uIqbDeNx5NpxENhVNPayGlvl
         fZeLU6RvGyl6S05U2+CY/zTGWsJns9tJBiqDm2XNkSQjS7f7K/u5sEmgO5aJubthkOEs
         ufV8aUz8EtWTLXUO8X3c3U0byg9aJxNXCjAYDZFCUkaYMg3uinRjEVIoF/NLGBFKNLeP
         EaDSTYEq69PPjFQCrIINnKpttPDDI0PLRHvxx0JDcx9P2hs24/Z+bu0HGgjZA6Yv+rbI
         FblFMqkgAgnA5HUFvPW1CQu79WtJlxAyXy8T6CO/BXaZvtunyuxeE2e8du4ysGyweVKZ
         lw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b2egU/P1xYq88VkZyHb9hj4p3X6znfDIpo10AbRXFgE=;
        b=I9VA6LYhFXeEgDYQLwlvyuENALLZtU8L0bWaRb176H8WkQM3263N5SKIzWlXT2Sz2V
         elQ4NCeXQMwWlKViF+BSLmA3RNB6kF6YFTrZJ3vysftrukgcWIEy/BC4SqGe0NtzJEBB
         TcahL0vbF5k2dM6dWUDoJzhpKpWdfb5SOm1SrYRS9p42RV/6I8d3XlOj1wU+aL8wmug4
         hJMMDsRTifndaE4/OycR7+2OXIFq0Q+L7c+Qe9+75XssPa/80oIyaucWaf52pYqZvzet
         CZr/ztv9FhWeoaZfXv6JBT9c1Mj9SGmt6ooM1hWnOP8WZ7DERlhGV6SytC63yM09kenS
         6BoA==
X-Gm-Message-State: AOPr4FU7Bn4AvjrqgtjcO6c2UApmn1aAVB96Giag0FHq9VSbgBTeed5erjy7IQ1FpYR5Jg==
X-Received: by 10.194.118.195 with SMTP id ko3mr1481453wjb.178.1462263166090;
        Tue, 03 May 2016 01:12:46 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB77BE.dip0.t-ipconnect.de. [93.219.119.190])
        by smtp.gmail.com with ESMTPSA id gg7sm2447667wjd.10.2016.05.03.01.12.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 May 2016 01:12:45 -0700 (PDT)
In-Reply-To: <xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293332>


On 02 May 2016, at 22:45, Junio C Hamano <gitster@pobox.com> wrote:

> larsxschneider@gmail.com writes:
> 
>> +set -e
>> +
>> +LINKS=$(grep --recursive --only-matching --no-filename --perl-regexp \
>> +    '(?<=linkgit:).*?(?=\[\d+\])' Documentation/* \
>> +    | sort -u \
>> +)
>> +
>> +for LINK in $LINKS; do
>> +    echo "Checking linkgit:$LINK..."
>> +    test -s Documentation/$LINK.txt
>> +done
> 
> Please separate the above link check out of this step and do so
> separately after the move of test body to a separate script
> settles.
OK. I also wonder if the link check should rather go to the 
"check-docs" Makefile target?


> When you reintroduce the tests, please make sure the shell script
> follow the coding style of other scripts.  E.g. I do not think the
> last one in the $(...) needs a backslash continuation at all.  I am
> assuming that you are doing this only on Linux, in which case use of
> GNUism with grep may be fine.
OK.

Thanks for the review,
Lars


> 
>> +make check-builtins
>> +make check-docs
>> +make doc
>> +
>> +test -s Documentation/git.html
>> +test -s Documentation/git.xml
>> +test -s Documentation/git.1
