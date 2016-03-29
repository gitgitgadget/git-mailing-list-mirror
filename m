From: Ori Avtalion <ori@avtalion.name>
Subject: Re: Warning about conflict markers - undocumented 'diff --check'
 feature & suggestion
Date: Tue, 29 Mar 2016 21:27:47 +0300
Message-ID: <CALgdb5LS9EgqaBsm6vEWfQz-BZE=xH42fFdF5-eg-XyNsRBYkA@mail.gmail.com>
References: <CALgdb5JuoYpHAPxTY2cHdbkcPUjKtsWQ_DY5rBrw-YKCwj2yvw@mail.gmail.com>
	<xmqqd1qe1a2i.fsf@gitster.mtv.corp.google.com>
	<CALgdb5+E7_CT2e9WFBd9GhiFuc_B7+bpC9tjDfR+-QiTGeoP+A@mail.gmail.com>
	<xmqqvb45xhw1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:28:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akyNE-00049e-D6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 20:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbcC2S14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 14:27:56 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34307 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbcC2S1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 14:27:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id p65so152127951wmp.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=5X+6JgB2PLjGF1kfedilj0XhWKAWCqz/Ier+R/YwJH4=;
        b=ycmrud2QInEut8lX8SqYqMtcx5DffNsGp5DHuuYZdexzlT94e/xDB6wiU0oSWRxga6
         MCEJPQx3T7t5IhPJkUdqa2crn1p+TkwwtL1XKNWAZVSHoJirgzFcO+uyakT8Hq9kpZqv
         vaPpZGDiPJdhAVbIo/BFUXy84KnR5L/SBZ1nxxCGvsTes+OygXPRWHfKHfB0J8H4qrXw
         zKNf+SPwwFVdQUDNbUAFrAFKth5Yknms1WuhVzUqCDftpEQIi1LQCECsh6EKdylnTEj5
         tF/h4AsPUIRum0k9YBg64cJ89NzdxCH+Trwzw9f8qd0+tkwTouhexwA+HuYNuCXCaTN2
         Fenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5X+6JgB2PLjGF1kfedilj0XhWKAWCqz/Ier+R/YwJH4=;
        b=HrheM0LauwYbYdorPQ8kfVkv8XClqYOD6ChlTq1CfzKw9BwamFZz3xzW8emH5vMW23
         DF9zLGdjkuP5Cu6xyHiQ96X25ConAEldl9dIAutWbibxFooloj0N7bRS1BXGA3Tq/1xH
         oETRNfBwXeuXqgiF6F6dm7DRPrR8f8SpTdIJTl1yTZxOoBOkj2o5CkHSHf9+JmIGvhXh
         NREPfqBySYSgeHJ0ZjXmFmBCphN5CSEuGDgDmpKrCv2fcIkJ+OWqatAt5Mgox9hnkNZP
         Uq+TB/ClrdcDv+C/hr+L8dLZtpT2xBW3Kfo+PB/gcHfCx49RK/WhLSjvr/41kJ1yrk/N
         T9Rw==
X-Gm-Message-State: AD7BkJLRNSIHQTsjqdPUZhbapb7K0qYe8EsyUiwPXCJ3/i8WXaLdYfmgMQnm7vtf0KyOB8XXLx/wpoD3SzSPEQ==
X-Received: by 10.28.227.130 with SMTP id a124mr4982729wmh.2.1459276068051;
 Tue, 29 Mar 2016 11:27:48 -0700 (PDT)
Received: by 10.194.69.132 with HTTP; Tue, 29 Mar 2016 11:27:47 -0700 (PDT)
In-Reply-To: <xmqqvb45xhw1.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 1sS7IUIhUnOOyn0qQGtEI4_NDno
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290156>

On Tue, Mar 29, 2016 at 9:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ori Avtalion <ori@avtalion.name> writes:
> I am not sure what "similar functionality" you are imagining.
>
> "git add" does not show any changes, it just does what it was told
> to do.  If the user is unsure, s/he should make it the habit to
> check what s/he is doing with "git diff".

I was thinking of an off-by-default setting where git-add outright
refuses to stage changes that do not pass "diff --check".
I understand if that's a big deviation from the spirit of the tool,
and perhaps not a good idea.
