From: Mathias Lafeldt <mathias.lafeldt@gmail.com>
Subject: Re: [ANNOUNCE] Sharness v1.0.0
Date: Wed, 15 Jun 2016 11:03:51 +0200
Message-ID: <CAMFa-2gKpm2jLiYGVrdkrhvo5uzqdq+rNJhuyFrWL+LbnhHSWg@mail.gmail.com>
References: <CAP8UFD0uvaB-2_CrXs2ZvoqLRHfCd8efA-S7-tE2Qa6Pn+rAAg@mail.gmail.com>
 <CAGZ79kYaQTdVoXOGpKbQmWsdRftY10TBZTTf_Ya-fdegykU-QQ@mail.gmail.com> <CAP8UFD2wT0Qoxksza1uU1GMTWRD4GcfdYzDTrNh+JLtfT9h3rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 11:04:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD6jw-0002yl-00
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 11:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbcFOJDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 05:03:54 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36667 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbcFOJDx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 05:03:53 -0400
Received: by mail-wm0-f53.google.com with SMTP id f126so12241165wma.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ExXGh1OWirS9rtgxEyGy9nwUVT/xrtAeLJ4uCfPlI5U=;
        b=ZE1meeqt/KVLfvur+f7G7UfDvjJNt307JZNd9ldDO22TT5qyffVPHDLk+x3g37Y8wE
         uDuNB2blw4atZV9R/P0Fg3mHDTRFX5srpQesO18xt9D5/9hHVMSCZFGmraDLPG1Kovxc
         6J8ZyDUZonAKFSku9pywTu0hiD083CKj5TRw4/Uaq6yViHrlLU3gptRT1gfRiiQpycjK
         ac98USE7qqTG5qtkoBD7NPGxzHE+mPfdwKE0mCwOdl1ucVuksaNBXBjN8qxwtBSN8cUk
         lB48gPZIBgGKxUODyzJu1hq4Xp7nS8BWR8JupRQ5k+MLQwSoNIauMeZlUKPBYn9Z9nC6
         kxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ExXGh1OWirS9rtgxEyGy9nwUVT/xrtAeLJ4uCfPlI5U=;
        b=AOHNuZ6oXDY2UXOFn64K76/qFI9eO9jRL4M9zHhbThfVkKDrIo7kGzmmt10PykXmpq
         3+moGLTMRl9oRNMC3y1DMT31StPG+zkIS3mYDAQVjZ5lTIPe4unh7ewW3FhE+tPdXnt1
         ozphSyyGgTDzKT3/pp3MEsLqkB8ueCXtl5+22MnWj4sGCoeJiz8DP3hxSMhhMQ/HUOPz
         W9KxnWy7E2kYPFfgGJWzttzMId5SsjuJA3z+oycfpnF5xOktmJpObHxJMyOd7KXoeLG/
         GqrNA89CGN5+hpV5f4k/F0MlPA0Yx3ECYCEtTDRLulTF05kkkC+Gv9ZWrhuA0nr9rj0i
         BFCA==
X-Gm-Message-State: ALyK8tJBsSgXciY9KkDAbgWzYt+pa5RGyzGN+lYztkm+8ucaR3rN6Ncb5XCr63hDErx4l4/seR2DsS4dFyswqA==
X-Received: by 10.28.48.15 with SMTP id w15mr9046584wmw.28.1465981432544; Wed,
 15 Jun 2016 02:03:52 -0700 (PDT)
Received: by 10.28.230.209 with HTTP; Wed, 15 Jun 2016 02:03:51 -0700 (PDT)
In-Reply-To: <CAP8UFD2wT0Qoxksza1uU1GMTWRD4GcfdYzDTrNh+JLtfT9h3rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297361>

>> Is there any word out there from Mathias on making you the designated
>> new maintainer? (I cannot tell if this is a genuine maintainer change, or
>> a [hostile] fork by reading this email, and I don't know much of the context,

Yes, it's 100% genuine. I handed over maintenance to Christian Couder.

Here's a signed commit to prove the transfer:
https://github.com/chriscool/sharness/pull/55

(Sorry for double posting, the mailing list didn't like my first email.)

-- 
-Mathias
https://tinyletter.com/production-ready
