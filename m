From: Patrick Sabin <patrick.just4fun@gmail.com>
Subject: git workflow - merging upwards
Date: Thu, 16 Aug 2012 21:49:02 +0200
Message-ID: <502D4EAE.9010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 21:49:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T264G-0001G2-8X
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 21:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209Ab2HPTtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 15:49:15 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62889 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2HPTtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 15:49:13 -0400
Received: by wgbdr13 with SMTP id dr13so2716671wgb.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2012 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=adMN4tql0AJMsGrd+NF7IRb8KamElwMOiJDJklfP9dw=;
        b=fFZpKvjeAOBTAvjB3jy5dHJi+U8xgnkpfCHXyXwRusJixXMWdxQDrpQnbfYpGcdcv1
         d4xm2Bh0mtId38P7FiTDhwhBVL4pm9BG7gWC2GCmLCoUPdxrnLSNGTi55sysZcNUR00Y
         i5RrL5OcCd/40NZJ6aaHEAOSrLX9ffhNNx/ezXD5DI53YNKSZo08a8DDooL4ZkYFqbrs
         5PnzUBxvsAa3C5RV+VBgj+wFr3tTMnSFDXgErK2k4M+czDBZArgET86r6jXypnRpG6NZ
         olORyZ3E4kKiorWC15q/W9dvF/O6h0HDf0Pxxj6iR8aDzohlviPfS3R26+PEJhw3lxJ7
         IluA==
Received: by 10.180.91.169 with SMTP id cf9mr647900wib.1.1345146552498;
        Thu, 16 Aug 2012 12:49:12 -0700 (PDT)
Received: from [10.0.0.1] (178-191-228-188.adsl.highway.telekom.at. [178.191.228.188])
        by mx.google.com with ESMTPS id fb20sm8251029wid.1.2012.08.16.12.49.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Aug 2012 12:49:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I read through gitworkflows and want to use the Merge Upwards rule in my 
projects:

"Always commit your fixes to the oldest supported branch that require 
them. Then (periodically) merge the integration branches upwards into 
each other."

This looks great but I have some trouble in the case if I want to have
a change in an older branch and don't want to propagate the change to
the newer branches. Let's say I have a v1.1 and a v1.2 and now a have
a bug fix/workaround which only affects version v1.1 but not v1.2. If
I commit to v1.1 then the periodical merge would merge the change to 
v1.2 which is what I don't want.

Any ideas/workarounds for that problem?

--
Patrick
