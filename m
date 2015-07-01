From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 31/44] builtin-am: implement -S/--gpg-sign, commit.gpgsign
Date: Wed, 1 Jul 2015 16:01:32 +0800
Message-ID: <CACRoPnQBhCObCaksfpmN9zcDxp676SkxEJqjcaKi1B3JRMeXVw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-32-git-send-email-pyokagan@gmail.com>
	<CAGZ79kZSNXRfgngA6QsVwYiM=4nqk9rkuHxMOD-sPcaHKOPSkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:01:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZACxe-0003oY-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 10:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbbGAIBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 04:01:35 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34198 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbGAIBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 04:01:33 -0400
Received: by lbnk3 with SMTP id k3so7847666lbn.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PQHMoZMb+mTW2arxAshkYZhLjplbFM7yYDNw8ElCJpM=;
        b=qBOHjMrbAA3UUKANlpPUkFi565GiBMr7ZEG8AuVE/SoVJDuvSklp1xg1OcpiMfXrWD
         rPKyxTEKB2GCHjJfIFN5cRV5qbLragm/Xy8d7TplwVeunFpwDcMgwp335rI//vprRNaY
         xZ/LbG13Z2vvSsTvZEA9nftjjLaWhHDvas3esL8ROab9hUEb2cSYEdT1tJe7PQjKTKlV
         uuo6zYFHGR3Is+bC0K6ykIM9T8lcS6eyWGrsU3itSQNpe1wRNWdokGP51i1Hil6IYbLo
         U3nwQrLvgfE6Kvc2nW7r+pFnXpD05L7c8mtYgH8rXVQKt745lGUA5frbX1mSIrGdUiiI
         X0pA==
X-Received: by 10.112.221.172 with SMTP id qf12mr12644814lbc.98.1435737692306;
 Wed, 01 Jul 2015 01:01:32 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 1 Jul 2015 01:01:32 -0700 (PDT)
In-Reply-To: <CAGZ79kZSNXRfgngA6QsVwYiM=4nqk9rkuHxMOD-sPcaHKOPSkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273136>

On Tue, Jun 30, 2015 at 7:51 AM, Stefan Beller <sbeller@google.com> wrote:
> I needed to read this patch a few times as this patch introduces `sign_commit`
> twice. This is mostly a review problem I'd guess as in the code it
> just affects this
> method and you'd see all the code of the method easily compared to hunks sent
> via email. But renaming this variable doesn't hurt.

OK. What variable name do you want? Would "gpgsign" (to match
commit.gpgsign) do?

Regards,
Paul
