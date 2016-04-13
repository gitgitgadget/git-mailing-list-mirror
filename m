From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v1] Documentation: add setup instructions for Travis CI
Date: Wed, 13 Apr 2016 10:56:30 -0700
Message-ID: <CAGZ79kYBK-MNYZRo+LsBqng47usGPQTyBe01W2SrKDrs3435sQ@mail.gmail.com>
References: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com>
	<xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 19:56:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqP1o-00057i-CI
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbcDMR4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:56:32 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34884 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbcDMR4b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:56:31 -0400
Received: by mail-ig0-f175.google.com with SMTP id gy3so127280935igb.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Qv6HrBZjMBos5Jr2iD503A+tD+DsYqg9gA7ffFDd3Q4=;
        b=ngPTRicNoufW70BUaK2FHZHp0wVqXoPU4FpM+zSfBeGAsx7pSjXEOP0u9KwmX9BsLc
         ypikK2/jmOEXs2Sd90bSzzam6G9lZhe38PDVJz907BLQiV/8MmZ2nRBTyWDO1LivfQQE
         KEpP1Beurpk0Vxa/eMbGb/nRRngb+GUX3V4j0eAm8mG6hCWNlkkCgxeFjZh64EMRLpEQ
         Rfde7VhdfcwJ3a13L19IAwGul8kUWCFjXxUetdojQ54XrwdYYH+5AVFtOquo/3nIZnb3
         y4O3cVcOO+ZgM0rv7thnW1ERIWt3LXfH0A6OYk3+a/7ZPZZYD1ZyXwdNqn7pcsgifWWr
         /NOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Qv6HrBZjMBos5Jr2iD503A+tD+DsYqg9gA7ffFDd3Q4=;
        b=GE9uHoXkuoLd2d1Wf6hPSSdnuTCJ5Hy4z4nh0VlyMvlwVHGB9/eQwoToDRBH6SzuI0
         T5aJitZIzfJHrkGuLGXBJl32LXBXR7ql1+m516M6W7cumcnHLC874N2DHE/aCNOJF7OE
         UwsgMeiqJLXjgi6ahzyBWEsVlYI5vFpcd8iZztQx8yzdbaMjxaezant9pipBRRucDLSy
         ks99fuP9p6HgJgdCwTHHQyf681rXTCuTIdLafmVI1xS+u5T3ONgpul4Vf7txGnjuTwta
         gLD6I8YIPW0C2GT+imaicBukFuagDGJiWu36UfyTfAGk3J9Z+HKR+tis/Ulp5FIUV/Nj
         UiNg==
X-Gm-Message-State: AD7BkJJDomxKP5RNCfPh2YGHYVgG9t6LZUHn2VGaX5+8ad9v/WT2+idD82ZEsb7TOa36f3YhtR/FN+3BSPRavFiL
X-Received: by 10.50.23.80 with SMTP id k16mr33785809igf.94.1460570190246;
 Wed, 13 Apr 2016 10:56:30 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 10:56:30 -0700 (PDT)
In-Reply-To: <xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291472>

On Wed, Apr 13, 2016 at 10:39 AM, Junio C Hamano <gitster@pobox.com> wrote:

> here, create a "GitHub-Travis CI hints" section just before "MUA
> specific hints" section,

Somebody (I think it was you, Lars?) at GitMerge suggested to break
up the SubmittingPatches document into more than one, i.e.
the MUA hints and the Github-Travis hints could become their own documents,
and the SubmittingPatches could just contain the bare essentials.

(The file itself could also be renamed to SubmittingChanges eventually,
as the interface to the submitgit app allows you to push commits and
then transfer these to the mailing list. So while there are still patches
on the receiving end, the last contact with the change was done via
git commit/push hopefully. I dunno.)
