From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: t9902-completion.sh failed
Date: Thu, 13 Nov 2014 17:34:50 +0600
Message-ID: <878ujfxrgo.fsf@gmail.com>
References: <87mw7v9xhl.fsf@gmail.com> <20141113112447.GA4437@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoshV-0007qc-C7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbaKMLg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:36:28 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:33860 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599AbaKMLg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:36:28 -0500
Received: by mail-la0-f41.google.com with SMTP id gf13so1116359lab.14
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 03:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=Sam1aMDpWGINruL/T4VEjeRscgrniUzmN7l05ArVMpk=;
        b=k2VlNFmh8CRH7RRXQzt1hgRp5PvPIjUIl2/oGJ4uQurhWh0yCpVCBYMOOcuteDNAgZ
         p6MnaJnAo319TENyXYjEm1LTS/T+1mK8PbhFnaUf9lA9qabSk3jgTvjucMxPZWRakuI4
         kAb30RRGWxiAJpA8CUYXYkuFYMffWZXbk1MhfTsv1AZOPZP575ZO5lV9EOnu948Ceps2
         Y2b/ilgXY2W3o0aQpO7DPM3O5ywBn3t4obmnWOQfLzFqEZHAzyxFath76IIEhtM2JmFF
         KJXYRlcB5uBm2iJD68WfvqjVqrnTSGffcATHDF9xqzpiTnWtoiLAnYA3BasYuHakqmxC
         6sLw==
X-Received: by 10.152.42.172 with SMTP id p12mr1884232lal.11.1415878586588;
        Thu, 13 Nov 2014 03:36:26 -0800 (PST)
Received: from alex-desktop ([92.46.69.219])
        by mx.google.com with ESMTPSA id eg2sm7421809lbb.29.2014.11.13.03.36.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Nov 2014 03:36:25 -0800 (PST)
In-reply-to: <20141113112447.GA4437@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello Jeff,

I'm using ubuntu 14.04 x86_64 and bash GNU bash, version
4.3.11(1)-release (x86_64-pc-linux-gnu).

I didn't applied any patches to bash for all time since i installed
system. so it reall weird


Jeff King <peff@peff.net> @ 2014-11-13 17:24 ALMT:

> On Thu, Nov 13, 2014 at 04:59:12PM +0600, Alex Kuleshov wrote:
>
>> i just got git from master (f6f61cbbad0611e03b712cc354f1665b5d7b087e),
>> built and installed it successfully, now i'm running make test and got
>> following error:
>>
>> *** t9902-completion.sh ***
>> t9902-completion.sh: 118:
>> /home/shk/dev/git/t/../contrib/completion/git-completion.bash: Syntax
>> error: "(" unexpected (expecting "fi")
>> FATAL: Unexpected exit with code 2
>> make[2]: *** [t9902-completion.sh] Error 1
>> make[2]: Leaving directory `/home/shk/dev/git/t'
>> make[1]: *** [test] Error 2
>> make[1]: Leaving directory `/home/shk/dev/git/t'
>> make: *** [test] Error 2
>>
>> $ bash --version
>> 4.3.11(1)-release (x86_64-pc-linux-gnu)
>
> Weird. I can't reproduce here, using the version of bash from Debian
> unstable (4.3.30(1)), nor compiling 4.3.11 from sources. What platform
> are you on (i.e., might it be bash + some other patches installed by the
> distro)?
>
> -Peff

--
Best regards.
0xAX
