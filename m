From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/4] cache-tree: subdirectory tests
Date: Sun, 6 Jul 2014 04:10:50 -0400
Message-ID: <CAPig+cScqL6qEo8e9QKgDEZT5cxnt8qCrVwpuhiJt-MmcKEuXQ@mail.gmail.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 10:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3hXN-0006dQ-AV
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jul 2014 10:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbaGFIKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 04:10:55 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33771 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbaGFIKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 04:10:52 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so2078576lbv.28
        for <git@vger.kernel.org>; Sun, 06 Jul 2014 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8WnYK3NOfrC+7PHFEBH3Bz6IzCFnBhoYs8G1j6LgbTg=;
        b=metRPLWszKDyslUuDkLOF1QmlnQv8nvlj2JeCGkws/ElpPGzMNVmiG8bvkjPA1tyYP
         4FU6/Jcuh9LKkrFSeSn4XWouU1taEqOSTNrIowOVXRJ4aLYojdTg4pIn4PwRqYhWc7qk
         A8jK0H4Y3YKUq1yyMDyiVHN3KgElQ4B/WaF412k/QvcDk0RFtBScLZv2SKaybqm6EFW4
         3cLH43Fxt9dX/k5vCD3ok+7tdksppNdhrXV3L9Y5WAuhyx8u6TVQ1DGRlL+hldFNFmJc
         qcIT6W+v7GzTxVVKWxBM4eMMGtjuWAuF0jMmmRNF7dq8V7WCGTjlaRZGRkNXgxGoeLJr
         UwBA==
X-Received: by 10.152.2.3 with SMTP id 3mr16965396laq.8.1404634250638; Sun, 06
 Jul 2014 01:10:50 -0700 (PDT)
Received: by 10.114.78.167 with HTTP; Sun, 6 Jul 2014 01:10:50 -0700 (PDT)
In-Reply-To: <1404619619-4774-3-git-send-email-dturner@twitter.com>
X-Google-Sender-Auth: bsxkSsRBVtfcuQLr0JYpDZ6hkCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252931>

On Sun, Jul 6, 2014 at 12:06 AM, David Turner <dturner@twopensource.com> wrote:
> Add tests to confirm that invalidation of subdirectories nether over-

s/nether/neither/

> nor under-invalidates.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
