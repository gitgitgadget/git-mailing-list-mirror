From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 00:30:08 +0530
Message-ID: <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:00:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4w1-0004l4-QG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832Ab3DXTAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:00:49 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:37765 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756392Ab3DXTAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:00:49 -0400
Received: by mail-ia0-f180.google.com with SMTP id t4so988951iag.11
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=QKKVds+BgUQ+B5XKle6lYatdcD9LDZVMrV/PVRDQAmA=;
        b=BIbL5CeiXmiUV6IlXHNGoGVEvIYO5CC1K96oIOJ/U9kkpdFEQvgQY0be6CqBYTVB1W
         HZk7YYiqZITIR2NaHFMhlNKFTvk7abcz2RrtDKpZFZaGGYZ2V0M8nJAN7a97zyiepeGQ
         kr8eIgPdQAQB0D0YgxyIltHwKXalLTmcabkXcsdqGHXRlbm6AzIdA3Rer3aXKBCjTmz9
         HcYOwvvRwGR9qiMaffG08EzqhiIrDyuCRvT/wcqPkbJJkxTX1JJ+rYGE7YMeR8ITgyle
         PJFyliWm9jQvDEwgb843/Fye6W30d3yJyv5teLUHBUQvEwyvQz0Jp1NY4Mie7/FW6MLE
         eL3g==
X-Received: by 10.50.57.200 with SMTP id k8mr28959271igq.44.1366830048723;
 Wed, 24 Apr 2013 12:00:48 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 12:00:08 -0700 (PDT)
In-Reply-To: <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222296>

Ramkumar Ramachandra wrote:
> I'm also considering making the first
> argument optional (just git log ~rebase.autostash), and defaulting to
> mean [nearest fork point].

Actually both can be optional.  In A~B, A defaults to [nearest fork
point] and B defaults to HEAD.

    git log ~

Isn't it beautiful?
