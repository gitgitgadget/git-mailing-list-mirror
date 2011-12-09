From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] t3401: use test_commit in setup
Date: Sat, 10 Dec 2011 00:32:13 +0530
Message-ID: <CALkWK0k-dL3xZ+dyqdACj7man-Q2QrAPZCCMhXiX0WNGZHv6Fw@mail.gmail.com>
References: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1323449952-14161-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ5iT-0003Kj-KI
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab1LITCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:02:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47907 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab1LITCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:02:36 -0500
Received: by wgbdr13 with SMTP id dr13so6204409wgb.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sKKMhesDtxOETzsZAp6sfQSw+t9dwm72SXmhdm2v+UY=;
        b=loCCdXCrfSMHvJdhKdV6CPIfsgGrlylXY0MOvyIEQVxfw3ram7ltJVxz1Dy3QDWdcX
         ZztjIcCXrLnlGGwwF+vFjH3f+nTlxgwEIXAPyKonB9XhwoAVDcSfhYk0xopxejYAHhOo
         vOFUNzsM7xchTPNAZMHgcjM13WNK7bF3UpggY=
Received: by 10.227.203.10 with SMTP id fg10mr7725628wbb.1.1323457355408; Fri,
 09 Dec 2011 11:02:35 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 11:02:13 -0800 (PST)
In-Reply-To: <1323449952-14161-2-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186664>

Hi again,

Martin von Zweigbergk wrote:
> Simplify t3401 by using test_commit in the setup. This lets us refer
> to commits using their tags and there is no longer a need to create
> the branch my-topic-branch-merge. Also, the branch master-merge points
> to the same commit as master (even before this change), so that branch
> does not need to be created either.

The terms "tag" and "branch" here have no significance, so
de-emphasizing them to "ref" is probably a good idea.  Isn't the truth
more like: instead of creating commits and creating refs to track
those commits by hand, use test_commit to achieve the same result in a
single step?

Cheers.

-- Ram
