From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Merge commit subjects git.git
Date: Sun, 18 Jul 2010 17:22:01 +0000
Message-ID: <AANLkTim4FxPdHsDxkRmHzJT24LnZyiv9xLUqbTUndS9T@mail.gmail.com>
References: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
	<201007181733.59704.trast@student.ethz.ch>
	<AANLkTinTOMxWVM9kwhIfcG44SqOjpexY-Xy6kZYkemU9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 19:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaXZG-0007a3-G8
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 19:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754Ab0GRRWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 13:22:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39603 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab0GRRWD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 13:22:03 -0400
Received: by iwn7 with SMTP id 7so3795156iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V3Rwq8jod0M/1Qwvdp96ERmISeJVijyy69toM7DQXzA=;
        b=PgTB+vy2ArnvZb9kffV/bjSol8cSspCHsSHmVIueqUXXfFoELHPKOKveO0oFyjY6JZ
         Q8V1FcxvmcclMijB/6ukQ0w7uu3eseXsYHQgG+9ptI4ZVheSjtE3BZphieikH70wKbkd
         3eG2y4yFraeJYdxO9yIb7OqN1uuJtNef4HfwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K3I4p5VPdUpz6xiZy1CPdd9Ct6KF5HBW1pRm9RgWu5WTwqGFBI7/bgDCJqlt4EwT4h
         EJSwQmu6vFKQ1eYgu/dZUP7iFhM/dPodYuFrmwmuyvGoglWrB6fcxaFYjFWKRZU1h8VH
         wBQwH5oANEa5LoXRITFas6ICP5/7FqJDhehSw=
Received: by 10.231.39.196 with SMTP id h4mr3617371ibe.64.1279473721916; Sun, 
	18 Jul 2010 10:22:01 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 18 Jul 2010 10:22:01 -0700 (PDT)
In-Reply-To: <AANLkTinTOMxWVM9kwhIfcG44SqOjpexY-Xy6kZYkemU9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151221>

On Sun, Jul 18, 2010 at 16:56, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> Heya,
>
> On Sun, Jul 18, 2010 at 10:33, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp("master", current_branch))
>
> Wow, I thought the only place where we gave "master" any special
> meaning was in that we create it as the default branch. Can't we fix
> this to be less hard-coded?

In addition, Ilari on IRC pointed this out:

    < avar> What does git use to determine what branch gets checked out
            (not always master) on git clone URL?
    < Ilari> avar: HEAD
    < avar> Ah, just the HEAD of the remote, but that doesn't help afte=
r
            you've switched branches locally to find out what the main
            is..
    < Ilari> avar: Except that if you have another branch with same com=
mit
             as the one you set to default, either of them may be selec=
ted
             (if one is 'master', then the tie is broken for it).

I.e. master is also treated more magically than others when
cloning. But I couldn't find the code that does this, so perhaps it
doesn't do that.
