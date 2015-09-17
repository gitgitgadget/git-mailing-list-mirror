From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 00/10] fetch submodules in parallel and a preview on
 parallel "submodule update"
Date: Thu, 17 Sep 2015 10:06:40 -0700
Message-ID: <CA+P7+xoE9OfSbyuFL-8WtditdnxHatF-fUSXDaU3na=LJHeV=g@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcceI-0007WA-SL
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbbIQRHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:07:00 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33166 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbIQRHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:07:00 -0400
Received: by iofh134 with SMTP id h134so29219415iof.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gGZpSXyru01uvOQiw3QjxJg9Fhv4kr2nB8T3RMkxb6E=;
        b=rI6y8UKRXrw3vhqFnUziAu4/aA4oXgAzjj10Ro64dHLqEapuxEOwRR4n2SZjkF3RUB
         2kLho6ODfCcu3WP8gDdLfk6mGEcFj/eTQN3Od4zOLg2mWV4gLQCXcoibNpU21oAvHp4l
         aPK7SUiGqTBub/1Vol/ih0Qk9uw3TCAlSy/AplqUZXbWRq7Zuhf7hkV+quKoqkPCdNrz
         ma1XmplNCaS9CAXmMl3y9iVeVJdHtsR8HtnGatRq+i4JgR+1uuWHeTWd9nKpy6iVIya6
         Yzgw2qj3UbcF5gZAL49jodczmGoVIA5GVZeaU3VgUAh7aSoJgxWpw46rcY1OLvhd22Ci
         /WKw==
X-Received: by 10.107.130.220 with SMTP id m89mr8080933ioi.146.1442509619429;
 Thu, 17 Sep 2015 10:06:59 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 17 Sep 2015 10:06:40 -0700 (PDT)
In-Reply-To: <1442453948-9885-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278143>

On Wed, Sep 16, 2015 at 6:38 PM, Stefan Beller <sbeller@google.com> wrote:
> It took me a while to get the idea how to realize parallelism with the
> parallel run command structure now as opposed to the thread pool I proposed
> earlier, but I think it will be straightforward from here.
>

Yea at least from a cursory review this seems significantly simpler.
I'm still trying to give a better deep dive of the code, so hopefully
I will have some more thoughts soon.

Regards,
Jake
