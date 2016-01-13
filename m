From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Adding a commit to the front of my branch?
Date: Wed, 13 Jan 2016 10:18:19 -0600
Message-ID: <CAHd499Adtc3qMgvXywONpgK0Z5NzGMnZ-=5akbLo+i6m2oJpYA@mail.gmail.com>
References: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
	<1mgv8hf.iib6fg1g9uszaM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:18:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJO7y-0005xL-0r
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 17:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbcAMQSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 11:18:22 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36841 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbcAMQSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 11:18:20 -0500
Received: by mail-io0-f182.google.com with SMTP id g73so228358037ioe.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7V3AnDEKQLV91QBUTKa3kQFrJE/YIBTqziiewG3gBtQ=;
        b=S4JoU5ydlDXOWoQnwzjDxCXh8Nc22WG6btmgWMIny6kCkR8ibthKMuOrL13ZnWjYrL
         wDthx4HfMsixHxfO3J6yIr2p+gvtJtwLfOgQHtkq2kOlOq9ZHm1blae6ENIO9N/9OtIL
         5wb4qHLGUH5ZqAxc7o1XtG2D3Y3q125RB0gksJFb5eL+yid59Ih/JIj2Oa37elfqn6X+
         cpJIPRbJ21Wb+BEoanBFpdRW8MESLS6H9XwrdUJHi4zTf5TTB5solaJAEckoTTJ4h6ao
         ZFS6S1blJC5vSstJSlWXIrnPjYAjQTYv0sr5466Xk/Zaa27wfdoQEax2y3H4JSNVeZ79
         hnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7V3AnDEKQLV91QBUTKa3kQFrJE/YIBTqziiewG3gBtQ=;
        b=W6xzkXcqCHOwWIVMFGzu8zqUTMojRVbIl0moBSgDamgV4G14d+5uxgRzmaG1gmpVBZ
         +AVMqPErO0tFuh2xKwoeAOOgD6bs+9uSILiMifoH5Lgf7EL/4sA1V4g3rbDWz+Wkcv28
         4c1mzv+pZH7v6k5K/D1VSGMNJSLHvKnI4Gx7zY3H97IikD+QsiR07V4Xrl9i+fIkeT03
         7zz6fFcZ1A+CSyJ7Pem/iBId8DxUJUnW3rkcEAPPwW6vTZGu8cbi1apzMzvslXWE2Dmz
         jUYzaN2WLdMwRr/jWCPknYv9qTHEuS5t7WQmB7NljQL4090IfboeT4w9Efo9Pl42Y9Q+
         fMzw==
X-Gm-Message-State: ALoCoQnRXDWWu5Gc8jINzzPK7CFDpIFmbSf7kSt7cTTb8ASLO50wdH7GymEj6WL+jZi2xyNj4NNkPRMiNtmI8yDxnHBn1eXqWA==
X-Received: by 10.107.128.133 with SMTP id k5mr120348787ioi.26.1452701899682;
 Wed, 13 Jan 2016 08:18:19 -0800 (PST)
Received: by 10.36.83.83 with HTTP; Wed, 13 Jan 2016 08:18:19 -0800 (PST)
In-Reply-To: <1mgv8hf.iib6fg1g9uszaM%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283923>

On Mon, Jan 11, 2016 at 8:11 AM, Stefan Haller <lists@haller-berlin.de> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> wrote:
>
>> Normally to add commits on my branch, I perform an interactive rebase:
>>
>> $ git rebase -i origin/master
>>
>> I mark the commit I want to put the new commit on top of as 'edit'.
>> However, if I want to add a commit to the front of my branch, I don't
>> really have a commit to mark as "edit".
>
> Instead of marking commits as edit, I usually add "x false" at the place
> where I want to add a commit. With this I find it easier to see where
> the new commit goes, and it also works before the first commit.

What do you mean "x false"? I'm not familiar with this. Can you explain?
