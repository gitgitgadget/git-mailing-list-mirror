From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] Documentation/git-diff.txt improvements
Date: Thu, 25 Apr 2013 16:55:10 +0530
Message-ID: <CALkWK0nVZHwSMS_gtisiAguNhAMnDpdWmAtz_OgzP93YZtYfHQ@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 13:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKJL-00012u-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198Ab3DYLZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:25:52 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:51289 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab3DYLZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:25:51 -0400
Received: by mail-ia0-f181.google.com with SMTP id k38so2627658iah.12
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xEiA/jIHoSeEzWEr1NeffvE/aatSaaXCtKPDdmVtaZ4=;
        b=zd5fdFRUU/KMNU/epxochi/LGVvNEbhQomDs9f/0LRMP+33RIs4N4mgulzX6dCIi8K
         OBnOu8l9xe4Ekxf9beAXm2kfRSzDNwninZdKFiUBnEWZReKAGKfYwXvhRe6WwiD4wSxH
         sxNyuzevUiivP/SFfP17wq24+fWiZSK6jODps3s6Vvq15ZyD++R5WORj2rKmjPOVPgC7
         UbAKYD9yxaBCxRzd5LOFTSUGbQL0kMfWr1krDzPVoY8kXxOwFd8FhY5kLJEokAoTtp8n
         9NjK27Es32TqH9JCFPfuX6vrNtJxDUjPdHgCQTMC+LdaPA6F53MAUjhLcBSLdx1eAQno
         nFgA==
X-Received: by 10.50.55.73 with SMTP id q9mr25557441igp.44.1366889150501; Thu,
 25 Apr 2013 04:25:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 04:25:10 -0700 (PDT)
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222378>

So, I decided to drop everything and just submit the first two parts.
Until we can decide what to do about the '<commit>..<commit>' and
'<commit>...<commit>' forms (new rev spec? overload existing rev spec
to change the meaning? deprecate without a viable alternative?), let's
leave them as it is.

Nothing to resubmit.  Junio: can you just queue the first two parts?

Thanks.

Ramkumar Ramachandra (2):
  git-diff.txt: reorder the <commit> <commit> form
  git-diff.txt: strip the leading "--" from options template

 Documentation/git-diff.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)
