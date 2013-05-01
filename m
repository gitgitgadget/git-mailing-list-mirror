From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 03:31:13 +0530
Message-ID: <CALkWK0nwzCVTjOufkdboGO-09MqBKFnYPJq_KFxKpVD4QYjo-Q@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CALkWK0nL+UvjsUKh6v4x_MaWJmsU6Uh_gh82iE7UT0UE-ZMt0g@mail.gmail.com> <20130501211613.GA15392@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 02 00:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXf66-0001HQ-L9
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477Ab3EAWBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:01:55 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57714 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab3EAWBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:01:54 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so2427428iee.6
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Lbmz4V0Aon6+/fxQLE9xbzTVdOpfh2a0zWw7YVXzI3s=;
        b=l3woAzGazzAVwBlkCVnleON/9rxqKYvRMA5Kqe3diIozNKV2VM5p1nDlRut6cN4X/B
         MPoqVrzh+31d782Luk4wVtefdlo2tBC+RsLcqvyBTkiiWibHUSNBpkK95lboHgtFwXA9
         XdR0PUxHbwDGztzWY3Ul5Hplj73KYXlbv4hVAAFBQM2g8QW+6PZvYTqGb3DBzIyhkBlO
         XzK71Jogee0QsKjC0qWeIdadBAdq5/Acv/G0/LIKJQ8wnLZDe9jvScN59onCjDzsyKkc
         TVHSdt21q/Upkdv5uGUmONpM+3Rryd92ycwfelT1Y9f4uqXZqZMOGKlCgajDJCaSfmyI
         a5cA==
X-Received: by 10.50.72.65 with SMTP id b1mr2606292igv.63.1367445713572; Wed,
 01 May 2013 15:01:53 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 15:01:13 -0700 (PDT)
In-Reply-To: <20130501211613.GA15392@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223151>

Jeff King wrote:
> The difference is that HEAD@{} refers to HEAD's reflog, but @{} refers
> to the reflog of the branch pointed to by HEAD.

Ah, I missed this.  Thanks for the testcase.  My patch changes this
behavior, and I'm looking into the problem.
