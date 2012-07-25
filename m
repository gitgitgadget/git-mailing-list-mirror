From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Wed, 25 Jul 2012 07:10:51 -0400
Message-ID: <CAM9Z-nk97tkE4==Kx8z-1gwKoeUqj087wE2X1q=fUVuK+ckqpA@mail.gmail.com>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
	<20120703063511.GA16679@sigill.intra.peff.net>
	<CAGxub4-9E0W8ZgsPHeTyUyxmPD80LUd7NjSezg5Zt2-nZPBMJA@mail.gmail.com>
	<20120704064450.GA24807@sigill.intra.peff.net>
	<7v394py7r2.fsf@alter.siamese.dyndns.org>
	<20120718072753.GC12942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Katsuyama Takeharu <gkatsu.ne@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 25 13:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StzUh-0002oC-T8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 13:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756524Ab2GYLKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 07:10:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41943 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab2GYLKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 07:10:53 -0400
Received: by bkwj10 with SMTP id j10so419225bkw.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5OFWL9lHnF1i4bvAWXrM/2riBVUJPhKR0upc200jVSI=;
        b=xW25voYh0Sn1f8+TfDf/MgAgOH78i2MYHAhPumOIwDS3fR9pZlvw8Uzi0n0ey2yqED
         YSCOgqc0r1gVFrtAwFyamGLh6Pp2tgDFWJn7ZHbR/t55WTIJu9m+g3TBZNzDIbb74WC/
         vmylvEc5UsG7spBsA1gXlRhZlKSjkKgzHlD8eePFi9MnnvpTcCrIDAbQnRXX+cjRdfvN
         RtOylhX6xOtWCpKMolj+hoaYYm7s0sqAG8jbKI1i7Hmg5or+WEK5N1F8Gx36xbW2iGKe
         kKJvcRKia+UaGbdhFBUYghIPv4ywgYQWxUvKLhMG2ffZWlxc+DUta9+7jS03R9a+ODVR
         69vw==
Received: by 10.204.128.202 with SMTP id l10mr11491507bks.127.1343214651994;
 Wed, 25 Jul 2012 04:10:51 -0700 (PDT)
Received: by 10.204.27.24 with HTTP; Wed, 25 Jul 2012 04:10:51 -0700 (PDT)
In-Reply-To: <20120718072753.GC12942@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202147>

On Wed, Jul 18, 2012 at 3:27 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 17, 2012 at 10:10:25PM -0700, Junio C Hamano wrote:
>
>> Ping on a seemingly stalled thread.

> If I did not simply dream it, can you re-post the latest patch you
> sent?
>
> -Peff

...And I thought dreaming I was trapped in a DOS prompt was bad.
Dreaming in patches? OUCH!

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
