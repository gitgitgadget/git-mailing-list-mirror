From: "eric miao" <eric.y.miao@gmail.com>
Subject: automatically generate initial in-reply-to?
Date: Thu, 6 Mar 2008 17:08:05 +0800
Message-ID: <f17812d70803060108p60e28093sb1d5d15e1324240d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 10:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXC5v-0001Bv-C8
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 10:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759752AbYCFJIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 04:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758607AbYCFJIP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 04:08:15 -0500
Received: from rn-out-0910.google.com ([64.233.170.184]:59779 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361AbYCFJIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 04:08:07 -0500
Received: by rn-out-0910.google.com with SMTP id v46so839490rnb.15
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=JwiYcbuIAC9uM9Y1EJ3jCEgmXA7E6NVbl8JD5xyPnn4=;
        b=XREOXRFkXj9JfF3e9YFnia6aMfN/rvZILjxAF0OvF7hk2pWy/O7fuVbDm9cfQfoWiOhER+lKt31O/SYOiMqzg/M1ju1tzFZRoKQri2l0nuk1sIQsRqdBUoFC9mNZAyQfaPqXB3Sgr2eAfh8S+XRs0Asqs9kN6+11+af1JPMIKLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oGMhBva9NEPo/Qr0Ch+9UNm716OPAhHzjZ0Mb44PQYGe6nwPE8P3G8ULtbUN2E05JPDD3CfkyLmxRTB4zOGyFHhpG06wfsdJ+YlMBya16ODAXbmqFrwqqjXi+cSCUw6ieq+YEYtoN8dZPTQ69n6Y1xsPvv0yG7s3jFC/ofTcoBc=
Received: by 10.114.179.1 with SMTP id b1mr6387901waf.143.1204794485881;
        Thu, 06 Mar 2008 01:08:05 -0800 (PST)
Received: by 10.115.75.13 with HTTP; Thu, 6 Mar 2008 01:08:05 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76357>

All,

My personal preference is an overview message of "[PATCH 0/n] xxxx"
to be a thread topic (first message in this thread) and then each of
[PATCH m/n] with In-Reply-To: pointing to this first message instead
of pointing to the previous one. So I came up with the following
command:

git-send-email --compose --no-chain-reply-to patch/to/send/*

I then was prompted with:

Message-ID to be used as In-Reply-To for the first email?

I tried to leave this empty and also input some random strings,
both failed me by setting all In-Reply-To: to the same thing.

So here're two questions:

1. what's the correct command to do so?

2. input in-reply-to manually does not sound like a good idea,
is there some way I can come up with an automatically
created one?


-- 
Cheers
- eric
