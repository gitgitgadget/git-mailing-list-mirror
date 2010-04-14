From: Aghiles <aghilesk@gmail.com>
Subject: Re: git log of remote repositories.
Date: Wed, 14 Apr 2010 15:08:25 -0400
Message-ID: <x2q3abd05a91004141208x6e154385l8b7ce6488d65f21b@mail.gmail.com>
References: <u2n3abd05a91004131625k500e79bbsc8ffa6455a85332d@mail.gmail.com> 
	<slrnhsba0k.h9q.heipei@dualtron.heipei.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:08:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O27xI-0003h4-1e
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0DNTIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:08:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52426 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0DNTIq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 15:08:46 -0400
Received: by wyb39 with SMTP id 39so78591wyb.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 12:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=wJAO9UN1sxlgbSFW3zf1freWfKSWrr/tGEpSL4GuWms=;
        b=MoR8fAmt3za2VMEGe1fsszapfOzarlokHLpKR4UR2FKgqYdbqYkIqsNbWHwsiWVbHM
         quKiqOEQplLQwRWe4eO9NBobam5YpAIfiASRtH0w9w3S/US7TuAiipesVcc2acV+eR3q
         LqQK3IZ5e3jsyxUwcU22f/FWoy8V0sdiaM6AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kTdAcQmYd5gpybmJeAIEmQ9dPo4dwUDVIpOwt1YNwspjiBaQdf5VCek5veo0p4kKAU
         SioM3OzY45gSNcXb1XPol48Eb5ocad/LZSxOuCRTPGSX3UTh9XXWG3HYL43I81rhXZXA
         NtkMUYqrXb9kYjUeieBZfYZ7+jIZ5oROJz+1o=
Received: by 10.216.157.212 with HTTP; Wed, 14 Apr 2010 12:08:25 -0700 (PDT)
In-Reply-To: <slrnhsba0k.h9q.heipei@dualtron.heipei.net>
Received: by 10.216.171.7 with SMTP id q7mr236291wel.40.1271272125194; Wed, 14 
	Apr 2010 12:08:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144891>

On Wed, Apr 14, 2010, Johannes Gilger  wrote:
> AFAIK no, the operations have to be local.
>
> In order to see if there are any new changes to be pulled you could do
> this: git fetch --dry-run

It seems to me like a major restriction! Especially that I am tracking
a remote branch ... No possibilities to do a diff or a log without fetching?
Very sad. :(

  -- aghiles
