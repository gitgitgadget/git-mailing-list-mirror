From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Wed, 15 Aug 2012 23:06:24 -0700
Message-ID: <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
	<87sjbpa5m8.fsf@thomas.inf.ethz.ch>
	<7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 08:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1tE4-0003JY-LX
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 08:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab2HPGG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 02:06:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34619 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab2HPGGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 02:06:25 -0400
Received: by pbbrr13 with SMTP id rr13so1059705pbb.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 23:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fLTt0MUXj/NNp6mxkeJIg4Ksv+1qlJBfeveGZYLBHSQ=;
        b=fEU1mr2h1lppw2BEkozw9BpyIMzeEPg5rKBgCJt7P9TiRrZXYTVIS83wA3Shsp+Gvx
         vgzTQLlkuyGS+k1bT7SQYk32CmWaEDDhgatOWUE5afq3yQkzQGhqLAnzkhWD6SK3FdPr
         jYVlpfvfMmRo9CMlenGJiVulMR2Dlr4FGPSa94mcmZXETO34TxUPbkycpoBJR8ue+rrn
         0SF9FTtPxLpLOOpnHAt8ncGQEV5CogKbEbtr2aLRpy3aza3w7hnt2C5uepsjfksg6x0f
         7V8QnYJ5o5LQNPbsFVb42fhaMYk9NUTi9yWDxYVX+VuYIR6GpLKT00sRRc1vTiHWiRbc
         s1Zg==
Received: by 10.68.201.234 with SMTP id kd10mr956288pbc.141.1345097184901;
 Wed, 15 Aug 2012 23:06:24 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Wed, 15 Aug 2012 23:06:24 -0700 (PDT)
In-Reply-To: <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2012 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 6a4b635..9404d08 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -578,16 +578,33 @@ Commit Ordering
>
>  By default, the commits are shown in reverse chronological order.

As I said before, this led me to believe that "the commits are shown
in reverse chronological order" when neither of --topo-order or
--date-order is passed. I agree that we should avoid specifying more
than necessary about the default case. But in this case, what is
specified is not exactly true (in the face of clock skew). Or am I
misunderstanding or misinterpreting something? I still don't
understand the revision walker well enough to be able to provide a
better wording, but I think even the rather crude "By default, the
order is unspecified." would at least not be as easy to misinterpret
(if that's what I did) and is definitely not over-specified. Of
course, if someone can think of something better, I'm all for it.

Regardless of the above comment about the patch context, what your
patch actually changes looks good. Thanks again.
