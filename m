From: Stefan Beller <sbeller@google.com>
Subject: Re: Starting on a small project
Date: Thu, 8 Oct 2015 19:34:45 -0700
Message-ID: <CAGZ79kYty-1WELZaePfHfMKdNmUw09A2kUn8_xVUyDpu+19HVA@mail.gmail.com>
References: <CAAWikH5JJ2RSN-QaY2G2_N7ccSxvQm_GfT1u8-FXc2p7dcqRbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Elliott Runburg <Elliott.C.Runburg.1@nd.edu>
X-From: git-owner@vger.kernel.org Fri Oct 09 04:34:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkNWF-0006bh-A9
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 04:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713AbbJICer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 22:34:47 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35932 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689AbbJICeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 22:34:46 -0400
Received: by ykba192 with SMTP id a192so63036257ykb.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 19:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fNmG9N2ssmIYnNPAKmY66nwXeB4Vv97bT/ZSY0pItVg=;
        b=dtOhg8LffvKnXFOx7oM1SQzTQ3SKykPtArDcJFypdoMbJSLZPzyeQ0o2Qn55cu4Z3Y
         BUIYrjoWKZRDaxoBE9T/dBFI1oJYuiTna+GiC6me8oPV0mBst4LZYfVFC5SOPNSw9qNj
         KGCKdIjW+VOIZOlO5uEH355mut+jTI17cHBk3dh8Piw7gSY/dLqi0Wd05/x1rQwK6T+T
         eIRnQ/IvGPnR1zWSf3mTPD98YZ3GLyunRiQn7zyVxMGFvXyle3RsS928uCmPt8nFekAo
         54LVk9ZKOCzRnZQPfD/22nOAvifP4+0aGTfOsIe8NmgHf9e2tXmdnZppPekZ16mSoh7r
         vOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fNmG9N2ssmIYnNPAKmY66nwXeB4Vv97bT/ZSY0pItVg=;
        b=VgyJlBlQlbpCffQkEqsdpSjJ5mqPncuIvjXfycXG2npsLDyZpoatzpxAigPKGHCrGg
         4Zp0KTTu5b+kGmxhsKUBys8rGP8o8r6Qzfacnnn8AcWR5Hz/hcjy7dmf85BWQ+CdxWZa
         Ks+6hvLk/d6HbG9CVXYrwu3tgcUELkaanWJ/w61STSmYgUq+MMUZRMvUKZU22zVhzziz
         rKGrXSDXcBvxC4ZtZ56yhFQVPgb47xv4m1wZEwnln1otdCSlET5Pnb6CPjJtpDldgnzn
         jXQLYK56dMkux5wb+jMZNbeqqR0gY6K+JWF4MylSPITixe2iHXAS/PwNu2Fk1s2mrMoE
         rn7w==
X-Gm-Message-State: ALoCoQl6ExJwBftayrZeFr4LxbBze9amt2DtLcvByv4t1wLrvl7Dv1Bgtov/fmmhQCC9mTxc0vjK
X-Received: by 10.129.4.207 with SMTP id 198mr8594834ywe.320.1444358085698;
 Thu, 08 Oct 2015 19:34:45 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 8 Oct 2015 19:34:45 -0700 (PDT)
In-Reply-To: <CAAWikH5JJ2RSN-QaY2G2_N7ccSxvQm_GfT1u8-FXc2p7dcqRbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279299>

On Thu, Oct 8, 2015 at 2:45 PM, Elliott Runburg
<Elliott.C.Runburg.1@nd.edu> wrote:
> Hello all,
>
> I'm interested in contributing to a small- to medium-size project,
> preferably something regarding data structures. I was looking back
> through the SoC ideas, and saw in the 2014 page the suggestion to work
> on hash-object. I was wondering first if that still needs work, and if
> so, if there is somewhere with more specifics about what changes
> should be made.
>
> If this doesn't need work anymore, are there any suggestions for
> small-ish projects regarding data structures?

Look through
http://git-blame.blogspot.com/p/leftover-bits.html
as that's a collection of small projects for starters.

>
> Thanks,
> Elliott Runburg
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
