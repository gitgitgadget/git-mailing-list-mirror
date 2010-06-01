From: Roy Lee <roylee17@gmail.com>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 1 Jun 2010 15:55:50 +0800
Message-ID: <AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
References: <1275369711233-5124575.post@n2.nabble.com>
	<4C04AC1E.7040502@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 09:56:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJMKZ-0004wn-1a
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 09:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab0FAHzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 03:55:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57365 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab0FAHzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 03:55:52 -0400
Received: by gwaa12 with SMTP id a12so3335485gwa.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=7D+0QfkHOgBJOEXv8WaTnE6RygSvBTYWfPj9HNWJY8k=;
        b=pYc07LN6S3X6khG/zuu27Rzdcuunk66g3fbcsLiKJX+3rPt+l+IaWPJhjk7VyZZS9F
         bvW5H3GdXu3rIFhDdHTBtRxNArLLIZgccrFKK2GYeEeTkYOJMH5myzrbuKtvG7UUy3FE
         vI1ub94ck1pvl5p7O2KRVNk0UWdKwX7hxzzHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=a/k3DB1L3RrpbnnKYELZeZt27zce6/DugM6d8hYlXX+kQMtDcalGa+HofFcuGfHtM/
         NTe270McneXmsjRL7vhAa6wooupgRjo8a5veMB9zBaUdY2a+InY9FVKBUT9AEUNZa3o0
         7kDQulBcEOunZVfgGh6CcMwXyUpHHq/vQbhH4=
Received: by 10.231.147.143 with SMTP id l15mr7374292ibv.9.1275378950829; Tue, 
	01 Jun 2010 00:55:50 -0700 (PDT)
Received: by 10.231.33.69 with HTTP; Tue, 1 Jun 2010 00:55:50 -0700 (PDT)
In-Reply-To: <4C04AC1E.7040502@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148088>

Hi Michael,

>
> Having these tags seems strange to me. Imagine someone pushing a patch
> series one-by-one around midnight, or pushing a commit and, shortly
> after, a fixup. You'll end up with a tag pointing to a commit in the middle.
>
> The commit time is totally unreliable, as you noticed, also because
> authors may commit locally, then push later.
>
> That being said, if you're really interested in the state of a branch on
> the central server at a certain point in time it's easiest to enable
> reflogs on the central repository (by setting core.logAllRefUpdates or
> enabling individually) and to tag the commit HEAD@{datetimespec} (or
> branchname@...). No need for cloning.
>
> Cheers,
> Michael
>

This is what I'm looking for. Thanks a lot.

But I have another question:
How to use the refspec to refer to the reflogs?
Or any alternatives for developer to query this information.

Regards,
Roy
