From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 18:58:32 -0500
Message-ID: <CAMP44s1bvCYw+srX_geY-4YeY7pBVVE=fC5O+BScZfQDhC27UQ@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
	<CALkWK0=LuycRpuwBMjfiSk9qy2Y6VZsmmhNLpKdovKX4rZ=hTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud84F-0005sW-KY
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab3EPX6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:58:35 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:46211 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3EPX6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:58:34 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so3777468lbi.32
        for <git@vger.kernel.org>; Thu, 16 May 2013 16:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=j+mPShwYbyUtOEk0jj7sNsSilt/IGVV4zYWObRT2gys=;
        b=yWvAdT4VTSlrhWvvBHyHnKhedzR9D6nyYn1jT1t0y8P7e9QrGxKf4NOpREz+SZxP/F
         rjNu229B23VMpwMmvikAGW+Lpq1zHSlCQTKsJt87XihSCQy6PSo9I2mN210FaYpeJ7tP
         npf6/G4t0c6gn1ynZu0Zw6ojrjU1cOB2B95jLJRriRQOrYJxnEubTFkSx41a5ZwUU8vD
         dM2VsVCfuud734a0e2tWbYoUrbeLF1CSxBZJDTkKPS7aro+kOqxdMV4wYQwLvEGWaQkb
         h5GAIH1nzirV3C/7pPVXzFYxvb7c6LG4cHvmBKrV9zVZsorW+zubjq1O0unYBg4I3rJ1
         Eb0Q==
X-Received: by 10.152.87.69 with SMTP id v5mr21634172laz.24.1368748712971;
 Thu, 16 May 2013 16:58:32 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 16:58:32 -0700 (PDT)
In-Reply-To: <CALkWK0=LuycRpuwBMjfiSk9qy2Y6VZsmmhNLpKdovKX4rZ=hTA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224640>

On Thu, May 16, 2013 at 1:34 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>>     (defun linux-style ()
>>       "C mode with adjusted defaults for use with the Linux kernel."
>>       (interactive)
>>       (c-set-style "K&R")
>
> There's actually a "linux" style you can inherit from.
>
> May I suggest looking at Documentation/CodingStyle in linux.git for this:

Surprise surprise, we have a discussion about what should be the
coding style. Didn't Junio say it was already "the style of the
project"? Moreover, I don't speak emacs, so it's all gibberish to me.

-- 
Felipe Contreras
