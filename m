From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr
Date: Sun, 01 Jun 2008 01:40:59 +0200
Message-ID: <4841E20B.1040109@gmail.com>
References: <1212276975-27428-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 01:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ahr-0006si-TX
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 01:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbYEaXkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 19:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbYEaXkl
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 19:40:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:54310 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbYEaXkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 19:40:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so397754fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=cmBFHqJqDp1z07DPQrmZCMhtPzckcXoDbM8AhzNpjm0=;
        b=EVR8z5wJDUJE7ae8k7fVaCbZILZFakZWaQes2xpWIyL+BSZmH3AFUGB/vwOCxG4XYs1nxQsimzz6MPPg+4MgZdp2Irp0+D6bzdjQ5ASvffJdlvv4Dx0oWlrpbZuKVDF/ycdSvfY7Q0h8us4fRGVBugk7Qvi2LVAwE6HnqiVugM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ZbgXRYp/NwQBeWcAkZ8BVWONH+pW4Qko5Pj48e+2mrN18b1STCcGuk+zZ44U/W1q8nsNCo8kUIUiYOA30VhFsQl0YTDwitiv7cZLHAP/tjmHWcNRWDcCAnaZTlyeUmWRVTsITGofuVjmRWIoGpP8jtVFlwjA9f6pefqXfKTNWMg=
Received: by 10.86.70.8 with SMTP id s8mr367038fga.79.1212277239506;
        Sat, 31 May 2008 16:40:39 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.240.119])
        by mx.google.com with ESMTPS id o11sm5819275fkf.16.2008.05.31.16.40.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 16:40:38 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212276975-27428-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83416>

Lea Wiemann wrote:
> Subject: [PATCH] t/test-lib.sh: add test_external and test_external_without_stderr

Yikes, hit send-email too early again. :(  Anyways, I just wanted to say 
that I've tested both functions for both the success and failure case 
(with my first version of a Git.pm test suite, written with Test::More, 
which I'll post later when it's finished).

-- Lea
