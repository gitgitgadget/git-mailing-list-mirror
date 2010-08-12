From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Bug in alternates
Date: Wed, 11 Aug 2010 17:50:11 -0700
Message-ID: <4C634543.5020301@gmail.com>
References: <201008120826.53902.michael@frog.wheelycreek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Geddes <michael@frog.wheelycreek.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 02:50:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjLzy-0007B5-N9
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 02:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758680Ab0HLAuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 20:50:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37779 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254Ab0HLAuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 20:50:14 -0400
Received: by pwi7 with SMTP id 7so127388pwi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=KNqvncSyViSsO+8Bx3H93npFxA2Y9bYPHpkDMib4aPE=;
        b=kowKUEYIA9Xj2e6/VX6WHHTX1nNfIRibr3zDJxh4pBp+K5+lMDLMrl4dDjXg2wD/lm
         /ELB9f/6D5Is0tjxE0KUEm4WXsFvYyj63S+vDEbmlUc6bZwJLPLXx2Uara4Hjt+8G4ze
         OEsYTdlAZHaV02TIaIqfijiNPbkYYI4cxxidU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=krb4X0XSeSrXpyMHaso7D3tqxG9pjzn2umQwvzeIB9jkFtM1EZSxLCSLXX43wYQS8E
         R8RRJK2rk7iBUEW6UJbk3waiUjErd99vWfDEho32g7ktkuks0LqqmmZJFcXqQmSVkq5h
         +9mFt9Eq2HkE1eEkPxYKSEv92UYtO7+LP28ak=
Received: by 10.114.61.1 with SMTP id j1mr6130894waa.135.1281574213519;
        Wed, 11 Aug 2010 17:50:13 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id g4sm1212252wae.2.2010.08.11.17.50.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 17:50:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <201008120826.53902.michael@frog.wheelycreek.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153321>

On 11/08/10 17:26, Michael Geddes wrote:
> If you're not following the story, the Foo repo had itself as an alternate.
>

I had done a little messing with putting a UI around alternates a while
back (if I ever find those elusive round tuits I'll pick it up again).
There are also more complicated cases where you could end-up recursively
including yourself, I managed to do that at least once in my messing
around.

It shouldn't be too hard to add some safety checks to git gc or git
repack but they should take the possibility of recursive alternates into
account.

> Include me in replies please- I'm not on the list.
>

That's the norm around here.
