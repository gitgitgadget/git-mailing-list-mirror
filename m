From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Silent maintenance
Date: Sat, 14 Aug 2010 16:41:11 +0000
Message-ID: <AANLkTi=+veDhBEt-tK_qaXhvMVmRCZtW7+O6ig3ujASz@mail.gmail.com>
References: <20100814131156.GA24769@nibiru.local>
	<AANLkTimZ4df7wVXSGdNm+vWgAuPVDcUupxEvn9FByx=P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt <weigelt@metux.de>, git <git@vger.kernel.org>
To: Valeo de Vries <valeo@valeo.co.cc>
X-From: git-owner@vger.kernel.org Sat Aug 14 18:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkJnJ-0003CV-Ik
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 18:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106Ab0HNQlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 12:41:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39186 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087Ab0HNQlM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 12:41:12 -0400
Received: by gxk23 with SMTP id 23so1430051gxk.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pbQad/Pb6lR1nJBKxD5PpCYn7vr1sLfGkgByUHpa3rk=;
        b=bcR5GJuXIS4raJS4GIh2Z1wJxxVesxSzPzSy+0noLIDxSFX6x1dXn+yvcJs7qPkUHG
         j88vjXFhVHcCJ9XMWQip3Xd+B53ym6uQrB7393cYW8G6Z+y7Ap8kMlTgwYz+PCipyMhQ
         A1ojMZLateQs4zjuKjLQLSLRc1tuEEbBmtDBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dd2lKSkd4sXxCM3sDXEc7+YwEfD2UcLPsjzjG+tzaG88vITCgxMtoiulF37anv4irL
         J6vpQpYhvfPySuFVv0tjQG1x78S2GJ4ftkS5p0Flvsk4yWnzRyQoTHa74EPORf3bBMW0
         CAI3UQ5e4coWTLCpUpYvnvyRtYCLo2RUkRcX0=
Received: by 10.231.31.197 with SMTP id z5mr3341024ibc.80.1281804071520; Sat,
 14 Aug 2010 09:41:11 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 14 Aug 2010 09:41:11 -0700 (PDT)
In-Reply-To: <AANLkTimZ4df7wVXSGdNm+vWgAuPVDcUupxEvn9FByx=P@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153566>

On Sat, Aug 14, 2010 at 16:33, Valeo de Vries <valeo@valeo.co.cc> wrote=
:
> On 14 August 2010 14:11, Enrico Weigelt <weigelt@metux.de> wrote:
>> Hi,
>>
>> are there some flags to make the maintenance commands like
>> git-repack and git-gc silent, so they only output errors ?
>
> Just redirect stdout to /dev/null and check git's return status, as =C4=
=98var said.

It's better to not redirect anything, set a trap that checks if
anything exited with non-zero, and then look at all the output if
anything fails.
