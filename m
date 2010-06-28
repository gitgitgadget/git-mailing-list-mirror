From: Erez Zilber <erezzi.list@gmail.com>
Subject: Re: git log and cherry-picks
Date: Mon, 28 Jun 2010 23:25:07 +0300
Message-ID: <AANLkTinSFdB28QpfcqAuVCFzho0P_H_MG6_i2ODKiWuD@mail.gmail.com>
References: <AANLkTil6-rd5y9xcTVz4kJ4O2jL9ZdXYo1JrgYA3sM6N@mail.gmail.com>
	<4C28F300.1060506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 22:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTKtM-0004lM-DG
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 22:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab0F1UZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 16:25:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65486 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0F1UZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 16:25:12 -0400
Received: by bwz1 with SMTP id 1so376848bwz.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5g8i2TY/7PUwTRrJmVFqS9EP+gP+z62y0Tw5KQIAvzk=;
        b=F0fdyntKIYb6Gy83Nu4OD58T2VXgryGf/DIzcM+7n2cS63oRNcSeL+hbxpzmD5lfPZ
         D+VfAPrqyNYykEbeg2v3bSqJ0eb2xkcko5kV99vviW6rwSKEhww+8V4oW+FueBJCy/Y/
         VY1yuJiVpxCJBKWkGXJawHzFkXFu4Ogi2KQwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=McK4NBlC3pLvA6G9cLpPFqJcqJNWd7IR6uuyZZF2Q5nBwl45hM9t/sN/9Vo0/92A95
         EF0z73lvQoM4Z/DvGoQqQKV6RWxjiNY6zB+apyVvfi3yRljf/rLkZetGUYcogwM6bGGz
         GGMDrxDI6Vq3/s+DCUXUmvTpYfRPx12isPz4U=
Received: by 10.204.82.37 with SMTP id z37mr2842393bkk.110.1277756707316; Mon, 
	28 Jun 2010 13:25:07 -0700 (PDT)
Received: by 10.204.68.4 with HTTP; Mon, 28 Jun 2010 13:25:07 -0700 (PDT)
In-Reply-To: <4C28F300.1060506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149857>

On Mon, Jun 28, 2010 at 10:07 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Erez Zilber venit, vidit, dixit 28.06.2010 18:02:
>> Hi,
>>
>> I saw that I can run git log with '--cherry-pick'. With this, if I run
>> "git log --cherry-pick branch_a..branch_b", it doesn't show
>> differences that are caused by cherry picks.
>>
>> My question is: sometimes, cherry picking from branch_a to branch_b is
>> not immediate, and I need to adapt the patch that was committed on
>> branch_a to apply on branch_b. In other cases, git is able to apply
>> the patch on branch_b automatically (e.g. if there's only a line
>> offset). In such cases, will "git log --cherry-pick" ignore these
>> cherry-picks like it ignores cherry-picks that were applied without
>> any problem?
>
> With --cherry-pick, log omits those commits whose associated patch has
> the same patch-id (see "git patch-id").
>
> Michael
>

Is there another way to get over this (a commit that was cherry-picked
from branch_a to branch_b and had to be changed to be applied on
branch_b)?

Thanks,
Erez
