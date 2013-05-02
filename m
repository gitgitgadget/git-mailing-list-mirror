From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] t1508 (at-combinations): document @{N} versus HEAD@{N}
Date: Thu, 2 May 2013 23:00:14 +0530
Message-ID: <CALkWK0n9dOrn_whASyWnx49zwNZV_z-4mstyorN1DTSfKpzfsg@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
 <1367501974-6879-6-git-send-email-artagnon@gmail.com> <CAMP44s1Hkff1QU7undZvLfFOCeeiBrB4RRtVEOoNCsfoGZu7yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxLR-0001Ka-QL
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760167Ab3EBRa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:30:56 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:34194 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792Ab3EBRa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:30:56 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so936762iee.37
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1HcIz3a1xMYOskYjMyB8i2pB5yxnESAAEbaU5DrfNK0=;
        b=DQI/bK3KQhytHsNQRXyOveSlAo/ZQMZvrFVhiGFzkFRKOJCBTk8TwfBFLHDevHnz+L
         sw/dSk1IcqMvgVKeU8FdAtQz1qtbnFEzBoPXxp3swgm2I2UmFX0DJARrSQ2h/XqecKd3
         1DSKZaCxGtRLdxK0mPTKlRPOilDN/2W2yiYr7quWbJe8HEFJ/utKjhrUM8m2aUrX2XfV
         bz24tXveyiu2gbmbhgSMESOWUsFRomwSRpQhCLTpc82wdZY+Tee8uj3LQS/KgQbJapNT
         yq6ZJv4rCeR+ErtkqQuKkjvQmOQKunhpKXU/+snWBYFafaGajpxnleQ64R0ikg7soKSo
         2ljQ==
X-Received: by 10.50.3.38 with SMTP id 6mr4308636igz.44.1367515855604; Thu, 02
 May 2013 10:30:55 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:30:14 -0700 (PDT)
In-Reply-To: <CAMP44s1Hkff1QU7undZvLfFOCeeiBrB4RRtVEOoNCsfoGZu7yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223235>

Felipe Contreras wrote:
>> +test_expect_success 'switch to old-branch' '
>> +       git checkout old-branch
>> +'
>> +
>> +check HEAD refs/heads/old-branch
>> +check "HEAD@{1}" commit new-two
>> +check "@{1}" commit old-one
>
> And here we are testing something completely different.

How?  I'm showing that HEAD@{1} can be different from @{1}.
