From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: git-archive doesn't support --date= option for %ad & %cd format:<string>'s
Date: Thu, 9 Oct 2014 14:30:08 -0500
Message-ID: <CAMsgyKZWiPwGLEx=_s6UYMmMzEj-gFWngKgudQhjge2v2avfeg@mail.gmail.com>
References: <CAMsgyKaHoZtAidWKD_YTggt_Xo0J7krFKHr2eFeg3XJ6H0bBXQ@mail.gmail.com>
	<20141009192428.GB415@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 21:30:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJQD-0005PH-CH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbaJITaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 15:30:14 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:62528 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbaJITaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:30:10 -0400
Received: by mail-oi0-f42.google.com with SMTP id a141so4327505oig.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2MtkrLU9nE/bbSJwO15oZK5JV55eFPOEklrcuki2X2w=;
        b=uqtMQg9cSilV7uS8OovQqmxDf9gWfMzydorCrzLCZeTWtd8NXcUbPQau4BSW1FX4BE
         i7z7gieU23+q+tNxO6ix4f3hH3wLEZHXj0Kjej3O5yMK4yAJ6fGBf4xoM/OQFyw/Ml13
         7e5IHPpBdUvGa49oJypD6GYwqLgk/z891PwtCoA90Yv3Ba+lZOntLf+2Kggs95rbSnj9
         s9yYhfGt6idHEC1cGB5mfJsBgdnDm4Ek0u90msTIpL+xT1CywfLpvB2o8qS8gqoBo6aO
         rrZ+/Vh68gI2XM1AXyUpxPMiUpaPwIMvFySyDpY6H3Y1q+u9ysNpMy9QjChvCN56gn40
         x/Fg==
X-Received: by 10.60.102.100 with SMTP id fn4mr234590oeb.30.1412883008532;
 Thu, 09 Oct 2014 12:30:08 -0700 (PDT)
Received: by 10.76.33.68 with HTTP; Thu, 9 Oct 2014 12:30:08 -0700 (PDT)
In-Reply-To: <20141009192428.GB415@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I don't see a big problem with that. But I wonder if we would do better
> to introduce arbitrary strftime-like formatting, so we do not have to
> keep adding new formats.

My thoughts exactly...

This list seems to be a prove-yourself-with-patches sorta place. If I
can find the time, I'll try attacking this also in some manner.

Thanks again,

Derek
