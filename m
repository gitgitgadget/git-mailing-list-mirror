From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Tue, 4 Jun 2013 09:19:50 +0530
Message-ID: <CALkWK0nMWPvVBXEyM5TwCC+0LGvLGbUVXPBhewY8X4==nHELSQ@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-7-git-send-email-artagnon@gmail.com> <7vehcjgkuq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 05:50:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjiGk-0005lR-6a
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 05:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab3FDDuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 23:50:32 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46606 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756130Ab3FDDub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 23:50:31 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so9658488iet.8
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 20:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Or4jhZHw8f64XeDVqj2xMrOhLkV2hr2lgHOIgSgSQ/M=;
        b=mntmCGvCBw5TlN2uVc1GEAuytxgTahhJpwsxme9F43hVY8VuLFw01hxvts5u4SphDR
         f0FoZ8Gz/GkJUtZbIJMr7OYIb4iNwpnBBwLls+YGT7KY/Wtml1NpIqNSklN3ANYylt2Q
         7X7ZZld7m4RcCGC77FNB4ziPvKnf0Tbx3A7jtvkpZEcG7m1TR20pjheTjFRglm+EcEvE
         4JMi1yQZPJnHYI3W5EtUTsdnEDH8e/HxHiJQzXl3l86aW9d42HdiUwnUL7IePNmasDQn
         SGgaP58TVJRho/AyUj/u/rORYitZ9JzREWQA0vXdIPRK0D/YZT+H+C9I6KWcSWavsuC0
         f21Q==
X-Received: by 10.50.32.8 with SMTP id e8mr553447igi.89.1370317830828; Mon, 03
 Jun 2013 20:50:30 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Mon, 3 Jun 2013 20:49:50 -0700 (PDT)
In-Reply-To: <7vehcjgkuq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226309>

Junio C Hamano wrote:
> I think this is the same as 5/6 and better explained in a single
> patch, as the rationale is the same: these commands can all take the
> usual revs and then paths, so using misnamed complete_FILE helper is
> wrong.
>
> Mind if I squashed them together?

I'm okay with what you've queued in pu (sans some points raised by
SZEDER; looking into that), but you can squash them together if you
like.
