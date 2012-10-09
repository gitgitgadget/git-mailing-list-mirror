From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using empty
 peg rev
Date: Tue, 9 Oct 2012 03:19:53 -0700
Message-ID: <20121009101953.GB28120@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
 <50143E34.8090802@pobox.com>
 <20121009084145.GA19784@elie.Belkin>
 <5073F2C0.6000504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:20:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLWv2-0002ad-VO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 12:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab2JIKT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 06:19:58 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35598 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab2JIKT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 06:19:58 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4986911pbb.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DgSSz8GXrWWCHRxXoGJB6RoNHjsQhFR1jDFUoYvPpWE=;
        b=GQWaLxNBTS7qpuXTNq9ytvOl4Gobm2D+Nno7Pa3NZ+jcYiixxZ5mHh1RAs7VDA1TmA
         +36TndcWu2u3vCJKD7wx9yJmvT1eqBxRW3Tpe/VbaJI11/1p5ivSSjSUmHyOEhQvdbgG
         4LeCTx4bvOI5P66dfu9BoqIFiwNQvPUSSDys/NVxP3oqeRK4hDmTU8fYMPtoKAP9qvaQ
         K2HE36pvkT814XKxg1igO4jR1nFnHVHPo18QZuUs+MAP7OlwJINozL5tBRljdo9R7NPl
         J/KfD5ScnNAW5ynMa1p/SZ7VYPUYlgYQJ4bghI+PaKhQaXdpEUtmJTkxuxgAK0UNu0fK
         f5Tg==
Received: by 10.68.135.234 with SMTP id pv10mr61732948pbb.156.1349777997601;
        Tue, 09 Oct 2012 03:19:57 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id o1sm1199151paz.34.2012.10.09.03.19.56
        (version=SSLv3 cipher=OTHER);
        Tue, 09 Oct 2012 03:19:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5073F2C0.6000504@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207316>

Michael J Gruber wrote:
> Jonathan Nieder venit, vidit, dixit 09.10.2012 10:41:

>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Tested with Subversion 1.6.18.
[...]
> I haven't checked other svn versions but this approach looks perfectly
> sensible. It makes us test branch names which can't even be created
> easily with current svn. Does svn really deserve this much attention? ;)

Thanks for the quick and thorough feedback.  I'm glad to hear it seems
sane. ;-)

> Seriously, our tests prepare us well for an svn remote helper...

That might be a good reason to make a mock implementation of the
existing git-svn interface on top of git-remote-svn.  Sounds fun but
hard.

Ciao,
Jonathan
