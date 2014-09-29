From: John Tapsell <johnflux@gmail.com>
Subject: Re: Code changes in merge commits
Date: Mon, 29 Sep 2014 12:02:50 +0100
Message-ID: <CAHQ6N+qGTubVB7F8LzfX=bODn6jdYtV9fz=RJ2fzS2aqhe5-uw@mail.gmail.com>
References: <CAHQ6N+p1GqQfTs0H-4ij_QfkWQGfTUbWBzMC4E7LCEynPT78kA@mail.gmail.com>
 <CAHQ6N+rJDtq_vtfotM+GXLdN_P==oTqGbFZ97ZQea9+mcoRBog@mail.gmail.com> <vpq8ul2pu9n.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 29 13:03:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYYjc-000430-LW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 13:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbaI2LDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 07:03:12 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:34786 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaI2LDL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 07:03:11 -0400
Received: by mail-we0-f172.google.com with SMTP id q58so3874422wes.3
        for <git@vger.kernel.org>; Mon, 29 Sep 2014 04:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0aZvSHvpYi5TstsV9r2V58CizYua1kNqQddKce/J/V4=;
        b=OijpVw8doRT/jE9L8s1cLfidPOhH03m2cvz7/k5OnOdAyGq6XIo/itKGGRhLTGbIsH
         R2WfBlKv3GudzCkMFilqdFPbezIg/HpVoeD4MLuYoQZM7quQlBOX6PecyS/iYUZoLzm8
         WdyOf7pre2YHEz5lDgK1byRv3pJFXjjfuj5iSLpiiMtNyPoa8ZxHCV2pmb7CgG+amXG7
         rgynpT1rhoTpv3Wczp2jjeCBJVFpigdNz3xPryV0vCSBrBrRSvHAbRMfGiiIIBappja7
         Wdlkg5jU+KI2wZGZaxIMzSGCpACRgyPnS+zYQWHjQcbF7oZd0UTWMZhQLDSFyRoDCbjk
         sd1Q==
X-Received: by 10.180.96.71 with SMTP id dq7mr1996506wib.66.1411988590552;
 Mon, 29 Sep 2014 04:03:10 -0700 (PDT)
Received: by 10.27.130.193 with HTTP; Mon, 29 Sep 2014 04:02:50 -0700 (PDT)
In-Reply-To: <vpq8ul2pu9n.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257621>

> What I'd love to see with "git log -p" is the diff between a trivial
> merge (possibly including conflict markers) and the actual merge commit.
> That would imply that "git log" would redo the merge before computing
> the diff (rather heavyweight :-( ), but an empty diff would mean "no
> change other than merge", and if any, we would see the conflict
> resolution or additional changes in the diff.

This would be wonderful.  And I'd rather have git do the heavyweight
work than doing it myself :-/

I don't know the git internals at all - would it be possible to "save"
the results of the diff?  This is what I was aiming for in my idea of
making the merge and conflict-resolution as separate commits.

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
