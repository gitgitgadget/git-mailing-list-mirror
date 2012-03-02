From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Google Summer of Code 2012... and git wiki
Date: Fri, 2 Mar 2012 11:26:54 +1100
Message-ID: <CAH5451kip7Fp8m7Ow3=E_+HvhyOanjZYietVXV1_A8pRh-We7A@mail.gmail.com>
References: <201203020027.41016.jnareb@gmail.com> <CAP2yMaKw8dx+fsy2Kbh2XUORu+b7CiA+qzZDcK05zsv3m5-bww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 01:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3GLB-0001XS-7v
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 01:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab2CBA1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 19:27:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab2CBA1P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 19:27:15 -0500
Received: by wgbdr13 with SMTP id dr13so1062827wgb.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 16:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=LvjlGv9DZU/ETXqpdX8mxEk/z2PLx521wbhr3hd13tI=;
        b=q6Tb+N+pn8Rp02Ve/Lcg+Xs2XJtav540V9UVlUpuZpk8GEHOsYEig/obmM6KSMr3Km
         irWv8ueT/4W8JNsDo15GT+j9VheHka8HiK2LXcpnVK44aMSM/fNQKp8+uxJ4SG48Nvs/
         sdbQbsnECblyLpPBnmGrkgiKiMc7UJh69s4Kmg8FwOOdROhroD2b7SRuxX0DvPnslNWz
         zRESEldI3v9Z085JrBanhRg6GLG4A+X6EfcbhlEF7Ucx8DucrZIomqBzlP4nAzyN7rYC
         2QnVD079ZEW3Kca9hwvTrH7IkhjlLcd+5XXXC56V+WirHNL3qD7VoWGibenqzudcyXsd
         Vykw==
Received: by 10.180.93.232 with SMTP id cx8mr130522wib.14.1330648034348; Thu,
 01 Mar 2012 16:27:14 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Thu, 1 Mar 2012 16:26:54 -0800 (PST)
In-Reply-To: <CAP2yMaKw8dx+fsy2Kbh2XUORu+b7CiA+qzZDcK05zsv3m5-bww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191990>

On 2 March 2012 10:33, Scott Chacon <schacon@gmail.com> wrote:
> Hey,
>
> 2012/3/1 Jakub Narebski <jnareb@gmail.com>:
>> Google Summer of Code 2012 has started. =C2=A0The Git Development Co=
mmunity
>> has time till March 9 to submit organization application.
>>
>> The problem (beside finding volunteer for the position of GSoC
>> administrator) is that both GSoC application and ideas for GSoC
>> projects were hosted on Git Wiki... but Git Wiki is still only paria=
lly
>> functional, available only as static pages under changed URLs.
>>
>> I guess we can get by without having fully functional wiki for creat=
ing
>> application (if we decide to apply), but it would need a forum to se=
nd
>> ideas for GSoC projects and some place to publish them. =C2=A0Editab=
le wiki
>> can work as both, though git mailing list and some static page (perh=
aps
>> home pages for git project on GitHub?) could also work.
>>
>>
>> I don't know what are ETA on bringing Git Wiki fully up, but I doubt=
 it
>> would be possible at http://git.wiki.kernel.org -- it is more than t=
wo
>> months since the event and wiki is not functional yet. =C2=A0Perhaps=
 it
>> could be hosted at git-scm.com somewhere - =C2=A0but it really shoul=
d be
>> true wiki, editable without need to use git.
>>
>
> I can probably set something up there, but I'm not sure if I can
> import everything. =C2=A0In the longer term (a month or two) I will h=
ave a
> full wiki import running on that domain, but in the next few weeks we
> might want to just setup a temp wiki somewhere to pull together the
> ideas and I can link to it from git-scm.com

I'm not at all sure if it is what we want in general, but it is
extremely simple for me to spin up a Confluence wiki side-by-side the
JIRA instance. If we need something now it can be done in a matter of
minutes, not sure of the feasibility of using it long term (I think it
could work long term, but I am not pushing for that at all).

There are numerous ways to export data from Confluence, but if we
anticipate that being an issue we should investigate before using it.

In fact, it's so easy to enable the Wiki that I have gone ahead and
done so, in case you want to investigate it.

Regards,

Andrew Ardill
