From: Larry Martell <larry.martell@gmail.com>
Subject: Re: inconsistent behavior on mac with case changes
Date: Fri, 14 Sep 2012 08:37:16 -0400
Message-ID: <CACwCsY4vQDQNqaMaAEJEDGbZWVFbktfXrQj+-79fN40_d+075g@mail.gmail.com>
References: <CACwCsY4iO2WzXizbG+75OJ096OpHp7KOidn4q11nfxnkJuQg_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 14:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCV9L-0001KP-BR
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 14:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab2INMhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 08:37:21 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41914 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab2INMhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 08:37:17 -0400
Received: by vcbfo13 with SMTP id fo13so3763868vcb.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Mup8Oj5W7caQQ5foE/eDB8+0bi7DewjBAFpgHXuz2Ms=;
        b=bCvBQwZIM6Fwwk64F2+ao6hufntpJWnDcFNDgLH1nubotUUH8QjhkFovOVHZSCZqOY
         LGdnkBNp4g0iZlArR4hsR5wN+FEaFU+sqODhHR4Aq97NUY3EOF44vMrJfcO4HxAslcYS
         02Ms04Pm92rF/bkRwubVS7ktqurEVxUFXPOheOXQCFUg3wpzfxa52KSSZkiVKFQV1Fr/
         qOfWQGGI3zLtnpJ6PLXy7mxdbIQV9pmTH4+auNBHQuAVPv6HL49tCRiKGBl6ATQSn/7J
         6Puu7zrrWvpyF7/zUteENks2d+IjXp6uDZIWWhYE/sHooOhzHLJBp4sDAWs3djrY+96Y
         j4yw==
Received: by 10.58.88.71 with SMTP id be7mr2078467veb.21.1347626236594; Fri,
 14 Sep 2012 05:37:16 -0700 (PDT)
Received: by 10.58.198.112 with HTTP; Fri, 14 Sep 2012 05:37:16 -0700 (PDT)
In-Reply-To: <CACwCsY4iO2WzXizbG+75OJ096OpHp7KOidn4q11nfxnkJuQg_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205484>

On Thu, Sep 13, 2012 at 5:24 PM, Larry Martell <larry.martell@gmail.com> wrote:
> I created a dir on my Mac called Rollup, and pushed it out. Then went
> to a CentOS box, pulled it, and realized I wanted to call it RollUp
> (capital U). I renamed it, and pushed out the change. Went back to the
> Mac and did a pull - it said it created the RollUp dir, but it did not
> - it was still called Rollup. I reamed it, but status did not pick up
> the change. Then I checked out a branch that had Rollup, but it was
> gone there - no Rollup or RollUp. I did a merge and then RollUp was
> created.
>
> I know the Mac is somewhat inconsistent with how it deals with case, e.g.:
>
> $ ls
> RollUp
> $ ls -d Rollup
> Rollup
> $ ls -d RollUp
> RollUp
> $ find . -name Rollup -print
> $ find . -name RollUp -print
> ./RollUp
>
> So I guess I can understand git also being inconsistent there. But
> what really got me was the dir being gone on the branch.
>
> Is all this expected behavior?

Is this not the correct list for a question like this? If not, is
there another list that's more appropriate?
