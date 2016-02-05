From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Clarification on the git+ssh and ssh+git schemes
Date: Fri, 5 Feb 2016 11:36:25 -0800
Message-ID: <CA+55aFyWqK0bu2V1SYagrYCBGpj0=2orobK2vT-KRkqpq=kgtw@mail.gmail.com>
References: <62DF0D5B-83DF-465D-9786-A4E7DA97F2BA@dwim.me>
	<20160205193027.GC7245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:36:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmBD-0006pj-NT
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638AbcBETg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:36:27 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:35902 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbcBETg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:36:26 -0500
Received: by mail-io0-f178.google.com with SMTP id g73so139749388ioe.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jXWUr9E/cSy4hWv2uL+vQk6rZ746ZtMM3QSJu33a3cA=;
        b=vtftUvpyyBh3/0DHZynAX04+oQiM9e47QAZUEjTF3+0nXPWhos+1yEAS9HBgPhJe1W
         CsmitDU9Qc0WN5IatmRH0HV2ZIYw0nHmzj8E7a7sB2PttZehvmEm7ed5rJbw/GU03aB7
         mL4dvTHIROe2wjg4rtK0NGr8pElIPBSUr+/tNq6O/qjl2LU0REneY+ISGg/+FK5orGml
         Z9KX7j5y5+kMziDN84s7CBu8Uu4z+7WkHkFdzB0MLEHHrelf5Kfm/sBvy16z89kfm4N0
         +QgebH8WrOIWQH/BZC3VURXyXMP9x5NBCKtFpdo5dY1c4EDFdAyRPjtLmD4eMwZv299R
         VeSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jXWUr9E/cSy4hWv2uL+vQk6rZ746ZtMM3QSJu33a3cA=;
        b=BJ0v4B/oMl/zDPaFb1PVOA0Up6ZBWb7le28hgMY11e2enTd3AgoReVjBNiat63Gmvm
         LrJvz7K/Ak8APeqhdVbSIoUSD78lSUITVtnZI4o+7I6ziYtVCcRN1ff0Pu3rVfQLKYBW
         CIF6Cwoo/feXu0N4xaM9XWLPcl86E1vNE72I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jXWUr9E/cSy4hWv2uL+vQk6rZ746ZtMM3QSJu33a3cA=;
        b=U41AlUSPkhz9+9xy/5AVidoSuZUgrOiJZf/hgw6Jrs8wf9jof+J9qIAVDRWUWy6oba
         jrvxm1jT6uSMCclSp9VR2hz2+Tq8b7oqkmllcsopWdJV79KeySq8y/+bRx4tpewyHbtl
         N/WpF9NyQfccnQ2X64RWsdZW3L5q6Zmn7vs3wXhSpFXFwY0G64cCbnU2slRgeqUHDFwD
         GDzieH381tqSc4+AzV49sDQq/itBUlbbkVMcyPE5rfvKCmGDfV6z8yHEINsd8FWhm+6v
         NdBgVDKD+tWSRrQ0ReQevuAk243aUi9bQuyNojQcsOL6fNRTI2K4tHioVwlz4PNtkXPc
         WuIg==
X-Gm-Message-State: AG10YOQG934brqTbYRgN3WZM0iHUdhjTn28LQ35l5MaXUfoRAu6EKwglyZJ8gddm3QSfp8KveflVryY78S4JwA==
X-Received: by 10.107.36.5 with SMTP id k5mr19160947iok.137.1454700986093;
 Fri, 05 Feb 2016 11:36:26 -0800 (PST)
Received: by 10.36.93.202 with HTTP; Fri, 5 Feb 2016 11:36:25 -0800 (PST)
In-Reply-To: <20160205193027.GC7245@sigill.intra.peff.net>
X-Google-Sender-Auth: rxGmrZhyHAzvQ2_8kQiSO1IL6mQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285601>

On Fri, Feb 5, 2016 at 11:30 AM, Jeff King <peff@peff.net> wrote:
>
> I suspect they were not really documented because nobody wanted to
> encourage their use. I don't think it would be wrong to document that
> they exist and are deprecated, though.

They exist because some people seemed to think that people shouldn't
use "ssh://" since they thought that only ssh should use that.

Which is obviously bullshit, since by that logic all the other formats
should have that idiotic "git+" format too ("git+https", anybody?). It
doesn't actually help anything, and it only pushes somebodys broken
agenda.

So there was a push for that silly thing by a couple of people, but it
was always wrong. Don't even document it.

Leave it in the source code as an option, and maybe add a comment
about "This is stupid, but we support it for hysterical raisins".

Don't add it to any real documentation. Not even as deprecated. That
just validates it further.

                   Linus
