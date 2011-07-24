From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/18] config: Introduce functions to write non-standard file
Date: Sun, 24 Jul 2011 15:47:00 +0530
Message-ID: <CALkWK0n=d32hf1hvTJvYQPbSA2ZBs6dWAeiAmzx5F57bxHnSDg@mail.gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
 <1311095876-3098-3-git-send-email-artagnon@gmail.com> <20110719195504.GA3957@sigill.intra.peff.net>
 <7vipqy7yiy.fsf@alter.siamese.dyndns.org> <20110719215739.GA8613@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 24 12:17:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkvkn-0002Yc-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 12:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796Ab1GXKRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 06:17:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59939 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab1GXKRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 06:17:21 -0400
Received: by wwe5 with SMTP id 5so3289525wwe.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XnB0sRUY5VXmuun1NcWa9afpg9jVrrHmKooIws9T4Z8=;
        b=GHXjNclXUlMCLMKRK97SHErU5Rpmh+Yyu/jB3s6/1AtxehgX7VWSgouZhHBvakjdDW
         g9GX2/eeRCDO+d9Bf2fepSsPzeArXmwSzKIKgoFV9LW/EKNWYifQU2fvZxrHrDH5mIH5
         czlpul0ayCYEEwnrR25Ibb7aOZUPoMr8ecz3Y=
Received: by 10.216.5.209 with SMTP id 59mr127235wel.66.1311502640084; Sun, 24
 Jul 2011 03:17:20 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Sun, 24 Jul 2011 03:17:00 -0700 (PDT)
In-Reply-To: <20110719215739.GA8613@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177737>

Hi Jeff and others,

Jeff King writes:
> This one is incrementally better than the initial one, but I still think
> it doesn't go far enough.

Thanks for showing me how to do this correctly.
I was waiting for reviews on other patches before re-rolling, but
there don't seem to be any more -- I'll send out a new
"sequencer-stable" series with this change and the "Please, " nit
corrected shortly; it's what I'm basing my post mid-term work on.

-- Ram
