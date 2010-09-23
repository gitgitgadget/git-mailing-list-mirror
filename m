From: Nate Parsons <parsons.nate@gmail.com>
Subject: Re: git-svn error
Date: Thu, 23 Sep 2010 15:45:49 -0400
Message-ID: <AANLkTi=KGtBJ=6-YWUJCsbmBWfnr1Kh2i=LaZmgM=8t5@mail.gmail.com>
References: <AANLkTi=5ficziLK8cfikotoxkgUDLfhAM_RLzCOcOv5U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Sep 23 21:46:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyrkP-0001Fd-Bn
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 21:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756422Ab0IWTqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 15:46:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57255 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab0IWTqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 15:46:10 -0400
Received: by iwn5 with SMTP id 5so1675279iwn.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=9dQfNPcDqcoRcAad8nQ/jZDbe3+nhmGuCOn3ub/yUBE=;
        b=tpOPrrHzmeT2T5i9CHOxQD/BNd9g/H/RuHuxUL7XxHKrOdLrqp9J1kPX0U6lXWj5WF
         xVTjKBSMyss42sMWKzceznVGpMlH7ed+tNbdbWejHSQ9CfqRiBvdpKniS8ffz+rsjEcH
         Twn53XFHZCzOzo/N4WcqX+JeE1XIfKGM0PSSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=HTe2eqYNT/uOt21iztpxCYiVcRE0+XOpKL7zXOBWIWAe07h+Hidd8R5JSlZ/LtpStO
         bP6f1yvNtikrLY/xzIDe6XF8Qs1JfqIa6I2XIbqJzlakBjk9B3Z/auaEb9aACv1KlJPb
         jiYUSyFL3IALnDouGof6LaiWTBL5jmMnwJS5A=
Received: by 10.231.30.76 with SMTP id t12mr2395583ibc.161.1285271170105; Thu,
 23 Sep 2010 12:46:10 -0700 (PDT)
Received: by 10.231.113.141 with HTTP; Thu, 23 Sep 2010 12:45:49 -0700 (PDT)
In-Reply-To: <AANLkTi=5ficziLK8cfikotoxkgUDLfhAM_RLzCOcOv5U@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156897>

Hi all,

I reproduced the problem on openSUSE, running git 1.7.3. I can't
provide access to the subversion repository, but I can do anything
else to help diagnose the problem.

-Nate

On Thu, Sep 23, 2010 at 10:30 AM, Nate Parsons <parsons.nate@gmail.com>=
 wrote:
> Hi all,
>
> I'm experiencing an error message importing a new svn repository usin=
g
> cygwin git, version 1.7.2.3
>
>> fatal: refs/remotes/trunk: not a valid SHA1
>> update-ref refs/heads/master refs/remotes/trunk: command returned er=
ror: 128
>
> My .git/config file (nothing looks amiss to me):
> [core]
> =A0 =A0 =A0 =A0repositoryformatversion =3D 0
> =A0 =A0 =A0 =A0filemode =3D true
> =A0 =A0 =A0 =A0bare =3D false
> =A0 =A0 =A0 =A0logallrefupdates =3D true
> =A0 =A0 =A0 =A0ignorecase =3D true
> [svn-remote "svn"]
> =A0 =A0 =A0 =A0url =3D <redacted>
> =A0 =A0 =A0 =A0fetch =3D iem/procedures/iem:refs/remotes/trunk
> =A0 =A0 =A0 =A0branches =3D iem/procedures/Z_Folders/*:refs/remotes/*
>
> It appears that this error was seen before in an older version that
> didn't deal with extra "/"s appropriately, but I don't see that issue
> here.
>
> Thanks,
> -Nate
>
