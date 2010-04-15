From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Replication of shared repositories
Date: Thu, 15 Apr 2010 10:25:39 +0530
Message-ID: <x2uf3271551004142155g2370b9bam16aa00590ecb3f92@mail.gmail.com>
References: <1271144720027-4894649.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: cdossantos <claudia.dossantos@ricoh-europe.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 06:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2H7f-00069P-9r
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 06:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab0DOE4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 00:56:02 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:63278 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab0DOE4A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 00:56:00 -0400
Received: by yxe37 with SMTP id 37so566532yxe.21
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 21:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=MNvULLklg/6emxC+DIaULdRHfOPlamcW7wRinG+wr1Q=;
        b=Ta/0Uo8LFxpfFb5m+M5dbwjxpJau+p/7oclXxtwcT0JbeFxljfR7flJAraMSnjsVPa
         IBh0vaakdinhMYwgtNynR1S2+qzWTzLPI3gg44FimenK3lTxzWUlzJ1NOLXkw6bOh0w9
         wgYSSZBqQigDbCHImk6mPFufL9rx9rvS0dciE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vV7bcQxAUGrV0gE9UMLT3+X36JzWT4HCDDf7x+Afa9q9A7EGv/yuLOkC8XUY45Tzdt
         ln6vIT3K6aF3wjys40ritioZcTYWDbbFZ6VSctz+YDH2MW9hykplhasjq2HTSAvwOK0C
         +Gt4AezLjP8ObQlnjMtWd2V5cKD56dq+9F8/c=
Received: by 10.90.69.14 with HTTP; Wed, 14 Apr 2010 21:55:39 -0700 (PDT)
In-Reply-To: <1271144720027-4894649.post@n2.nabble.com>
Received: by 10.91.112.13 with SMTP id p13mr3883027agm.29.1271307359170; Wed, 
	14 Apr 2010 21:55:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144949>

> I would like to replicate the contents of my GIT shared repository to
> another server, a sort of mirror, but i didn't find any references about
> that.

Just push to two different remotes.

> I know that hook scripts run locally. However, could i have a post
> commit script that after a local commit, not only starts a push to the
> shared repository but starts as well a push from the shared repository to
> another server ?

I suppose you could do this.

-- Ram
