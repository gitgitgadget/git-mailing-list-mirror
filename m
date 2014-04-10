From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Thu, 10 Apr 2014 14:17:45 -0500
Message-ID: <5346ee59d7881_d98135b30ce7@nysa.notmuch>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com>
 <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
 <20140106201854.GA28162@sigill.intra.peff.net>
 <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 21:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKdw-0000Zh-Em
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbaDJT1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:27:47 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:46549 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbaDJT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:27:45 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so4968288oag.23
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hLX6s4aXyG+7Dm3c2dDvosnBieqxtTA+5AErPjDTTYs=;
        b=w+EtDvG8CfJFgyaf7KDX6F6V+B25tQUDZ3+4qwe7UGEkeIEfmLtTO+h7LTQmGCHM3L
         jKmkL5nRHwps2p85FfpyRrGtMxow8WgPVWZYNlYV9rEsauXPE6hYNemysUmch0SItVXW
         aDf0dv7yRhjIUj5dngHS/1Dx/ljh/18K+JbELa7V5ERTbBOuzfN0XkVx4oifFBSO0fXX
         Dsaa7/QI6Q3HOrnYiKcUTdGyBKsVFLHgfZpChYnLPgu9tctAGoR7yUDzDKPDWHDkp8Qf
         s9RTmy9AWQ5dL68+bJ+ZqQw4708UfhOULLB5UDCFm5WbYsyzKTyf8Qg3bRLeQVfGVMhg
         cmUA==
X-Received: by 10.182.248.131 with SMTP id ym3mr3325660obc.58.1397158065230;
        Thu, 10 Apr 2014 12:27:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm21343431oek.12.2014.04.10.12.27.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:27:43 -0700 (PDT)
In-Reply-To: <CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246049>

Ramkumar Ramachandra wrote:
> We already have a branch.*.pushremote, and I don't see the value of
> branch.*.pushbranch (what you're referring to as pushupstream, I assume)
> except for Gerrit users. Frankly, I don't use full triangular workflows
> myself mainly because my prompt is compromised: when I have a branch.*.remote
> different from branch.*.pushremote, I'd like to see where my branch is with
> respect to @{u} and @{publish} (not yet invented);

@{publish} not yet invented? I sent this back in October:

http://article.gmane.org/gmane.comp.version-control.git/235981

-- 
Felipe Contreras
