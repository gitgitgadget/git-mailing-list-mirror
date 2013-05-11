From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] git-prompt.sh: colorize ZSH prompt
Date: Sun, 12 May 2013 04:10:13 +0530
Message-ID: <CALkWK0mySjW_QGObkXWvhzMa0gbwKDire4Dx9=PV+9OnEgZjsQ@mail.gmail.com>
References: <CAMP44s1pO+ytNWEV6ykRn671yf50+oMZQMnrcTN+s5ykPRpumg@mail.gmail.com>
 <1368310739-24099-1-git-send-email-artagnon@gmail.com> <CAMP44s1B+FfdKebpTq+AwHP3YCiiVc++rtc8wqOn8EOy1dyLwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 00:41:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbITZ-0001d1-1C
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 00:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439Ab3EKWky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 18:40:54 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33889 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab3EKWkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 18:40:53 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so9879518iec.25
        for <git@vger.kernel.org>; Sat, 11 May 2013 15:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bn7Gbs2KYrBVJkZXESJUVbpQfMEPoBcr+Yv8bhstr0w=;
        b=C5cN2AUVUJK+JHWpHsFBrqVKUIYp/jOwOX7qQ/mEAe57BL08ZF9fPQsc2voW4zYUBy
         /qqxv20HlZRlE3zVEAcEGqYOkr8lcggEVLeOxk5xyY3qLyiy8SIY5ze73rFDaoTuHiiv
         25ChwartLd2LR6Y1Hsu2XeeSTeZNCoizl9gikqtJZ6JCspEza+imCnwGTfIM1kI/3gtb
         ImDOM+wE0kwlMtrbbacN0TYNry3mqRWTjVsr19mWRF3QdZbEYzi7rRLrZz4EKd368jSf
         a6iNwDdKsF1ddRN9V1pk9SI+fUXem42+F15WK0/ov3WbFdZxjCGFSUtBfyuxn9HwrKF5
         763Q==
X-Received: by 10.50.147.71 with SMTP id ti7mr6140220igb.49.1368312053513;
 Sat, 11 May 2013 15:40:53 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 11 May 2013 15:40:13 -0700 (PDT)
In-Reply-To: <CAMP44s1B+FfdKebpTq+AwHP3YCiiVc++rtc8wqOn8EOy1dyLwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224017>

Felipe Contreras wrote:
> Not really. If we need to avoid the \[\], it makes sense to have a
> separate function, but what I meant is that this function should be
> initially on the same file, and created in a separate patch.

What are you saying?

1. It makes sense to have a separate function specifically for ZSH,
but it should be located in the same physical file (why?)
2. You like the original patch, but would prefer two different parts (a nit)
