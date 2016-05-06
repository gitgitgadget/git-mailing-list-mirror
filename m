From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Fri, 6 May 2016 01:30:45 -0400
Message-ID: <CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
	<1462441802-4768-1-git-send-email-pranit.bauva@gmail.com>
	<xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 07:30:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayYLj-000459-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 07:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbcEFFar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 01:30:47 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33191 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcEFFaq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 01:30:46 -0400
Received: by mail-ig0-f195.google.com with SMTP id rc4so4127198igc.0
        for <git@vger.kernel.org>; Thu, 05 May 2016 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=xoA/ILo351JXwHpJT+nVvGy0rlooeRwG0bZfb5DWIws=;
        b=XYOgnJPQFOOauGlwZkSzuSGLUp0LS2bT5RnAlgv22MLFx+Mhw4Q6QF2RG0fNJeW5yn
         iARNn7SPQmsVSc6xmv3dHclgYyVt44oPyYjHQFL+00HpwH3bf6ZvhcwsL+d2qHMIO40p
         kEDUt7QfWm5FJ3UHCYRXnB3dTWKW0kmIS+DwlrPkHYuq6cXZf7UI3Cjum1jMvg3mpOTq
         ELLa1z+RLF38bHpCsqGjG2Th70XJoJOyAJ4wrKIIo7PX9gflY9h6bf7A0xAdPSqYH4jT
         QSdardQhk2Z3HUGwVOOI73YuYEK6v8HtbGBPS4GNdCSJuEh6lBstrgX2vbY2LBR86sQ3
         tU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xoA/ILo351JXwHpJT+nVvGy0rlooeRwG0bZfb5DWIws=;
        b=DwJ+at3owVutYSgf1/MYA8n2ddHyA27xugl8s48Z3J4JnBhO27dWaNjahrZ0OJ1qmE
         SCQjY4Ce7cjXtzsFQXOw9jDYdZl51h/25h3KagdgEsOGdRnUEkAdmQ7ZHKPPn6C0V6nL
         DXaSfINbva5cPa9A1Lg+QPWu44tH/ep8a7Q69L+tjIlL+N9fRPpXJsiF7GIgQMO8ePRI
         brBFK3AEONpZg3vrYf/s0wz+aO4hxVAhRu4pWfo6S3DWTof1jb4V5E5VRrNSGuboTAml
         T4qMuceegyQi2qpYDdSvYCFfTf6vPF2vZSBXDTBlpp2/aVSHZ6hw8Ydfh+14IMcxrG4T
         5kLw==
X-Gm-Message-State: AOPr4FU8JVOvIc578I6eSY9Qyp2AQ3OkkX+tsq8dL0n/elVvLtoxzQjEVzf/+osEtvT2ef6BeVk/7NzwcJNyQw==
X-Received: by 10.50.49.15 with SMTP id q15mr7995346ign.73.1462512646065; Thu,
 05 May 2016 22:30:46 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Thu, 5 May 2016 22:30:45 -0700 (PDT)
In-Reply-To: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: vSpFpV3jXgl1iJA0RjDxe5ogYuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293740>

On Thu, May 5, 2016 at 3:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>> This series of patches add a configuration variable for verbose in
>> git-commit.
>>
>> Changes wrt v15:
>>  * Remove the previous patch 7/7 and split the tests. Include one in
>>    initial patch 6/7. The other one is introduced in a separate commit
>>    after 4/7.
>>  * Include tests in patch 3/6 for --no-quiet without -q, multiple verbose,
>>    --no-verbose with -v as suggested by Eric Sunshine
>
> Thanks for a pleasant read.  Modulo minor readability nits I sent
> separately on 7/7, this looked good.

Agreed, this version was a more pleasant and coherent read than previous ones.

Considering that this series is already at v16 and the 7/7 review
comments were very minor, I'd be fine seeing this series land as-is,
rather than expecting v17.
