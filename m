From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 01:09:57 -0500
Message-ID: <CAMP44s2yOGtwz6Ez6aHSQKQi+gZWf1dvU__sf9ssJf52g3MLFw@mail.gmail.com>
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
	<CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
	<CALkWK0k6D+hOw2iQ=tJ+_bkKOA-7dKkEsG9XBSBqkg9hDm-bGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 08:10:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdDrl-0006hl-1H
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 08:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041Ab3EQGKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 02:10:01 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:63406 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab3EQGKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 02:10:00 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so3861492lab.12
        for <git@vger.kernel.org>; Thu, 16 May 2013 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xFCmYbyfx2OUEQsEzmuSM6ibw9ezVXawF4HBMBC/9Ro=;
        b=BDlS5a4EuiwPjngrfW3G6DLWIHAcQH960eL1COWZopD2199o6Dywl+uBhEv5sa2Cq4
         xx7IM1h7prgSKqOg+7tgPnLR7ITbrA2pmTYrMvzqpeSxm+tjm8aQ6gdjMmm5Al3cOqz8
         aeTWH6+GduIQHkSt2oEj2oYtJvJT2LKJVpCORnyeU4q1aV8GfZ8aijxolDMVkVveWU8m
         Rlz/prLNbOuWzZFl6DrbUN/XPYvsoMDi5AnQRCItWBBi/D2XrEF8KjnoPJXN7WHZyymL
         VxPYiG0A5s7ttY6eSRRGb+fXPeVXLtfTCMSFn2zN70ebw4HQwmihEFy6rVQHnN5uSa67
         JjAw==
X-Received: by 10.112.172.40 with SMTP id az8mr10616535lbc.88.1368770997376;
 Thu, 16 May 2013 23:09:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 23:09:57 -0700 (PDT)
In-Reply-To: <CALkWK0k6D+hOw2iQ=tJ+_bkKOA-7dKkEsG9XBSBqkg9hDm-bGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224653>

On Fri, May 17, 2013 at 1:04 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> This is what Linux's checkpatch throws:
>
> Perhaps it's time to include checkpatch.pl in our tree and update our
> CodingGuidelines?

checkpatch only works with a Linux tree, and it doesn't treat this
alignment as an error, not even a warning, because Linux's style
doesn't have it specified either. In Linux, maintainers couldn't
possibly reject a patch because of this.

-- 
Felipe Contreras
