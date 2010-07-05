From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: *Non*-interactive squash a range ?
Date: Mon, 5 Jul 2010 09:00:40 +0200
Message-ID: <AANLkTimVgEUofsrZ0SnCXdW3zMF0SOfup4lQBXwWXXP7@mail.gmail.com>
References: <AANLkTimTx2dVlK9KKi1nZpOadwDcfyzhE8nffCyK1Sqm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David <bouncingcats@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 09:06:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVflA-0001GP-Kf
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 09:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467Ab0GEHG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 03:06:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59809 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab0GEHGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 03:06:25 -0400
Received: by wyf23 with SMTP id 23so2209670wyf.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=5eJDiXth1l4xJLNRev490nhzLDEsvOJdEecIDe5cOao=;
        b=ChX8qxObDMk2+AU/Un417jN+570RZ13HlQbW1jhVJWr2MzJzsBPNjo3bs/AR4xgXER
         Xbv3n/nBHqR9G214MO3wX0MDGTqwGSRIGAe9fzT/RAvBkx3J3ui/qXevj7cgckPcTfse
         aqzhH3Q06dDeMqzXsBYh4VqGgS1zdIdCfIgCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WVl7ENBwoIjJe0IiuCznpP+kFphf/bhL+cgjVtVK+eM9mpBv0EcafERyVV+pAuFhg7
         LWnkbcxXgnLxW4cAA7NVwBoL6yJPi/z8LzzobeZeIhLEYtvVWDN0dJP0NgAzzqdanmpe
         JCd3zcTG8xd1/IqzX/YkLcdk1PFAAY7x0NmAU=
Received: by 10.227.156.209 with SMTP id y17mr3015077wbw.18.1278313240580; 
	Mon, 05 Jul 2010 00:00:40 -0700 (PDT)
Received: by 10.216.39.83 with HTTP; Mon, 5 Jul 2010 00:00:40 -0700 (PDT)
In-Reply-To: <AANLkTimTx2dVlK9KKi1nZpOadwDcfyzhE8nffCyK1Sqm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150246>

On Sat, Jul 3, 2010 at 3:38 PM, David <bouncingcats@gmail.com> wrote:
> Having successfully used rebase -i to squash, I wonder about some
> method to *non*-interactively squash a sequence of intermediate
> commits. On a local experimental branch.

[...]

> My desired result is this:
>
>      ------------------K  <cleanbranch>
>     /
>    E---F---G---H---I---J  <uglybranch>
>
> where K and J are identical worktrees.


why don't you:

git checkout -b cleanbranch E~

git merge --squash J


regards,
Daniele Segato
