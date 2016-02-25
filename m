From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: using git-diff as a diff replacement?
Date: Thu, 25 Feb 2016 09:38:50 +0700
Message-ID: <CACsJy8DTKOhOxdiQbRSddMSTMCQAFmZDdm6G1QeY6TpDf2HuKg@mail.gmail.com>
References: <CA+P7+xq7gobJbbRxm51APMQ8408jyvW64=1y3wo3jz3rjMsDqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 03:39:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYlpz-0006SZ-5q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 03:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbcBYCjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 21:39:22 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33078 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbcBYCjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 21:39:22 -0500
Received: by mail-lf0-f42.google.com with SMTP id m1so24498210lfg.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 18:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tzMrPi+TC/nP7lBrAZwzCe/Krc9EDj6pz+rxMJ2ENic=;
        b=XaDPEAmX1s3L0XXFqJKNUokZuOW6OFw9PI/YoduhbBveL0GTeMrdXY0ezGaaDtbdAJ
         0k8uKbY5ojpfOSfOsJsuR2Te3ll+xllns2pVpTDU7i63KpgQKccAbAk7p/AJIIBcM0cK
         b9YyU0bgchNUXe00VF+n1MFKM2yWhkQlwAiVJcqClhK+yTlfor1e2xSDikP2RqeH6RLT
         9rD/Ue44KO53r7vFp06sKyYzEB1P3EA43A1aGF4AAOAZ/EbUZWMT/NygiqvIAGGDoN7M
         FQwePacLqlwBCeEEueO/S0zcSErrfVFJM+av1QfWSnfbbaZF9omZbCoy8Bb956UGfCxC
         4G6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tzMrPi+TC/nP7lBrAZwzCe/Krc9EDj6pz+rxMJ2ENic=;
        b=CDgtU4mTL0liXSnocXgyqGvYbQGO1u3w86RGF/WJyzPB5yK+6abt3jPUTzKxHhIjsH
         Uv/1t/Je3J5QGP5W3XtUI93PSL1rGZlEkIqxjy9is0jsuZovqgEmvg2YGviQYRvfU4rX
         Fk2EcOfK/DBcrUQwV6o6a+gU/YhXvOCANEqII4tJpT1wTweT1qVDoGpg58HQ1Ev14Urj
         pUy/rjijrJoz9ebDfw2uZz1R1MXBqVxQpwxOUO+ZWAEgMa1EzT1vU4YQX+3VcFA2xuO5
         /4pLFCKrg2mmQ2hzMaG2tPXshRz/zGim82NYALvjPFZ3gix5s5wQXZ8jwA5vFwCJ/plQ
         OYjw==
X-Gm-Message-State: AG10YOTFcuExeVD8JfDgzm4ZEWk1OmeVvsw5oqrHVxcKsuDuX0RH+qXiaa6FI6j8dLSrwRy5Ut0JvV0PMtaKQA==
X-Received: by 10.25.212.197 with SMTP id l188mr15812888lfg.118.1456367960277;
 Wed, 24 Feb 2016 18:39:20 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 24 Feb 2016 18:38:50 -0800 (PST)
In-Reply-To: <CA+P7+xq7gobJbbRxm51APMQ8408jyvW64=1y3wo3jz3rjMsDqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287313>

On Thu, Feb 25, 2016 at 5:21 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hey,
>
> I know that running "git diff <path> <path>" when outside a git
> project will result in a normal diff being run. I happen to prefer the
> diff algorithm and diff output of "git diff" but there does not seem
> to be a way to have this behavior from within a git tree.

git diff --no-index <path> <path>

?
-- 
Duy
