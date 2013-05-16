From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 02:57:48 -0500
Message-ID: <CAMP44s2ht8nv9qJY-sbnHzScJkqNTkkB1ePSp++9rLBL-JrvEg@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8BnwFXsXYXPe7driH9q9e4otMuMvr4sJdLQWxhf0owCDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 09:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uct4U-0002L8-8h
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab3EPH5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:57:50 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:45275 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756374Ab3EPH5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:57:49 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so2701712lab.34
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DZhP/tKzAFoNMVCHAnAmMwfKGOSGhBY0ZARgAiFIb+k=;
        b=zQjIpFmUItzufmQ5f5/xHR2IuWzDuAUCgfKnhFg1ww4BQyEQchHJSoUpn5ffRqZKsK
         o3tPKFRzkpzxuzaYWJ8GOAemAuHsikqDf0ll0xHhUyEZyHetOPx1GPt7xYnREdO2Fw0z
         GMIwh+VZ5OnIJpgjijDETIaodPBQI78uzibBHWMXCJ1sjqYV1jOfGcjlciG0azGTV8l4
         USvSpB8L4v3Q/jyT0eT8c5EVOLTz6+rFUrnI11lE7rPfp06r5M26CGc5AD9G4ODAeX/v
         W9Fl+FCqkf+zJiEKJiN8O0FOV9FyWI/huS6+aOhIhF8857yZahSfTC4k5FRGAF/mSWeV
         B6tA==
X-Received: by 10.152.3.103 with SMTP id b7mr10303666lab.8.1368691068456; Thu,
 16 May 2013 00:57:48 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 00:57:48 -0700 (PDT)
In-Reply-To: <CACsJy8BnwFXsXYXPe7driH9q9e4otMuMvr4sJdLQWxhf0owCDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224492>

On Thu, May 16, 2013 at 2:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 16, 2013 at 2:48 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Showing the tracking information for all the branches takes significant
>> amount of time. The user might not want that. The --no-show-tracking
>> option allows that.
>
> Or we could cache the information somewhere in .git. If a ref still
> points to <SHA-1> as recorded in the cache, use the cached tracking
> information, otherwise go the slow way.

That might be nice, but even if that was fast, I personally never use
that information, so I still would want this option.

-- 
Felipe Contreras
