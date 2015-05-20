From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Querying Git for the path to the system config file
Date: Wed, 20 May 2015 23:22:39 +0200
Message-ID: <CAHGBnuOP_pZzZz_jJSG5YzhPp+=TEmy2n83YiH_uA3s56GWt-g@mail.gmail.com>
References: <CAHGBnuPCZCBsBXqGo26E-pcuZXZBxL8GwAehW4UziDpB2V8Npw@mail.gmail.com>
	<20150520210143.GC8421@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 23:23:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBSA-0000k0-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbbETVWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:22:43 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37776 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbbETVWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:22:39 -0400
Received: by igbsb11 with SMTP id sb11so50454277igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TQoCr7A/q+jH8/hC+D6iu8FbPNRvz44O1UBWVK2Vvz0=;
        b=dddME8EXIC/uEUEEWLnpxsbYMQQFd2cKTfPeSpQZ0eNaCux/lgsSLMbddCOnYR2Kal
         aokIUlW4Y+LBaKe1mZqqisYxfbaxwkrU61c7Mj4uNed2a3tq7gye37vOJUjxuc9Z8/qQ
         KSVKLr6YFpjb7hI3q2rgJn/RcW+ZpLeT6tcHi1hhhI5NMPDbqFS7bQzdL0Hy9qlUmhM9
         BmkbgsSY/zs+xyx2LXl5c3+a73sfqLs15E6pxlewf6xIsrlvan2rOwKEg3hFEBwbAzZd
         iyHH5462xxjXa5HI1tfdfuxQgxIlT5x6tUMTBCPJ89M8e0ckJbhNeN4G3UIRRnnNbn1+
         Dn+w==
X-Received: by 10.43.171.202 with SMTP id nv10mr48501925icc.30.1432156959271;
 Wed, 20 May 2015 14:22:39 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 14:22:39 -0700 (PDT)
In-Reply-To: <20150520210143.GC8421@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269527>

On Wed, May 20, 2015 at 11:01 PM, Jeff King <peff@peff.net> wrote:

> Of course adding a new option probably won't help you, as it will take
> some time before it can be used reliably. I think the hack you came up
> with is pretty reasonable in the meantime.

Right, so I'll keep using that hack, thanks!

-- 
Sebastian Schuberth
