From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] tests: make test_must_fail more verbose
Date: Wed, 1 Sep 2010 10:55:54 +0000
Message-ID: <AANLkTinU7nV09NMvsZ+u9JCzeDsLqw3gS-7Y=i0Eqk_X@mail.gmail.com>
References: <20100831155457.GB11014@sigill.intra.peff.net>
	<20100831155636.GA11530@sigill.intra.peff.net>
	<AANLkTi=aGdLj4vRKs8dR64JO=c8eC3SHj0_hkh6Wutaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqkz3-0003wT-An
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298Ab0IAKz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 06:55:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52521 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab0IAKzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 06:55:55 -0400
Received: by gwj17 with SMTP id 17so2934980gwj.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=4gJNH3sFEyHXxHf51yy5N+NowbWI2uz1szx9374VqHQ=;
        b=oUf9zbRxMAUbgo1LqXAaMcMOv/aPU5lCX284s+4Rv0+DoQqIQ2l9wgO9B//TvgtIEl
         NxJv1yEGB7f6VJVbFcSDAGmBjxRCxOzI5qhI+a8QTPnrBCRId1eUBK8S55LFkjN2v6E5
         UczMJmAG92df7fnNnVOnywO98iqG9Tor+nCgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xo7qnddk3n7zTvnQ9xQ33d7mo6/PaN5Mo4w6i52cH/70iX+yOPEEtUk7R26fTh1oVp
         EUVEHzqoNtlAmIvTr58IsQqG76ybiQeX+E/1cQod9jxHODEjiTqPMdrRObRmbZKGlHJ5
         qeo6Ha9e7eDRJBwdODn5Dwsp8i4Dy6yyoRTgU=
Received: by 10.90.71.1 with SMTP id t1mr6209958aga.65.1283338554363; Wed, 01
 Sep 2010 03:55:54 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 1 Sep 2010 03:55:54 -0700 (PDT)
In-Reply-To: <AANLkTi=aGdLj4vRKs8dR64JO=c8eC3SHj0_hkh6Wutaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155038>

On Wed, Sep 1, 2010 at 03:37, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Wed, Sep 1, 2010 at 1:56 AM, Jeff King <peff@peff.net> wrote:
>> Because test_must_fail fails when a command succeeds, the
>> command frequently does not produce any output (since, after
>> all, it thought it was succeeding). So let's have
>> test_must_fail itself report that a problem occurred.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>
> Jeff,
>
> Nice fix - thank you!
>
> It is nice to see that my initial sloppiness inspired a thoughtful
> remediation. I'll try not to rely of gitters being always so helpful
> :-)

FWIW I plan to make this sort of thing better for everything when I
pick up my "WIP: Report intra-test progress with TAP subtests" series
again. I.e. use >&5 instead of >&2 and turn this sort of thing into
subtests.

But if you're interested in picking up someone else's slack it could
use some help :) I don't know when I'll get around to fixing it up:
http://github.com/avar/git/commit/e2ac35a8e49ceec98ca512bf106ce04c93c84b5c
