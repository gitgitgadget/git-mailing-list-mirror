From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree.sh - regression introduced by da949cc55
Date: Fri, 12 Feb 2010 12:52:22 -0500
Message-ID: <32541b131002120952gcb5116as730fff8bdcf005c1@mail.gmail.com>
References: <20100211130837.GA29916@lonquimay.wrk.lsn.camptocamp.com> 
	<508e1531002110526u623bffbdi119d009a7af460b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marc Fournier <marc.fournier@camptocamp.com>, git@vger.kernel.org
To: Jakub Suder <jakub.suder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 18:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfzh9-0006tZ-Oe
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 18:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab0BLRwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 12:52:43 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:49165 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab0BLRwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 12:52:42 -0500
Received: by yxe34 with SMTP id 34so800469yxe.15
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 09:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=j6w6HXHvTuDVaz+rxI8WGBvxWsji69/Swt17imB0wkI=;
        b=drGM74mCM/Hkoo2K2hft8gc4uzKsATTBlTE7kEJy2oOgAqbJXFQAPVMtZ5zGthBQhW
         hjrpFkIZbIkE8FhMlbDHuyNRSlVHM+/mlBd/LOMASgEcD88szSLilkNTIWlAzWP9yCtV
         nphV0LsVC7eq7sZPPR1Bd/w/qFoipFPleL0j0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZvHB9n1B9CV62JD1ZFAkbFLA2wwu0PVI7R9SaMbckahimavQ5Gw8qna+A1fq+7Hje6
         laWtkvBurkNINcZHoBHIOIUlHcwZkSXZY6Er3tJGbB5crBKVREf67q7gSfWGQ5oc057x
         izIpNkOnmfGTWylSZVW08okIdgFOTnApgruNg=
Received: by 10.150.171.35 with SMTP id t35mr2830361ybe.36.1265997162118; Fri, 
	12 Feb 2010 09:52:42 -0800 (PST)
In-Reply-To: <508e1531002110526u623bffbdi119d009a7af460b8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139733>

On Thu, Feb 11, 2010 at 8:26 AM, Jakub Suder <jakub.suder@gmail.com> wrote:
> On Thu, Feb 11, 2010 at 14:08, Marc Fournier
> <marc.fournier@camptocamp.com> wrote:
>> Jakub, I'm not sure I understand what this patch is supposed to fix. Could
>> you provide an example ? Or a test case ?
>
> there is a test case for the change you're talking about - it's near
> the end of test.sh, between "check if split can find proper base
> without --onto" and "check_equal ..." (it was added a few commits
> later). The problem was that without this commit, in some cases if I
> called subtree split for an external project which was earlier added
> with git subtree (in order to backport some changes to the original
> project) it didn't create the new commits on top of the existing ones
> like it should (just look at the test case).
>
> I'll take a closer look at this in the evening...

Did you have a chance to look at this?

Avery
