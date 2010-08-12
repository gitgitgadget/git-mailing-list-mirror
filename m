From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Can Git work for us if we are remotely hosted?
Date: Thu, 12 Aug 2010 14:29:56 -0400
Message-ID: <AANLkTinv1qt+vXH0gMpxBKsm-u9EGL2LEWVrRQDyrqhr@mail.gmail.com>
References: <AANLkTin4JyZhmjm_1c4q7kjP0eXzA-_2eNsLzsnGASet@mail.gmail.com>
 <AANLkTi=GDj47jieVL4+0YD1X5pa+9g7=c2wRx_T3CDVS@mail.gmail.com>
 <AANLkTimxYgAwWWoJCxsQ_Rr-eGfWJWoL4Qscw3FBYk9_@mail.gmail.com>
 <AANLkTin_qwk9FxkhVkvfQyc0AFXOKfKX-b+BzgXas_CW@mail.gmail.com> <AANLkTi=wa_xdheoKDPr=rfugttpu56s-sd3Q6qFgBALL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sultan Shakir <sshakirflhosp@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 20:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjcXo-0007Gr-DL
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 20:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760715Ab0HLSaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 14:30:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42121 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0HLSaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 14:30:18 -0400
Received: by wwj40 with SMTP id 40so1892903wwj.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yWmIBca1cE6/iP/fTa3scb/WxlH4VdTfJ62wIlR6rv0=;
        b=b83SRCxPcIL6PDgEMqWG7pL9QBMbbC3vOMANnlYy9rUnzs4nv463JZlbi02CVJuP5o
         D5boX47Toubz37U/hCklTl+ALFUH5bg2BlBEl3s9vAT/S4SO2CxX4qjKAyudRl7QQqtV
         QLpz89SPrfIRVk8JVo44W6R67XqOzt1xAIReg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d0ovaR0EZ6NuQ9sPn+zT/3GLYzInvG2q1HTGtBZx0cDcSTSjcfC75KCrRUVKaI8KE+
         hHQQmjnE7ah/jtxOuKyUqj9cpbpcevHDB/rDXz3WR0MMnPre9rvLPXEYZFxypIJEYhKL
         BDpErYx02AkLPkm/gK8PY5/8nBLIZGHs+a8Ds=
Received: by 10.216.4.19 with SMTP id 19mr252059wei.110.1281637816425; Thu, 12
 Aug 2010 11:30:16 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Thu, 12 Aug 2010 11:29:56 -0700 (PDT)
In-Reply-To: <AANLkTi=wa_xdheoKDPr=rfugttpu56s-sd3Q6qFgBALL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153399>

On Thu, Aug 12, 2010 at 2:22 PM, Sultan Shakir <sshakirflhosp@gmail.com=
> wrote:
> On Thu, Aug 12, 2010 at 2:08 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> You said you have "access to the backend where the files are stored.=
"
>> Surely that's on a fileserver, like a Windows file sharing service o=
r
>> a samba server or an NFS server, right? =A0Any of those are capable =
of
>> holding a git repository.
>>
>> git is much faster if you store files on your local machine as much =
as
>> possible. =A0But you can push/pull from a shared repository on a
>> samba/NFS/whatever server and that generally won't be a performance
>> problem.
>
> Thanks Avery. =A0Wouldn't this defeat the purpose of using Git since =
we
> can't really run nor can we compile files on our local machines?

I don't know; you didn't say what was your purpose for using git.

You can run git directly with files on a network drive, but it'll be
much slower than it should be.  You might argue that *that* defeats
the purpose of using git too, since of the best features of git is how
fast it is :)

Have fun,

Avery
