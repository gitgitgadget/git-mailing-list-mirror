From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 8 May 2013 13:09:03 +0530
Message-ID: <CALkWK0ktoQg5pd-tSiP=wn-3JGv-N7OHK_FkNjPx5HycdjBsKw@mail.gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com> <1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 09:39:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZyya-0005fT-MH
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 09:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab3EHHjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 03:39:44 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:51864 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3EHHjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 03:39:43 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so2612510iee.41
        for <git@vger.kernel.org>; Wed, 08 May 2013 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YF/USl6r38idW3TTM/8B1MrXMEOq22Jg3gNuYhSkbjs=;
        b=pJJqIgU0TfmWuD7nPZreqc9VRZaqwoUmxQKc8Hx8YYWjzvSEuJfw0az4hlCbhqtUl0
         enri0GMpyXvD8NhDhv2ZWI1yvCyXzahOhLmXtbdMTle5wa53Asrr9k1JkT2ROE4gotLk
         6RYlnr9nkK4M7Le7mMZmJAlwgzuTue6s6MO3dCjgxr3PtSuDZosdaVCczJQ42CnjSF1U
         UV6UEfh6UGT/2moFx5Va5N5ON8/M2Ir2Pt65xNGBT2mGTUN5yk9fJf4oFm8lAaw53y+9
         yG3n0g8HU2DKs5OFNYipNlTf6RC1cmMf/klW0Qgxnyt76kWvRF0b/7OJWnrxS3AIJoU8
         wYHw==
X-Received: by 10.50.3.38 with SMTP id 6mr2066347igz.44.1367998783588; Wed, 08
 May 2013 00:39:43 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 8 May 2013 00:39:03 -0700 (PDT)
In-Reply-To: <1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223649>

Felipe Contreras wrote:
> ---
>  sha1_name.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)

How has this changed since my eyeballing of the previous version?  An
inter-diff would be nice: having spent a significant amount of time
looking at this area, I can confirm that the patch is Correct.
