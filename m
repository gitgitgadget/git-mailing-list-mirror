From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/9] t1508 (at-combinations): document @{N} versus HEAD@{N}
Date: Thu, 2 May 2013 12:34:59 -0500
Message-ID: <CAMP44s1akBT3ZqD5iODjm-AXRMwqsz7K4HCdR5uz07YCLs54yQ@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<1367501974-6879-6-git-send-email-artagnon@gmail.com>
	<CAMP44s1Hkff1QU7undZvLfFOCeeiBrB4RRtVEOoNCsfoGZu7yg@mail.gmail.com>
	<CALkWK0n9dOrn_whASyWnx49zwNZV_z-4mstyorN1DTSfKpzfsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxPV-0005JE-T6
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab3EBRfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:35:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51526 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757775Ab3EBRfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:35:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id r10so770403lbi.5
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=B7jtYTgUqxTZY9mOLr4oBDniR3TYqCbvnU3hiJtL7Tk=;
        b=H70vXFly2vde2QULMiKQRZ4LxDBH2T3e7JqInz5HTKQmEmLeigMvAGBcMxOEgOAXLy
         WCSIRSazzE5llebg6+Oup1bwVHV+v1f5/6A2GFsRFsjLQ5kAdcOmdMRe80q7sX+PCY2A
         BvS61AxwyJbEfCFrhLqBZ34okIK7gI+2AP93hGCTkshHm30yxqvoMpdIQeJT6rKi/4+B
         JyEbNf9RC3IuMDS+nttXMOVbiJBf/t1ULIlofG+irpHlxLYCcRzljqhJ3OJ8t+3HySZQ
         Kyg1h5ZFz0EAwrU70d7h5+EBf210Rq6QKBdhDIdk1vlYU1kZRTcuZ2pxpLqSZ8oHen4j
         fzFw==
X-Received: by 10.152.22.168 with SMTP id e8mr2890054laf.20.1367516099760;
 Thu, 02 May 2013 10:34:59 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:34:59 -0700 (PDT)
In-Reply-To: <CALkWK0n9dOrn_whASyWnx49zwNZV_z-4mstyorN1DTSfKpzfsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223237>

On Thu, May 2, 2013 at 12:30 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>> +test_expect_success 'switch to old-branch' '
>>> +       git checkout old-branch
>>> +'
>>> +
>>> +check HEAD refs/heads/old-branch
>>> +check "HEAD@{1}" commit new-two
>>> +check "@{1}" commit old-one
>>
>> And here we are testing something completely different.
>
> How?  I'm showing that HEAD@{1} can be different from @{1}.

Never mind, I thought you were testing detached HEAD checkouts.

-- 
Felipe Contreras
