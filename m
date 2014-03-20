From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Thu, 20 Mar 2014 08:31:07 +0700
Message-ID: <CACsJy8AoyWbeUVjha7iiPPB8BA1k0L4ZQGs2WMb5yZwc0NZr2Q@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com> <20140318045050.GB8240@sigill.intra.peff.net>
 <20140318050727.GA14769@sigill.intra.peff.net> <CACsJy8DZsH_2CpaUUpc5xyunHD42CN24m6Mb+9vsKyaRqJ6q3w@mail.gmail.com>
 <CALbm-EbZSuzynXoUNEifP=Ga_mj6Fp9L9Do-mxhRdMvUEfogig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 02:31:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQRpl-0008FA-6f
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 02:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbaCTBbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 21:31:40 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:52130 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbaCTBbi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 21:31:38 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so165675qaq.22
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 18:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+8xveDgi0vvShKOH+DwmQi6cJgrkWzIE19m4thhMArg=;
        b=nFaisTSyQYdW9uQDgybin2CbmcgMuVRmLk7u5+YNA2uvAN8oUn/5Uxp/z5ehm94xkp
         NDSHZIiXt30vBkQmKk9emoFzMH0309vk48wH/b/b3mSHsNthNIqK60Qg0FjJ+0cYEkr3
         7/OsCfsVx8AO8HeynjU/8Bfi7Zr7Tq+5n+3eNc3sCdSMeUqlOzwqpsVJZW1YwJAFzvw7
         NCU5KHw2vTekRt/+3kUR59HBZHG4QhYNmaMgQaKJXl6S74iLC533H7uo03NTqn119QHw
         0RX7Fe+mImHiONtDGQVon+YG11ZhrSrUkC7UHU/vJKkEXfSP7nTrMMHfiq4tH6ViEf41
         zU2A==
X-Received: by 10.140.97.137 with SMTP id m9mr6315740qge.95.1395279097309;
 Wed, 19 Mar 2014 18:31:37 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Wed, 19 Mar 2014 18:31:07 -0700 (PDT)
In-Reply-To: <CALbm-EbZSuzynXoUNEifP=Ga_mj6Fp9L9Do-mxhRdMvUEfogig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244513>

On Wed, Mar 19, 2014 at 9:14 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
> Maybe we should introduce another option --pack-for-archive
> which features the characteristics of the old --aggressive.
> And the new --aggressive would be a tradeoff between space and
> time?
> Thinking further we could add a couple of options there like
>  --developer-friendly which makes blaming fast
>  --hosting-friendly which makes it most efficient when upstream
>  --archival-friendly (the old --aggressive)
>  --...

--aggressive-mode=<mode> would be a good option to select those
friendly modes instead of a bunch of new options. Well, maby "gc
--mode" is enough, we already have two modes: normal and aggressive
(or although maybe it should be renamed archive).
-- 
Duy
