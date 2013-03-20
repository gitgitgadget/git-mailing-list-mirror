From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Thu, 21 Mar 2013 00:03:51 +0530
Message-ID: <CALkWK0nu5oMw-+uh8mLRUOyAFoETUpKZfYuO2LLJAgF0+XHpRA@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-3-git-send-email-artagnon@gmail.com> <20130320182213.GI3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:34:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINqX-0005Ut-IS
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab3CTSeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:34:14 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:60587 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab3CTSeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:34:12 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so1684371iag.27
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=eYPLnpE8wvbh6uikFunx5E79GnDjLEUhTNnpaoQGjn0=;
        b=bO6AjmcmwVnMrY9Oa11NcQBpOQZIivFIxd73QM4XM8lWXTVQ5YgTs5l5oCDRmKK2W6
         rgR+EdAnkB4AwbETMoIwNfBbDvGQ8De3SJPc13qNR8xeGOZCgWYApDx9MH9wXN7DPyoB
         E4ClhoS+NhTiZ91umj5nSChSlxwST+X5HgNQNWmjmVuo82cW2jSLvmw/4Y6W+6X8Ty4W
         NipdmLc2KDxYx03ZyieRTRjk93ECNJ0UOjPsRKuNYlmmpFzEiALAgruyFkPUeVMhpvtz
         dxz+9hyIqM6/vUYSYadk9sAXoMnwY/Pw++XLUmOwSrGTR9LTMF7qn31iWErZfEJO9BIs
         gPBA==
X-Received: by 10.50.17.71 with SMTP id m7mr98364igd.14.1363804452018; Wed, 20
 Mar 2013 11:34:12 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 11:33:51 -0700 (PDT)
In-Reply-To: <20130320182213.GI3655@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218643>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -1,6 +1,6 @@
>>  #!/bin/sh
>>
>> -test_description='fetching and pushing, with or without wildcard'
>> +test_description='fetching and pushing'
>
> I'm not thrilled with the description before or after.  Would it make
> sense to do something like the following?
>
>         test_description='Tests of basic fetch/push functionality.
>
>         These tests create small test repositories and fetch from and
>         push to them, testing:
>
>          * commandline syntax
>          * refspecs and default refspecs
>          * fast-forward detection and overriding fast-forward detection
>          * configuration (insteadOf, pushInsteadOf, [remote "name"] push,
>            etc)
>          * hooks
>          * --porcelain output format
>          * hiderefs
>         '

No.  When I want to add a test for branch.<name>.pushremote, I grep
for branch.*.pushurl, and open files with sensible names; I'm not
going to open up the file and read a long description of what tests it
already contains.  The filename and test headlines are sufficient.
Our test suite is bad enough as it is (inconsistent style, missing &&,
false positives)- I'm against adding to the maintenance burden.
