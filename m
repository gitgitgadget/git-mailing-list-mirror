From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Tue, 30 Apr 2013 00:33:15 +0530
Message-ID: <CALkWK0nNb1CSR6EHxtnvBd3VXVPNb_JDqk2Kfa5VA1RMG1u0Ng@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
 <7vhaipl2ks.fsf@alter.siamese.dyndns.org> <CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
 <7vmwshi3dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtNA-000862-BR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500Ab3D2TD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:03:59 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36335 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758230Ab3D2TD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:03:57 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so7734131ief.35
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fTHyI/M1hkQ8qQQ+KFuFXsUKQGS7nsv6aEKDxObgK8E=;
        b=JJlLVLa6yUFSns6H+OktCo09OtxlfA3LUyRNtQ+TcZfKL3gQC8hRylWZIvyu1rniiO
         /JfEzoi87BetV4qn4yC6tFi6fvf4v7s0zxXteO99+Iw/wC0ozyaX34XH7DXPEBLc7qct
         SgNdhlR1NW35ZSCxEyWJU7f2j0TDBZA3Iy//aRMUl0iF+2IVcRYq5TLPfT4q6xqzpeKl
         HsHR6uaWE+Nd3FneoUK9ZsFk1K/Lp13LOqFvJhsJoSwzZKJx3kcZN9EgDIFjJSEW4+ON
         nJNnOjkHhobK6QIlX5iQbNQhFivStTMhBtq/QAu4IF0QRGDjdZSDVnmZ51Xuc8Y6T9Nl
         X4Xg==
X-Received: by 10.50.72.65 with SMTP id b1mr8248161igv.63.1367262236032; Mon,
 29 Apr 2013 12:03:56 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 12:03:15 -0700 (PDT)
In-Reply-To: <7vmwshi3dv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222846>

Junio C Hamano wrote:
> Wait.  What does "lists H G D A..C" even mean?  H, G and D I would
> understand, but how does "log" ever "list" A..C???
>
> Now you really confused me.

What you said was technically correct.  I was pointing out that the
graph was misleading because it didn't show any commits between A and
B/C.  A is ofcourse UNINTERESTING.

> What does it mean "log" "In reality" shows A..B?  Didn't you just
> say it either lists "H G D C" or "H G D B"?  Neither B nor C is what
> you did since you forked?  Now, what did you do since you folked
> (which is the question you are asking)?  You made commit D,
> back-merged from upstream to record G, and then made another commit
> H.  That "H G D", which is what you get from "log F..H", isn't it??

Okay, so the question is ill-formed.  The technically correct version
is "which commits are reachable from my branch since I forked off?",
but I don't know if anyone will want to ask that question.  If you
have no more inputs, I'll concede that it's not useful in the log
case.

I'm trying to look for one more command that will find A~B useful, so
we can remove the A...B wart from diff; inventing it just to replace
the wart isn't reason enough.  Do you disagree with the approach?

What are your thoughts on overloading it for rebase?  git rebase
master~ to rebase onto the merge-base of master and HEAD?
