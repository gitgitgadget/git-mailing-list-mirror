From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 12:26:40 -0500
Message-ID: <CACPiFC+CAhh1S6Wt0bO2pDrXWgBW7AEFahGJjq0W7rG9LfTb8A@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Raymond <esr@thyrsus.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 12 18:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrA2V-00082g-B1
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 18:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab3LLR1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 12:27:04 -0500
Received: from mail-ve0-f182.google.com ([209.85.128.182]:42608 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3LLR1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 12:27:01 -0500
Received: by mail-ve0-f182.google.com with SMTP id jy13so544982veb.41
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F5POrwsuc2gggzZigtire3+H79EPwwCHOBnWIFrw60g=;
        b=JJIkCdoo0LAX935VJCYUcIdI6/RX81YcnHEpBPBci+cYrcYYvfNdYQ3le7BhKmncJM
         TUM2YJGnXLA0N6BVPBikgXZUIdAmOwf3aouv4lpYD3NRGpaSl36bXrdHcyKE304y3wlh
         pBiW5bvEzsXfMXsJ37V6WLd441yUfao4zgIqhAnIqtiP/9IdJdFTy3fXmBkQV4aMKewp
         WSC9J1+hTXlrZfN7F+EbVx8e42ZWfNWD+Xr85VTR9B6Frtsv2x86xtPMmAS0ORPx+ZuA
         HQyAlOsThwoLiA0uMyKOQewKjGq38lXG9yDioqarlRDTiVabDOUDqy0eN8RVGU+E+yxB
         tmhg==
X-Received: by 10.52.230.202 with SMTP id ta10mr287366vdc.41.1386869220434;
 Thu, 12 Dec 2013 09:27:00 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 09:26:40 -0800 (PST)
In-Reply-To: <20131212171756.GA6954@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239230>

On Thu, Dec 12, 2013 at 12:17 PM, Andreas Krey <a.krey@gmx.de> wrote:
> But anyway, the replacement question is a) how fast the cvs-fast-export is
> and b) whether its output is stable

In my prior work, the "better" CVS importers would not have stable
output, so were not appropriate for incremental imports.

And even the fastest ones were very slow on large repos.

That is why I am asking the question.

> It won't magically disappear from your machine, and you have been warned. :-)

However, esr is making the case that git-cvsimport should stop using
cvsps. My questions are aimed at understanding whether this actually
results in proposing that an important feature is dropped.

Perhaps a better alternative is now available.


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
