Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 19280 invoked by uid 107); 27 Mar 2013 21:50:56 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Wed, 27 Mar 2013 17:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab3C0VtD (ORCPT <rfc822;peff@peff.net>);
	Wed, 27 Mar 2013 17:49:03 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39824 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab3C0VtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 17:49:01 -0400
X-Greylist: delayed 10642 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Mar 2013 17:49:01 EDT
Received: by mail-pd0-f176.google.com with SMTP id r11so1198872pdi.21
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 14:49:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=x5A0mQXQuz71VbvDXrirBWRFHrNSGAZsF8i6AeSPXbg=;
        b=jOnLcxTDToOrC21Dq/L6UJfwukse8StkZOwrQSh7VyuLETGlGAq0PCy6A2hi23eM5b
         Ze3FNiETvzudXjahsPioXq2/ENVu0ZSAyLN5JRWMDGqGxCfSpmDH8dfEoPezZCKdLzym
         g1TcRFlUw4/kgeCCnr91Ni/FpP3XhuKBe1dtgYHUb7nJQ+xs7pPIhYniqNzzDw19cN/E
         jxovv0GWu53KKVzeHKqdr0mkWwmRPSyjXxBrKHiA8NDtlHu224zsgyRYaTDA5xUcAwK8
         lfsWSQ9A+7wQhio04bdJCWu5rt3YWrj9CHXrNgUF1yJCQ87+2grUfTsnhumbSh2vm5HL
         lC9A==
X-Received: by 10.66.151.46 with SMTP id un14mr17961959pab.14.1364420941075;
        Wed, 27 Mar 2013 14:49:01 -0700 (PDT)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id ti8sm22815163pbc.12.2013.03.27.14.48.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 14:49:00 -0700 (PDT)
Message-ID: <5153694B.2010405@gmail.com>
Date:	Wed, 27 Mar 2013 15:48:59 -0600
From:	"J.V." <jvsrvcs@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
MIME-Version: 1.0
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: which files will have conflicts between two branches?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I have two local branches (tracked to remote) that are in sync (did a 
git pull on both branches from their corresponding remote).

Is this the best way to merge?

I would be merging local/branch1 => local/branch2 (test this branch) and 
then push local/branch2 => origin/branch1  (and would expect no merge 
conflicts if anyone has not checked in anything.

---
Also with two local branches, Is there a way to get a list of files (one 
line per file) of files that would have merge conflicts that would need 
to be resolved?

thanks

J.V.
