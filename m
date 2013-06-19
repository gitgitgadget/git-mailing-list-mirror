From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 3/7] t/t2012-checkout-last: test "checkout -" after a rebase
Date: Wed, 19 Jun 2013 15:11:11 +0530
Message-ID: <CALkWK0nmotYMUDpRp5Yp8sRfhy1brSWSCxz91oBWVE8ryrtetg@mail.gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
 <1371629089-27008-4-git-send-email-artagnon@gmail.com> <51C1756B.2000907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 11:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpEtq-0003eN-0S
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 11:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933862Ab3FSJly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 05:41:54 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36330 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933755Ab3FSJlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 05:41:53 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so13102495ied.28
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2gXREB+EhdXvXXg3xNupL1YME2XjqXcNlRcCty3hADQ=;
        b=zUK1KN3pgaPLypZIsLB1oYPElFoNj1+p3c5aiww5oCyL+uwmJH0mbbF0l4jlaMhdHA
         l0PU8HVNSPg0tNmWPCBUtG/01SEndPgK2VPy/jUchXqmXAOw1ZAU05DZXvSL/V2ZiCeI
         4UoZYggg8lAzlOKlqOAYoDWVLRtFdiAGRDjJ+2nrIwQq+klNsO5lFMFCegeUBHFUWLc2
         J6+dFwcSv6VCzgEP0vCbQxoj0vdRaUTtlDCGCByv2YD+l9wkj1hmbsouzJj7c1CivURz
         3b81Z4xQQXXYFwRYyKcZ6MPqU7RvAi91mJ4fHwLz6UxjAYPaO0lc2zxy6rPw3aqZzNCw
         vmIQ==
X-Received: by 10.50.98.104 with SMTP id eh8mr9503760igb.111.1371634912994;
 Wed, 19 Jun 2013 02:41:52 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Wed, 19 Jun 2013 02:41:11 -0700 (PDT)
In-Reply-To: <51C1756B.2000907@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228382>

Johannes Sixt wrote:
> Am 6/19/2013 10:04, schrieb Ramkumar Ramachandra:
>> +test_expect_failure '"checkout -" works after a rebase -i A B' '
>> +     git branch foodle master~1 &&
>> +     git checkout master &&
>> +     git checkout other &&
>> +     git rebase master foodle &&
>
>         git rebase -i master foodle &&

Good eyes.  Thanks.
