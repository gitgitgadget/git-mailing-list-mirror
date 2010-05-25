From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [GSoC 2010] The 1st week
Date: Tue, 25 May 2010 16:58:11 +0800
Message-ID: <AANLkTilEoK-CZR8C16ageafSnA_TNyp3nXHVAm67_LS3@mail.gmail.com>
References: <AANLkTikSafHBj7VwjwjTVeW3ohL60dOp4sKfZW_vZzCM@mail.gmail.com>
	 <20100525062457.GB10898@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 10:58:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpxr-0004TE-D0
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab0EYI6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 04:58:14 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:57802 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0EYI6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 04:58:13 -0400
Received: by qyk13 with SMTP id 13so6918762qyk.1
        for <git@vger.kernel.org>; Tue, 25 May 2010 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wkKwdQbDU34jHeC63nz5lS1N8POZNNL350oqOHJFO6c=;
        b=ZwrRNwKomY7S2068Z2YGRhGzqJ1oOLLd+qFkyVdT0Mb1gpkU9Fz+sIk9Ef8NL4VPWO
         vAXLmEoEfDFxXQrIaj8OCmDiVPAJlH5zBdVLYd+Mq+MGVkRXauCZGGm8kHZibyKBdQpH
         OU8VNP7bmuvUZEY2auQClrXPG+PE6AMj0DsaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lIkjf4bpqMHa9ULfwGujcC5O6UqBfuuAtMXXRal9lmN//KwVJmfwCC/NiXR2ZNQzOK
         xVLFMwtpXQt1elojnyJo2YZqmIZrFZQjT13KwyXf59PmFGTVkB63X3tn1WohZm8+Q6HX
         Y2giOMgnq9NWzA+GSHB8c4DeDmzgYWCl3yqyk=
Received: by 10.229.250.2 with SMTP id mm2mr1364294qcb.108.1274777891490; Tue, 
	25 May 2010 01:58:11 -0700 (PDT)
Received: by 10.229.110.18 with HTTP; Tue, 25 May 2010 01:58:11 -0700 (PDT)
In-Reply-To: <20100525062457.GB10898@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147687>

On Tue, May 25, 2010 at 2:24 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 24, 2010 at 10:57:15PM +0800, Bo Yang wrote:
>
>> What's done:
>> 1. Get familiar with Git code base and have read the code of 'git
>> blame', revision walk, 'git log'.
>> 2. Try to make some patches for git:
>> =A0 =A0 1. * by/blame-doc-m-c (2010-05-06) 1 commit, in 'next'
>> =A0 =A0 2. * by/log-follow (2010-05-10) 4 commits, in 'next'
>> =A0 =A0 3. the '--graph improvement', in discuss and I think ready f=
or inclusion.
>> 3. Start to write some code for the line level browser feature. And =
it
>> is in the 'playaround' branch in http://repo.or.cz/w/line.git . Now,
>> the code can parse multiple line ranges for multiple files in only o=
ne
>> revision.
>
> You didn't mention
>
> =A04. Contributing to other discussion of --follow on the list.
>
> It is a small thing, perhaps, but I am very happy to see a GSoC stude=
nt
> actively participating in the community.

Thanks! :)

> Speaking of which, I haven't finished polishing the --follow patches
> from our earlier thread. I was taking a look at making history
> simplification (including --parents) work. Are you going to be doing =
any
> work on that this summer? If so, I will probably just drop it for now
> and let you deal with it. :)

Yeah, the line level browser will touch the parents rewriting things
and I think the feature of line level history is a super-set of the
'--follow' things, so you can leave it with me. And in my plan, I will
complete this in next month. :)

Regards!
Bo
--=20
My blog: http://blog.morebits.org
