From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 08/13] ref-filter: add support to sort by version
Date: Mon, 17 Aug 2015 00:53:56 -0400
Message-ID: <CAPig+cRs3EbO1HmHmfNTaXXiiDjyqgeiUqv2_XGJL1=Ogb6a2g@mail.gmail.com>
References: <1439661643-16094-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 06:54:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRCQs-00027K-5o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 06:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbbHQEx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 00:53:58 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32833 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbHQEx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 00:53:57 -0400
Received: by ykll84 with SMTP id l84so52957770ykl.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 21:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OEoF1+JGSvhMaoOzg9kF5kP0fGKPkMkBvfAwy8ziVj4=;
        b=PeUeN7L27BOpocAJVaRd746o/9OT4kyKmlTBgYUsQ6hVLvDK1Pdk7ZLl/ntqr1fhiV
         dL7vd0ufmcSIV+XmWix1Nyd84FfV4PIHtjAmnw4vQVGwBBXFCTZRYnmGU/9ItCwTjlxh
         NPLqe7gFLImU0iKaLXfJNyiO6v5xqaQ6W9+ZEeUaTFimfQoH9/RRGw2LqFsYSncSPhVk
         HBJ0DuRmmwbRRO0EEv6dp/fIu8jAMAWvkfR3fHbNVHhZUo/YgeKzue6DxsM2j3oz8TCD
         8PhVXf4tJpWCoWAR6BHsBUtlJ5st8GOCFSiPwkyue4V8PgmkYY3AyXN0bEBcGDl/S71n
         BNuA==
X-Received: by 10.170.97.9 with SMTP id o9mr57396163yka.84.1439787236515; Sun,
 16 Aug 2015 21:53:56 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 21:53:56 -0700 (PDT)
In-Reply-To: <1439661643-16094-9-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: gDNDVw13-n5hbgt5oChO0BXYXsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276030>

On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support to sort by version using the "v:refname" and
> "version:refname" option. This is achieved by using the 'versioncmp()'
> function as the comparing function for qsort.
>
> This option is included to support sorting by versions in `git tag -l`
> which will eventaully be ported to use ref-filter APIs.

s/eventaully/eventually/

> Add documentation and tests for the same.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
