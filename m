From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 12:12:58 +0100
Message-ID: <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de>
	 <e5bfff550906130013j3a9802cen48ac5828a2357bf1@mail.gmail.com>
	 <200906131302.43091.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Jun 13 13:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFRAa-0004oo-Do
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761362AbZFMLM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 07:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762071AbZFMLM6
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:12:58 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41934 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762861AbZFMLM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 07:12:57 -0400
Received: by ewy6 with SMTP id 6so3680395ewy.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9XKRCdn2LJGyRT02JN8E1FqhDtNA2mF7tPIg+VgzR1M=;
        b=PyHpeLGFM2iycSLM95T+vtQbuyk/QuuQjcjbO3NsBpasSaXEuM8vxvGkoXhdAmrd9/
         44hr7kKl6uupYCVqNKo7iTKt+HZODJScIJt8RyXV6eB8fjjaEqJfehW5K7ItceXPW70h
         7yMQxWPuXcqSeRA+ls+qDt+vK2/eIGtMTwRnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RdgRIikPs0v3yo/D3trsRImVAOP+aU9qDnJP0fn2HXD69m/uQwl0NSziV4iH/8fh77
         UbweWUYDwhlRVopKukU6L4ur4JNYPZ0Q5iQCZjAnYR7q7OSKm+GZM7tU4PVM4AP9/3X0
         ACGv8ntQJ7OqwdoTXd4Hic8CKU9QH7uX8nQw0=
Received: by 10.216.28.193 with SMTP id g43mr1649071wea.192.1244891578865; 
	Sat, 13 Jun 2009 04:12:58 -0700 (PDT)
In-Reply-To: <200906131302.43091.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121495>

On Sat, Jun 13, 2009 at 12:02, Markus
Heidelberg<markus.heidelberg@web.de> wrote:
>
> OK, if I now disable "All branches" in "View->Select range...", I get
> the 2 patches from above again.
> But in my git repo with local branches, it's the other way round...
>
> Markus
>

Ok. The point is that if I select 4 _consecutive_ revisions from any
repo and do "Save as..." then I see the 4 patches created in reverse
cronoligical order as it should be.

If I select only two patches _non_ consecutives and I do "Save as..."
I get the two patches + all the pacthes in between still in reverse
cronological order.

This is with stock QGit 2.3, Windows version.

Have you some problem to reproduce this behavior (that is intended to
be the correct one BTW) ?

Thanks
Marco
