From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 03:05:20 +0530
Message-ID: <CALkWK0mb_GzmzO86Jayry4AzKDn_JbK12K=OjxkYovcN4pLPCA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com> <515DEE86.3020301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrpg-0003Mj-NZ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764943Ab3DDVgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:36:03 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:48078 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764937Ab3DDVgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:36:02 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so3613347iec.4
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=W5EpjZ49O6QrELrX5tQwx8DcR2SYQFZzmln4xXpOdAc=;
        b=Ic4YBl3fu1X8qEiiZcnm9j7CAF+DCCH+M/FY+6v89k5QKWJg4a2tKnfyEayfXgxhaj
         hkvP//CFQ4A9v7YHRJzi2HaSocfU2P51FBZ7MQXuYIZYT/ER/msTnn2dxOpPDID2zeOE
         gX/T1leU7QQGfWghnsvmPSAwU6OM0ag+Abv7pmigVvvQ272v+eWbvEZ3lXFxLPUJBSFR
         +GfuwFI7F7Kpm7JG5Nrha2vEZUDjCrxedGv7BE7WbuYqo4L989diB4ji6cCw36DDmIT1
         Ermb0j8WJX+Veek65+zwglKsdoBDsslJdby7Zf2jqnSwJHx1o5KMzNSNG5bbEq4G/h93
         +0WA==
X-Received: by 10.50.108.235 with SMTP id hn11mr4578387igb.107.1365111361446;
 Thu, 04 Apr 2013 14:36:01 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 14:35:20 -0700 (PDT)
In-Reply-To: <515DEE86.3020301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220111>

Jens Lehmann wrote:
> Exactly. The flexibility of the .gitmodules file will really help us
> when it comes to the next feature that submodules are going to learn
> after recursive update:

That's like saying that the flexibility of a blob is invaluable: let's
throw out all the other objects, and make do with blobs.  Ofcourse we
make mistakes: we didn't put a generation number in the commit object,
for instance (I'm not arguing about whether it's right or wrong: just
that some people think it's a mistake).

> While starting to grok submodules I was wondering myself if the data
> stored in .gitmodules would better be stored in an extended gitlink
> object, but I learned soon that the scope of the data that has to be
> stored there was not clear at that time (and still isn't). So I'm
> not opposed per se to adding a special object containing all that
> information, but I strongly believe we are not even close to
> considering such a step (and won't be for quite some time and maybe
> never will).

Nonsense.  We will think through it before freezing the format, like
we did with the other objects.
