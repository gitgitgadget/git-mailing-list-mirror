From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Fri, 21 Jun 2013 12:16:49 +0530
Message-ID: <CALkWK0ksteLBcRcn_R5JP4zsW57SXdi1Qk5DMPqheHrabfBLog@mail.gmail.com>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
 <20130620133422.GA18200@sigill.intra.peff.net> <CALkWK0k8-go979S9sMytBpqs_C9Jm6q6thqwHa4-GX-e5Czx=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 08:47:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upv8A-0008Qo-9a
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 08:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab3FUGra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 02:47:30 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44433 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab3FUGra (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 02:47:30 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so18822688iea.11
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 23:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gSJx2ZzK4J+bjplHk9k2fHroWnOf+ZHEJB46MJvIPhQ=;
        b=pQBRFhLmTPuNN/8kaGn2f5xxQraFbcGDJYRQolz3uAH55KFC8dHPCmD5yT7wOd/19L
         zX14MZ9izJmL/67nb3tdbmBRExQTlzaii2wivvT2GG8ASoR6zfzRigcfSgYhC16Bdvi1
         KHMISO2uMZFtvdh14A7cJ/E47ENbNDDu0WwfKBZUKhgz8eTLPG8bOitVoe0ZY2mR0gi4
         hWabGFcxUgPVqRqDFQvhBRe8fybvQSnG3f9HxGmhNS7fwK2YZA08WKWujs76wuiamYoF
         JI4ogd/JRZ6TL9feeiottqOw+FB1K3T/3TrXqg8QlaDYv6DyBwBaMnO+Ot2ic5t0SNGJ
         1Z2A==
X-Received: by 10.43.88.3 with SMTP id ay3mr1801066icc.61.1371797249697; Thu,
 20 Jun 2013 23:47:29 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 23:46:49 -0700 (PDT)
In-Reply-To: <CALkWK0k8-go979S9sMytBpqs_C9Jm6q6thqwHa4-GX-e5Czx=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228580>

Ramkumar Ramachandra wrote:
> diff --git a/transport-helper.c b/transport-helper.c
> index 06c08a1..db9bd18 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c

Oh, and we have to remove test 23 - "proper failure checks for
pushing" from t5801-remote-helpers.sh.
