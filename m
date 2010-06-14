From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Fix strcat() on uninitialized memory
Date: Mon, 14 Jun 2010 13:50:24 -0400
Message-ID: <AANLkTiknleOJ8uZyUE1V1ar7eET_Ksb1hTJiPWkdx5po@mail.gmail.com>
References: <alpine.DEB.1.00.1006141032250.2689@bonsai2>
	<AANLkTimSFwn1yykyEOTRdHHBYTFUEhxqj2AinjRv9ECC@mail.gmail.com>
	<alpine.DEB.1.00.1006141856030.2689@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 14 19:50:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OODnt-0002RN-0A
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 19:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616Ab0FNRu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 13:50:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34962 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174Ab0FNRuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 13:50:25 -0400
Received: by yxl31 with SMTP id 31so1494814yxl.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Xf7h0SA0Oj3XlgQh5NDEEtV9UVd70FX1WFdjKHM/Z9k=;
        b=vth4B6gu4T7XViBDxMfQzzm4NWkSDzO3g+0LjZlGsB7ya/CrJQX7lxnK6afwEs3XpM
         lJ+Q6innXY1CeFbPqVwOwWuRu52jQZ6ljDLTsYBm8iVrCjW52nvLBKvKj5OGpZC8aRFN
         Tu8B53msdh1P0UfBV/ml3AurtDjlYmdA5F86U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w3ucDSzJQO013tSOR6BFKTymSo8kv1l3K1Sw1V/vqAZF5Lu9oBMVxP8YXA5cRmV902
         mrDuKfDGuvzwYua/pEpGOyCN/dJwYzPmw7hGg5QNnzamFrbUeW0zX5fVl02SPrSIuVN/
         HDgtb+HVdQh11xvSfaBfZxk+Q8PUNatfQiMHA=
Received: by 10.224.87.194 with SMTP id x2mr2471672qal.188.1276537824831; Mon, 
	14 Jun 2010 10:50:24 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Mon, 14 Jun 2010 10:50:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1006141856030.2689@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149133>

On Mon, Jun 14, 2010 at 1:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Great. So it was caught. Why was it not even in 'next', so I wasted my
> time finding the bug?

Junio recently switched jobs and is perhaps a bit behind.

> Anyway, it is in 4msysgit.git's 'devel' branch. So its fixed now.
>
> Frustrated,

Sorry for the original bug. I'm still not sure how I made such a
boneheaded mistake. It looks like I might have stupidly copy/pasted
the matching lines from builtin/fetch.c of "git grep
find_unique_abbrev" output.

j.
