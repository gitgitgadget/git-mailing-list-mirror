From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: git fsck: unreachable vs. dangling
Date: Tue, 14 Apr 2015 11:28:41 +0200
Message-ID: <CAHGBnuNA7fVKJRA-oMbnL5J+zoe7F6sy0rU_0PvAX52x0ofXdQ@mail.gmail.com>
References: <CAHGBnuOYLpkeUop9vNH3+WSKqrM3NCSqvu-NZnPnk3gEkAr6eg@mail.gmail.com>
	<CAPc5daXRpfSrvcae0W+YU-51prCoFGxz_hkhtp7FZ-K9_eeeBQ@mail.gmail.com>
	<552CD4C8.2020700@drmicha.warpmail.net>
	<CAHGBnuPepR11r9qpxb2G7pGhq0iiaqCCLnbt5NB_xohHi=cVxA@mail.gmail.com>
	<xmqq1tjn3vzs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 11:28:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhx9D-0005Tw-64
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 11:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbbDNJ2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 05:28:43 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36372 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbDNJ2l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 05:28:41 -0400
Received: by igblo3 with SMTP id lo3so68844595igb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mOuh7cGnJK3UwXXzgJLBVBdllL8Aq9xOtEpNfDVwKK8=;
        b=RKIXMw3FSkMo/2F8e1TjaosQmfRL6z1QcdVXTBrVzrGaOqr9nr3y3S6YE7NZUCpzLw
         PuDGz92qHHdPTqdcVm1aaB/bN6yP2z0TD28AZRX5SWesm1PopEfzvR74uQAo8zi60MWU
         qxcH+NQE/7dfinvG3otVlWAmAvS1OipBg4M7WnMgHec3so6b/5aGB5InIaT/cBlZwoJP
         30JNw/HngP/kqThikOOKIocZVPdNL9HQgfFDfFLENhytLJvlQ08h06msgz7+1AWy487A
         p2GBH1jSmyB/zzjZw3TpqJBQpefqulYLe2eDn63IQ+fWa2PlFDwEnDdcsvMXTnpCINms
         2mag==
X-Received: by 10.42.86.12 with SMTP id s12mr24287852icl.47.1429003721147;
 Tue, 14 Apr 2015 02:28:41 -0700 (PDT)
Received: by 10.107.159.82 with HTTP; Tue, 14 Apr 2015 02:28:41 -0700 (PDT)
In-Reply-To: <xmqq1tjn3vzs.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267126>

On Tue, Apr 14, 2015 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:

> I just visualize commits to be ping-pong balls with strings between
> them, and then grab the root of the graph and lift the whole thing
> up, while tips of the branches and tags are anchored.  Commit A will
> be dangling in the wind if you shake the whole thing.

I used to have exactly the same visualization in mind, but got
confused in between, unsure whether my understanding was correct. As
it turns out it is, and when sticking to that visualization everything
seems to be consistent in the fsck docs. They could still benefit some
more clarification I guess. I'll see if I can come up with something.

Thanks again.

-- 
Sebastian Schuberth
