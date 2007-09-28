From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Add a --dateformat= option to git-for-each-ref
Date: Fri, 28 Sep 2007 15:15:58 +0100
Message-ID: <200709281516.05438.andyparkins@gmail.com>
References: <200709261009.18777.andyparkins@gmail.com> <20070926125811.GC13739@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 16:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGdh-0000ec-Il
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbXI1OQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbXI1OQN
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:16:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbXI1OQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 10:16:13 -0400
Received: by nf-out-0910.google.com with SMTP id g13so2522467nfb
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=MuuiD0rmdKxzr8SZvrw7+uxVa7/cS60WDBvRGS4YFP0=;
        b=VZWs+ZBZWae3eaDzft9bT4KgSGdD55udUL9BqwuqbZF41naApD8zfuvMl+Ldq/77stsOcCbTr0IhVwCpz+/cgeg2jtTRO8KS0THHpsiBWejw3vO9uHl7tnC2xvR2NaxpwUYX+sbDlYSxLzac4H7wxVx9VhC7OMry3iMzLQuOXck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=onAnel3IxMKL8M8FWN2sotGMeyDPt9mmEIOfPwneeavGrxjOekBMAf7HGmmnm34suWl7m2cX9YTPhovp/MclN5jkscRF+0kSRKl9sr8NFg2pgoRWJJvQogeAn1n/RH+VzYAoSaFpZw9NNUyFqRL3leDeOqKEoFSwQGZfUNH3gLs=
Received: by 10.78.138.14 with SMTP id l14mr3171775hud.1190988970904;
        Fri, 28 Sep 2007 07:16:10 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id h4sm3940927nfh.2007.09.28.07.16.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 07:16:10 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070926125811.GC13739@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59395>

On Wednesday 2007 September 26, Jeff King wrote:

> would be more flexible. Although perhaps that is a bit too unlikely to
> be concerned with implementing, giving options to substitutions seems
> like a sane way to implement these sorts of things (e.g.,
> "%(objectsize:human)", "%(parent:1)", etc).

I'd thought about doing it like that, but imagined that there would objections 
that it was overcomplicating git-for-each-ref.  As you think that's 
acceptable, I'll do it.

> Surely this same code exists elsewhere, and could be easily factored out
> into a parse_date_type function.

It was.  It was also in revisions.c.

A patch series that implements both your requested changes to follow.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
