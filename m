From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Code changes in merge commits
Date: Mon, 29 Sep 2014 19:29:59 +0700
Message-ID: <CACsJy8BFKrgssx+787KOspPRZ7wQfT_187VsgeztOUOXaSEx_Q@mail.gmail.com>
References: <CAHQ6N+p1GqQfTs0H-4ij_QfkWQGfTUbWBzMC4E7LCEynPT78kA@mail.gmail.com>
 <CAHQ6N+rJDtq_vtfotM+GXLdN_P==oTqGbFZ97ZQea9+mcoRBog@mail.gmail.com> <vpq8ul2pu9n.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 29 14:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYa6B-0004tx-Ij
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 14:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbaI2Mab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 08:30:31 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:37493 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaI2Maa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 08:30:30 -0400
Received: by mail-yh0-f50.google.com with SMTP id z6so910436yhz.23
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 05:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZLLemSXe9ShzuwLPdxMdaArIVGb8llLkP9bZa+8Glns=;
        b=eBVY8Uw2geo1/xULY4Z1xmM1eJ3kmFLxf1HoiCoogiUcZTaX9VGeA5eIXbE4XhBP49
         dazBTC4O7brsr9GnscRm/2KXCjsVLQ4bnUQ+prItkJjo48sKnbNct+t4r1MseElUtkDQ
         AWf5kpeO9U2mVop7KBcWHhpyQ9Px949vDrR58RHKsYWhFv3KaOIiDOaRWZ+4E+Fx4RVz
         zth1XI9H0lqyEOoJBCPMTZUNG1sPuOJ+CVgcsj2CEQT7VBqPwiiazUn1rFguNHdDMZ44
         YHOfCjulafDGrvqJaSGDfIlWMk2DfUv31qp4U8Mx3Z7BsO9t6r2r2Bk+8rdG62S5Aas5
         bIaw==
X-Received: by 10.236.227.162 with SMTP id d32mr2329174yhq.100.1411993829933;
 Mon, 29 Sep 2014 05:30:29 -0700 (PDT)
Received: by 10.170.62.136 with HTTP; Mon, 29 Sep 2014 05:29:59 -0700 (PDT)
In-Reply-To: <vpq8ul2pu9n.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257623>

On Mon, Sep 29, 2014 at 5:59 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> Ideally I'd like to see all the code changes to a code base just with
>> "git log -p".
>
> What I'd love to see with "git log -p" is the diff between a trivial
> merge (possibly including conflict markers) and the actual merge commit.
> That would imply that "git log" would redo the merge before computing
> the diff (rather heavyweight :-( ), but an empty diff would mean "no
> change other than merge", and if any, we would see the conflict
> resolution or additional changes in the diff.

Topic tr/remerge-diff in 'pu'? I think --remerge-diff works with
git-log, but I'm not sure.
-- 
Duy
