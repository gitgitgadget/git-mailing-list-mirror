From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: How do gmail users try out patches from this list?
Date: Wed, 12 Aug 2009 09:43:37 +0100
Message-ID: <e2b179460908120143j5b0eb964s666dd0d59c850db3@mail.gmail.com>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
	 <20090811221408.GC12956@vidovic>
	 <200908111917.19267.wjl@icecavern.net>
	 <4A827BF3.8080208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Wesley J. Landaker" <wjl@icecavern.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 10:43:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb9Qz-0003nN-20
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 10:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZHLInj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 04:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbZHLIni
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 04:43:38 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:53405 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbZHLIni (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 04:43:38 -0400
Received: by fxm28 with SMTP id 28so1989625fxm.17
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DLFN7Is1XOW1tcZY0DjoBKLK49GFaZPZA3CqvkV1P7E=;
        b=r78HOjl+9iCuYTAAnm32ycYUE5iFI8jrYCrP3Tw80WU3pEWrDGJ9EOSDIkSrX6CZg/
         DIxzZ1fm+Hlw6k1pUYI9w6Ogra4O9IqGD+4t36+rFO/8JBY9vBfp/gZqbvU2vR+OJlBG
         3vTSaguLzJNkAAk4kMwnKSNTfQ8HykbmQ6h4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=diKUAedLs2hPp72l4U0GmgUZguzIMhNTomU2QgHAgv70jxCiMN/k2PB60gv3w5tmu+
         5qkw3ExeYesUYqZVqUuLTBWOIj/2PL9tMFX4DRlGbZczeFqCxjjgn/zRwQWXh7sFKrcY
         asLkHyzbzxDVPzzGwPpP6ebpBAuJ2XTIxPzlo=
Received: by 10.223.109.200 with SMTP id k8mr410587fap.42.1250066617804; Wed, 
	12 Aug 2009 01:43:37 -0700 (PDT)
In-Reply-To: <4A827BF3.8080208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125683>

2009/8/11  <skillzero@gmail.com>:
> Sorry if this is dumb question, but I didn't see any good info in my searches.
>
> How do gmail users normally apply patches that come through the list?
> Do you just manually copy and paste the email to patch files and use
> git apply? Do you use a tool to export to mbox files and use git am?
>
> I've been just doing it manually via copy and paste, but it's kinda tedious.

Yep, show original, copy and paste and git apply. Personally I would
prefer to fetch changes using, oh, I don't know, some kind of dvcs
tool... 8-) It means I don't tend to build and test many patch series
until they get merged.

It's a pity there's a patchwork server for many kernel.org projects,
but not for the git mailing list 8-(

http://patchwork.kernel.org/

http://patchwork.kernel.org/help/pwclient/

http://gitster.livejournal.com/18696.html
