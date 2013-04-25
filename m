From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 13:36:20 +0530
Message-ID: <CALkWK0=Mt_ko=GZouoe-XfrD4ny94dbWn0eMMZH7pSYF2MYP6g@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <877gjrpsk4.fsf@hexa.v.cablecom.net> <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
 <87li87awwc.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 10:07:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVHD2-0007Bm-9D
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 10:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab3DYIHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 04:07:06 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:32897 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416Ab3DYIHB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 04:07:01 -0400
Received: by mail-ia0-f182.google.com with SMTP id w33so121201iag.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NVPikENnefK4fV44/KorUYS2OxJuEiTPlQ9dyn+zwhY=;
        b=Uj/vVXjp29IkhOptfdlSh3HSUOq6JxkuUNxta5IyXS/HFGfB+BnWzskKCniq1563xR
         F8W59nh9C4d9TTpbqD3sAVxTd+a0M4yv3Cp9v5qkWrVoSE5pdTGTAlAB764XjnsKTj2V
         nKrWIUVtYghy8F9rPtkQ5PK2o7UCIDTAOf1rc/ppOhf1MnTACbNqy/W1SGStW00iIQdb
         qSzcjVfGYKAB9iPQWdPsZgd1dAGntaeKvLT1A2DjD9M9uajBebVloMHATdYW4V2Uemgr
         4fIvltyKLz28wyp2u4NgS1Min30rHl1oK+rWq4I9PhoZ19vmmYDsdQDxRWcDlesx9HKu
         Fwbg==
X-Received: by 10.50.57.200 with SMTP id k8mr30696341igq.44.1366877220947;
 Thu, 25 Apr 2013 01:07:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 01:06:20 -0700 (PDT)
In-Reply-To: <87li87awwc.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222353>

Thomas Rast wrote:
> I already hate half of the existing syntax, and I cannot remember using
> ^! (except while investigating what 'git diff C^!' does and why not),
> ^@, @{-N} (only the related 'git checkout -'), @{date} and @{relative},
> ^{}, :/foo, and ^{/foo}, *at all*.

I'm actually totally in love with the existing syntax (with the
possible exception of :/).  I think it's extremely terse and
expressive.  People who don't care about such flexibility and power
can stick to using ~ and ^.  Enabling other users with additional
syntax doesn't harm them in any way.

> ^{/foo} is the same as :/foo, except it properly groups.

No, not at all.  First of all, ^{/foo} is invalid: you need to specify
a ref to dig through, like HEAD^{/foo}.  OTOH, :/foo returns a match
from any ref.
