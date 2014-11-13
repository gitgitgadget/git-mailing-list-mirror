From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: t9902-completion.sh failed
Date: Fri, 14 Nov 2014 00:35:25 +0600
Message-ID: <8761ej54oa.fsf@gmail.com>
References: <87mw7v9xhl.fsf@gmail.com> <20141113112447.GA4437@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XozFf-0003Kj-Vh
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933690AbaKMSgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:36:11 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:54226 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933526AbaKMSgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:36:11 -0500
Received: by mail-la0-f50.google.com with SMTP id hs14so7576959lab.9
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 10:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=I6pVIZs8Goz5GZCuvm1ODXyfZSStxraYYHWoop61xq4=;
        b=UhRDdg7EMz9VYRzZoOYGCLhNzCzX0DYIsDiPebNlHSiaKWx5Vw6zJouOeMEu741y/2
         lr6QdrMAe6ALtzj/monECzJsXbMLptr064d/1MBiHnpC/CEs89KHcb4YzONA/UsjjjV+
         pTbMpRIdSwiIQ6mcQCD0AnZfHvlFi2xNIoKLO/4koxXHwxJg3mJEWZqRknKS0TUz9ll5
         Vwpb/9lchBDPeARQI85scUM6ktsEPzT52zLxGSvtgbgXeSeRJDTkKsxddnumWf2Vg5q7
         x9pNC4OftCosy6KFPLjILI1hmnINI19/9fESB4I2jAPILH+8DX3nO+G5OwPMV3ZYrkj0
         7Tlg==
X-Received: by 10.153.11.169 with SMTP id ej9mr3949087lad.72.1415903769030;
        Thu, 13 Nov 2014 10:36:09 -0800 (PST)
Received: from alex-desktop ([2.133.1.112])
        by mx.google.com with ESMTPSA id jq16sm7652439lab.14.2014.11.13.10.36.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 13 Nov 2014 10:36:08 -0800 (PST)
In-reply-to: <20141113112447.GA4437@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


ah, i catched the problem, I launched make test with sudo and now all
tests passed successfully.

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
