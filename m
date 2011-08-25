From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] replace: List replacement along with the object
Date: Thu, 25 Aug 2011 18:29:45 +0200
Message-ID: <CAP8UFD2Cr4UQjWa=pRvcqgyX_Ed+qjts=TujWRdyk4dUZsd_7Q@mail.gmail.com>
References: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 18:30:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwcoY-0007Yd-Ja
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 18:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab1HYQ3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 12:29:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52778 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab1HYQ3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 12:29:46 -0400
Received: by gwaa12 with SMTP id a12so1895720gwa.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iRPneV7Frx1a3XHoiDh/HRX28icagOgMxJmcE6VzfCM=;
        b=Nb27T7oKP4FZfo5f7jLspeXV8W2a5uA8N5go47x06AD9G2umrp2MjzP4FMkzIuEla6
         p8qkcOtsLxFFDVQ42BiBQj3ueqTiORamDfApcRSwe/HlW9Phjr1y8yYxemzZ+VwEK/fm
         65tcnVMXUUGE9hIu+x4sc4YiyFw/JbMFf4N04=
Received: by 10.236.191.198 with SMTP id g46mr42291053yhn.41.1314289785996;
 Thu, 25 Aug 2011 09:29:45 -0700 (PDT)
Received: by 10.146.83.4 with HTTP; Thu, 25 Aug 2011 09:29:45 -0700 (PDT)
In-Reply-To: <bae5a8f7d30417864d972390f9f6b4470cf4e5bf.1314283118.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180089>

On Thu, Aug 25, 2011 at 4:39 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The documentation could be misunderstood as if "git replace -l" lists
> the replacements of the specified objects. Currently, it lists the
> replaced objects.

You could just change the documentation to make it more explicit.

> Change the output to the form "<object> <replacement>" so that there is
> an easy way to find the replacement, besides the more difficult to find
> git show-ref $(git replace -l).

I shamelessly copied the "-l <pattern>" feature and the documentation
from "git tag". If you just change the output of "git replace -l" it
will make the UI inconsistent between both commands.

Maybe you could add a "-L <pattern>" feature to "git replace", "git
tag" and "git branch" that would output "<ref name> <ref content>"?

Thanks,
Christian.
