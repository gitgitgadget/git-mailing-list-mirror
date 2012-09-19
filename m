From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Wed, 19 Sep 2012 22:02:52 +0200
Message-ID: <505A24EC.1000203@gmail.com>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org> <20120917201119.GB24888@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQUD-0003OQ-No
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab2ISUC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:02:57 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41854 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab2ISUC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:02:56 -0400
Received: by bkwj10 with SMTP id j10so756012bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=yOOBtXMhMOWYgPFAS+3OP2MYIPfkAHBNH5nuZz8bwsQ=;
        b=kEczmj4XdxRtR65Zgf16tIC2Xh5vHergqou2Y8zPGTp2R3UI/uTwzGeUGqnKu66Us0
         B3ipOZQqN4xUCn5jzlKKlOyYwndsRzJNHjiM5v21a/K0wQjxplfW8KctnG01RjDkIia0
         6CJt0u6jBj8sAjOn8TepaYsaFoZ+FIf4saTYi5IBquZn5NuOII81mNrVa9/w79+Dm2cO
         4fOBaV9gyj3Im2a/Jx6GHXye2Rhvq36MuqAMSQOBwCf0AYByClGiRaMQgxUiHIhJhLpq
         pKexldD57P4jcU3KH6FL846XdnFILuwjA01ETQtJ9Co9yIdkPx8VghQCSS2amMRaSeL8
         4byA==
Received: by 10.204.157.156 with SMTP id b28mr1809803bkx.27.1348084975030;
        Wed, 19 Sep 2012 13:02:55 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id m9sm2920468bkm.10.2012.09.19.13.02.53
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 13:02:54 -0700 (PDT)
In-Reply-To: <20120917201119.GB24888@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205989>

On 09/17/2012 10:11 PM, Jeff King wrote:
> On Mon, Sep 17, 2012 at 12:50:37PM +0100, Adam Spiers wrote:
> 
>> The end result of these changes is that:
>>
>>   - red is _only_ used for things which have gone unexpectedly wrong:
>>     test failures, unexpected test passes, and failures with the
>>     framework,
>>
>>   - yellow is _only_ used for known breakages, and
>>
>>   - green is _only_ used for things which have gone to plan and
>>     require no further work to be done.
> 
> Sounds reasonable, and I think the new output looks nice. I notice that
> skipped tests are still in green. I wonder if they should be in yellow,
> too.
>
What about blue instead?   This would keep the colouring scheme more
consistent with the one used by prove:
  <http://search.cpan.org/~ovid/Test-Harness/bin/prove>
by autotest:
  <http://www.gnu.org/software/autoconf/manual/autoconf.html#Using-Autotest>
and by the Automake-generated test harness:
  <http://www.gnu.org/software/automake/manual/automake.html#Scripts_002dbased-Testsuites>

Just my 2 cents,
  Stefano
