From: Roy Lee <roylee17@gmail.com>
Subject: Re: How to add daily tags for a central repo?
Date: Tue, 1 Jun 2010 16:25:54 +0800
Message-ID: <AANLkTinHU5z5njEpx1S_6DIR5ECauJbzWlcM95wNUVxf@mail.gmail.com>
References: <1275369711233-5124575.post@n2.nabble.com>
	<4C04AC1E.7040502@drmicha.warpmail.net>
	<AANLkTim02FQ3BfV88iylMqbHA5sBbJvp5TmWg52OXCzn@mail.gmail.com>
	<4C04BF33.70300@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 10:26:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJMnX-0006jh-MW
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 10:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab0FAI0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 04:26:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48580 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab0FAIZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 04:25:55 -0400
Received: by iwn6 with SMTP id 6so701306iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=noQ8sIWkqx6301FRMP+VJvoJB15bK7YZyYmCPzuLWc0=;
        b=cTgKoNL6zBhjWKCxRl3PyCo9XzYMsLSR3V804QX3qKcnh2LFCpARz2TwD34+snqy3C
         PHqtnJQR/TTbASYTvG+deqvKlDPmMRgsW3sWot8I+i5ZykNSZKWUcEgNC6u6hDUH3GGK
         OmZkJm8zilzhCEJFMFm0g2I41lsy6V7VOfWIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mhMV1/Uu9wwRUPW4M7+KTOjc0pIIwxenRHwULIbn6r/GUG73JKBggSr5bjPMoeSBRM
         noFEB68WadWA1qstTv0CCl/f5R515n2kt6jEe03/ZvTHDVfno2MJjGcTFvyr749gGGXI
         4jkCPTYGYWMjPfd2nIjBqUlrD8Sz/S1fv7rG4=
Received: by 10.231.193.93 with SMTP id dt29mr7347814ibb.71.1275380754382; 
	Tue, 01 Jun 2010 01:25:54 -0700 (PDT)
Received: by 10.231.33.69 with HTTP; Tue, 1 Jun 2010 01:25:54 -0700 (PDT)
In-Reply-To: <4C04BF33.70300@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148090>

On Tue, Jun 1, 2010 at 4:05 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Roy Lee venit, vidit, dixit 01.06.2010 09:55:
>> Hi Michael,
>>
> Well, as I wrote: HEAD@{datetimespec} for the HEAD,
> branchname@{datetimespec} for a branch "branchname". datetimespec is
> decribed in git rev-parse's manpage but can be what you'd think (e.g.
> "date time") and more ("yesterday").
> If you really want to inspect the reflog (not the commits listed in the
> reflog) use "git log -g" or, unsurprisingly, "git reflog".
>
>> Or any alternatives for developer to query this information.
>
> The reflog is local to the repo, which is why you would create tags on
> the central repo based on the reflog there, if that is your "trusted
> time and push reference source".

Does this mean the tagging must be done on the server?
Is there any way to query this information from a client repo,
do the tagging locally, and than push the tag back to the server?

Regards,
Roy
