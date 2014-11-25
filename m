From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3 v2] mailmap: use higher level string list functions
Date: Mon, 24 Nov 2014 21:36:08 -0500
Message-ID: <CAPig+cQ_4A-0LOgXXG5qLeHOev+g8KMq5osKz34AFijGuyRidQ@mail.gmail.com>
References: <xmqq3898w9v4.fsf@gitster.dls.corp.google.com>
	<1416865932-18285-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, julian@quantumfyre.co.uk,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 03:36:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt5zG-0005ab-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 03:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbaKYCgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 21:36:11 -0500
Received: from mail-yh0-f45.google.com ([209.85.213.45]:37462 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaKYCgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 21:36:09 -0500
Received: by mail-yh0-f45.google.com with SMTP id f10so4902521yha.18
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 18:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=k3Wes0qFKlInF1CbuqGYyz8cSbsnUbzE3Tt1GIXpkSc=;
        b=JfuvqOKI1X9DWpgu+mrYpDnPzsmy5hjrsMb3kiLO6AodyMdiAXvDm51xJVDLS2ZoOt
         6f3z08kqEbBOZe2BiTzjebZdS7p5R1W0rKVBSlrFi6ga7pCYflmqjIbqpZbg/nNsEQZf
         FSfoB5epnhgkhsu3ySj4bJ/H4XZc7B1JlN8geCJsKH34meJ9JgejX8QyVYRb/LoJ+WL8
         7FfancIPCqlxwOtD5NfiMClOKj9vM0PbZdItrV+u09PGwwgEjjPTaY7sCDh8CmU7G2pM
         0U716rcOdWae+7gzMxsBEK42eae1fr7gc9XggkwG9xT+MRB+BcPXBUlItYgFP/G1FItb
         8ETg==
X-Received: by 10.236.8.100 with SMTP id 64mr21253869yhq.112.1416882968671;
 Mon, 24 Nov 2014 18:36:08 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Mon, 24 Nov 2014 18:36:08 -0800 (PST)
In-Reply-To: <1416865932-18285-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: XghM2CZhranct-iaZZuMUw4pCxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260183>

On Mon, Nov 24, 2014 at 4:52 PM, Stefan Beller <sbeller@google.com> wrote:
> No functional changes intended. This commit makes user of higher level

s/user/use/

> and better documented functions of the string list API, so the code is
> more understandable.
>
> Note that also the required computational amount should not change
> in principal as we need to look up the item no matter if it is already
> part of the list or not. Once looked up, insertion comes for free.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
