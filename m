From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Wed, 24 Nov 2010 20:32:16 +0700
Message-ID: <AANLkTinTisPh-x-JQBMkz-b=RoMJ6PUQ8Hp1VV_uZ=V+@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 14:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLFSw-0000U1-T1
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 14:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab0KXNct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 08:32:49 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34623 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0KXNcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 08:32:48 -0500
Received: by wyb28 with SMTP id 28so9475640wyb.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 05:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=hmk7ILaakYZilZwz+NoUO92fXwAWIHkgCllHEdewrSs=;
        b=cSiXXZCaUTb4oxUNlAkOce8y81Qx/KFpKhsIZqw6vtw4OxIajQbiFV5MM0ZGVt+eqN
         oVNVxa1hh98tntpllAzUnYSusnFlk+9r6q4erOAYXJivJ+qNee8eM3iKRBMYtn4XNtjr
         e1jimbTfbn6I5gPUT+ci/3fzuXQWfVUoFRihE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jH0ycGmkcty4MePZ1EvmUTxSphvLIEkzhbYjlIQ7hYhJxMgaeiAhgPSYEkVgERItqo
         CayA9nGNfTO8amPT6agbdVTgj6D0Lu8ncJ++11ZZ7W3EtpN9uXpAC+UQBdoe1Kha0BpH
         g58aHU95qClmi4p/HCJIcGrfa7McTCFPz8Wis=
Received: by 10.216.47.19 with SMTP id s19mr2488023web.56.1290605566992; Wed,
 24 Nov 2010 05:32:46 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 24 Nov 2010 05:32:16 -0800 (PST)
In-Reply-To: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162061>

On Wed, Nov 24, 2010 at 2:08 AM, Dun Peal <dunpealer@gmail.com> wrote:
> Hey,
>
> We have a bunch of Windows users, unfortunately, and they're using the
> latest msysGit release (Git-1.7.3.1-preview20101002).
>
> An interesting issue we've noticed is that the Time To Complete of
> their common operations start deteriorating inexplicably, and
> severely, some time after the clone.
>
> For instance, immediately after a clone, `git status` takes about
> 5-6s. Which is slow compared to Linux (consistent 1-2s), but still
> usable (it's a BIG repo).
>
> However, after a reboot (of all things), `git status` latency
> skyrockets to 14-15s, making the repo unusable.

Does assume-unchanged bit (see "git update-index") help? I'm not
suggesting to use it but it would help determine if the slowdown is
worktree-related.
-- 
Duy
