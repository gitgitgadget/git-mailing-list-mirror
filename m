From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Equivalent of "fixup" for git filter-branch
Date: Sat, 12 May 2012 14:12:54 +0200
Message-ID: <CAGK7Mr6dMA=r3omxUgvozxi0o_rzF3ZwDwJB3FzNWW41OXYiTg@mail.gmail.com>
References: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
 <m21umsylz8.fsf@igel.home> <CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
 <m2havmop75.fsf@igel.home> <CAGK7Mr6Z44iJqATgiWHXeutOHJM-vXauYeyYB0Z6c+mGYCr1Cg@mail.gmail.com>
 <m2d36aompd.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat May 12 14:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STBCT-0000Fx-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 14:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab2ELMN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 May 2012 08:13:26 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63277 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab2ELMNZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 May 2012 08:13:25 -0400
Received: by gglu4 with SMTP id u4so2324537ggl.19
        for <git@vger.kernel.org>; Sat, 12 May 2012 05:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7BlI9dxnIqvTiWPwiTXlVTpQ7qNAEJvgZUzvgyR2uBQ=;
        b=eR7Kzn/iW0D1yqnH02lOEe6v/rNraKsHudPFC0U//XMvN1UXkJ/2JV75+zM+pghZjO
         /+WN7KljsmGkdS1E7whBfqesyBx9zdUTl3bQ9laeI0xjRs05QGgG9QraHiDGS5LednHu
         Wi4vXrQ3S1h0g55QsABfDHRcqe3qdJ8ZyoDdsNzvYNcDj06JhqE5H2ienqhobWEJK2wW
         nOeEjriUQP+FGR5M7VOPgpbub9gXagGOn1dbbgw61EPie7aJYPjEVWhxD1wlzxTNfr7Q
         5oq7A2l9/ieIA4Qgbt+yTlOLhN8N85HL5MhCGSUnQiCDsTsfa8By74j1ARHRsmiuOTvq
         ++FA==
Received: by 10.50.173.102 with SMTP id bj6mr767290igc.45.1336824804373; Sat,
 12 May 2012 05:13:24 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Sat, 12 May 2012 05:12:54 -0700 (PDT)
In-Reply-To: <m2d36aompd.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197729>

> > I was also thinking maybe I could use --parent-filter: when I find =
a
> > fixup commit, I set its parent to its parent's parent?
>
> This will keep the attributes of the fixup commit, discarding the
> parent's ones. =A0In git rebase, a fixup keeps the attributes of the
> parent, discarding the ones of the fixup.

Ah right. Thanks for your suggestions, I'll try to get it going. Maybe
the result could be material for more examples in the man page.

Philippe
