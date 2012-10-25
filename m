From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Thu, 25 Oct 2012 21:05:48 +0200
Message-ID: <CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 21:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRSkk-0007hO-3L
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 21:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760136Ab2JYTFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 15:05:50 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48309 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760100Ab2JYTFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 15:05:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1381356pad.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HJ8azSwyK3aAvesEUhJ0P8rA2wtCf5LAfRYuEP0Fr+c=;
        b=AWNlDW5JhJexkVUK5femkw5axqFHCG9l7P0W3aJFwCgvZGmYK8V6zSOrTaDAfks7FO
         O4YgiduZkOBTysxWiI5sPCI8wJinuMl8xtIuujwhN6r0UhtRQml/XDP24NE1DRUk/AX8
         AacEgb9ewg5MZ7IxtVIpDL2riDt5iyYQH0gpP2JSXx/x0OsPcDzhdc1S9dqzAZ7Hrp5f
         DvolHnxmd94ZNlzzJMvfRM+UZ5zHJyNyQHdE0fOdbnoer38ahVopN5Ix27pP650ZhT5J
         VnOCMx3Jh9sW5R6Jv5RwtpNnpw6lrGQPFztYXMjC/NlQShjcJSlkxGXw6M9jshavt+3o
         5zTw==
Received: by 10.66.76.98 with SMTP id j2mr55472462paw.65.1351191949030; Thu,
 25 Oct 2012 12:05:49 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Thu, 25 Oct 2012 12:05:48 -0700 (PDT)
In-Reply-To: <CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208416>

Hi Drew,

>
> You specified "-f" (force) and it did exactly what you asked. That is
> fully documented (git help tag).
>

Yes, it is, and I used it to show that there is a need to specify
explicitly the intent to change a tag, that without such an indication
would not be changed.

>Tags have many uses. Some of those uses are harmed when tags change
and some aren't. That's a philosophical argument

I agree, but in this case the computer does not provide any means to
implement the same strategy on tags as it does instead on local
repositories. Why I must force a change on a tag in the local
repository and instead I can change it without any forcing in a remote
one? Are remote repositories less protected than the local ones? I
think that to be consistent, the same strategy should be used on all
repositories, i.e. rejecting changes on tags by default, unless they
are forced.

-Angelo


> --
> -Drew Northup
> --------------------------------------------------------------
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
