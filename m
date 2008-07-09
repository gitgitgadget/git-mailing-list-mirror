From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH 4/4] Documentation: Improve documentation for git-imap-send(1).
Date: Wed, 9 Jul 2008 13:05:34 +0100
Message-ID: <1096648c0807090505l43e30f43pd348f95af4345956@mail.gmail.com>
References: <1215555496-21335-4-git-send-email-robertshearman@gmail.com>
	 <19AD9080-74BE-4147-8DF5-8A2937129B6D@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYRW-0007Zl-Oc
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYGIMFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757636AbYGIMFg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:05:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:45606 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbYGIMFf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:05:35 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2112116wri.5
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=N4JIC7tnMnhU5bVzA/u0IL3N+NANTbQw1XK4gDfvumE=;
        b=t1NvdG0uGWhedGu2K7uFv7tqaCVKI5jHCDk2M4C/7apX4xk2Nog+C4qGzHujCAvqa9
         m/R6ZSmimv6LHaRmoDsgE3GiTLb9vUvb5v9Kxd11cpDQr+hjg8dDhK99IP8MagkizHwP
         IuR8ZXOIyu7oRZZ5vIKSWfWHE+H6r1E/MGIfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ntU+WMXJunIWPLrIr8dlsoSYFiDBuKJAIndtvJXyWPQtvmAzafKDqJrZY8SkhhTOmQ
         JpG1Qx5AulBEALoOQchaqHBFNoppBvkoTTzaRbySbm0Z6L8ONsC289rx+WSG3jXxw3dn
         5OLLJKyOnGFDcTI9qRgGXKhm+VYXsJ3Wl9LfI=
Received: by 10.90.115.17 with SMTP id n17mr8431442agc.57.1215605134391;
        Wed, 09 Jul 2008 05:05:34 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Wed, 9 Jul 2008 05:05:34 -0700 (PDT)
In-Reply-To: <19AD9080-74BE-4147-8DF5-8A2937129B6D@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87875>

2008/7/9 Brian Gernhardt <benji@silverinsanity.com>:
>
> On Jul 8, 2008, at 6:18 PM, Robert Shearman wrote:
>
>> +Using direct mode:
>>
>> +.........................
>> [imap]
>> -    Host = imaps://imap.example.com
>> -    User = bob
>> -    Pass = pwd
>> -    Port = 993
>> +    folder = "[Gmail]/Drafts"
>> +    host = imaps://imap.example.com
>> +    user = bob
>> +    pass = p4ssw0rd
>> +    port = 123
>>    sslverify = false
>> ..........................
>
> If you're going to use [Gmail]/Drafts as the example folder, shouldn't you
> just use mail.google.com as your example?  Google themselves use
> username@gmail.com as an example[1], so that should be safe. So:

I'll fix it not to use "[Gmail]/Drafts" in the example as that is the
exception rather than the norm.

> And I also assume that someone has tried this with Gmail and it doesn't
> mangle the Drafts.

Yes, as specified in my previous email I tested with two different
IMAP servers, one of which was Gmail.

>  I'd also move the sslverify option into the tunneling
> example, as it's more likely to be needed there.

Actually, the sslverify option is ignored in tunnel mode (since you're
likely to be using your own encryption with the tunnel). I'll document
this and other ignored options in a revised patch.

-- 
Rob Shearman
