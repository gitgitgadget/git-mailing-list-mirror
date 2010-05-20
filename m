From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 11:30:37 -0400
Message-ID: <AANLkTilvz-n-oBzfCChh0qGo3oWVXaB7CZY4562ineDn@mail.gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de>
	 <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
	 <4BF4F7D7.60002@drmicha.warpmail.net> <4BF4FA89.2040904@gmail.com>
	 <4BF4FDB4.2010409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <totte.enea@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 20 17:30:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF7hu-00074w-EB
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 17:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab0ETPak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 11:30:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33725 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab0ETPaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 11:30:39 -0400
Received: by iwn6 with SMTP id 6so4414476iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oQUKJWshi/lOr8ng+S+Z3wEgXNG/2ms7DSamtcgleZM=;
        b=t2vL5Q/lIXQXE7y7Goc+B5k4DU3IrVwm5Agh/Dsrc0UzOj2T7WVtKp/DOtukTewrfJ
         5veyQf5Mxk0kew42AFkYPZGxEGbBuMtld67y46fmoltybunC1SgvicWuvgArT470Uia5
         I5UdVrityoRklTHivO0MhlvV8+XysHmm4V1CI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YanXro4X51GGJPVDbACA3gJQNClTal44aockIO6WN73+ku5v9igY7MHpGd9eibxhOo
         8lmp85zVh5Ym/7KpViUkUAqAvYPKHSCCozN5LgIFnM7pbTvpREIP/FEv1lk2CrHEU4DF
         Wjk88tnveBFcKWI05T/J1q1/FUbX/dVjjO/oQ=
Received: by 10.231.147.18 with SMTP id j18mr199843ibv.12.1274369437680; Thu, 
	20 May 2010 08:30:37 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Thu, 20 May 2010 08:30:37 -0700 (PDT)
In-Reply-To: <4BF4FDB4.2010409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147393>

2010/5/20 Michael J Gruber <git@drmicha.warpmail.net>:
> I remember we had threads on this issue in the past. I haven't checked
> yet (Thunderbird pruned my nntp history), but it is worth checking that
> you addressed any issues mentioned there.

This was the monster thread on it:

  http://thread.gmane.org/gmane.comp.version-control.git/70688

Linus added support for the case-insensitivity aliasing issue:

  1102952 (Make git-add behave more sensibly in a case-insensitive environment,
           2008-03-22)
  6835550 (When adding files to the index, add support for
case-independent matches,
           2008-03-22)

But he couldn't care less about HFS+ brain-damage, so he left that for
others. And hey, it's only taken 2 years for someone to step up to the
plate. :-)

j.
