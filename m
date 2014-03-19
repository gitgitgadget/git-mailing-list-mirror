From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] use starts_with() instead of !memcmp()
Date: Wed, 19 Mar 2014 00:13:13 -0400
Message-ID: <CAPig+cTWV0PWOh88u+rbMPvnn3O+OhTJATEtXXi4oLKUN25Ezw@mail.gmail.com>
References: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 05:13:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ7si-0000j6-7l
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 05:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbaCSENO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 00:13:14 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:40732 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaCSENN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 00:13:13 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so21800533ykq.7
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=O7HlXJ9zSD3eA4HnRoDZiyiaanMTlfkbD04RSUQWoSs=;
        b=sPmvPrYeinmPaP7xePLNupiLEb6qTwHQE0/jcAdW4IC3E2jkeHKTuJ9HYiXSpV0Ypy
         Ljb8ZmoCqtkofxNHFd8N3MC9Tx8tR2TgGlsK02+xrlEt+EMF1oO7cvUXJXMDTDycOlC8
         x1BMdrfDfIlevAfvNUdX0B/lo+YsfmjF8t7cih2WqFCRYmndnU2jXoIin5A3GbNVarqi
         KuGkcIVcCTUKPhdGI2U4oWHusA15Byjz2quoQrO56y0HVaBX+N9swKrlgljNDB4QawMo
         YN+cQ2F7nqPnYgCp0jz6T+qT+2VSmvqvOfwVYr2AIPCfXw1wIMBUMkHgM8Xmtob94iXs
         eBtg==
X-Received: by 10.236.46.5 with SMTP id q5mr23223632yhb.21.1395202393402; Tue,
 18 Mar 2014 21:13:13 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 21:13:13 -0700 (PDT)
In-Reply-To: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
X-Google-Sender-Auth: 3cqNHvhZc-dfohn6yJRdZ7JBOXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244410>

On Tue, Mar 18, 2014 at 9:18 PM, Quint Guvernator
<quintus.public@gmail.com> wrote:
> Another version, this time very in line with the review and commentary of
> Junio, Eric, and Michael.  This version boasts a revamped commit message and
> fewer but surer hunks changed.

Explaining what changed in this version is indeed a courtesy to
reviewers. Thanks.

For bonus points, provide a link to the previous attempt, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244292

> Thanks again for the guidance.
>
> Quint Guvernator (1):
>   use starts_with() instead of !memcmp()
>
>  builtin/apply.c        |  4 ++--
>  builtin/for-each-ref.c |  2 +-
>  builtin/mktag.c        |  2 +-
>  builtin/patch-id.c     | 10 +++++-----
>  connect.c              |  4 ++--
>  imap-send.c            |  6 +++---
>  remote.c               |  2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)
>
> --
> 1.9.0
