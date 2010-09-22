From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Wed, 22 Sep 2010 18:52:02 +0000
Message-ID: <AANLkTimKp+u2QGhR=zFYTSALcxRUr=LQewYRK83uh+U1@mail.gmail.com>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
	<7vsk11sjf9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:52:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUQQ-0002yz-35
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab0IVSwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 14:52:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64488 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0IVSwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 14:52:04 -0400
Received: by gyd8 with SMTP id 8so285849gyd.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K21yAPxLbCb3EfcRVq2ezDzD9pmMTMs4fESH/fd8B+A=;
        b=pCvFzzkkkEOfJn+cwK/xbE55GmdFOHmNTJ3otzJ9Pgie0vuZYLPdcnhv8Ab0qeKw0/
         ZEDLsXqAMBhAun6UcEJQToAbwfAZtzEHuobEx+glS7AKUVX/kZmr3z202BBdn+Zn5d8W
         W9S3lkMX1IW5PIdAv9qexdAGfvST8YtgL3UOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hwF9kXaL6nXNKdntUYRFZX+j1MYrp5+BZgLvyLB3KY5JfHotxLONnm9oYnYb3Wv7aI
         QlRMElDYmHLQelj9izfXURBaMluY2zpxGKomWXnTHqUAGP4xPBjByBK44eyN38xAELwn
         eaA9BjL3CI65GsAZeKuXimSnmiabvLszuO/UE=
Received: by 10.90.120.17 with SMTP id s17mr966306agc.98.1285181522535; Wed,
 22 Sep 2010 11:52:02 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 22 Sep 2010 11:52:02 -0700 (PDT)
In-Reply-To: <7vsk11sjf9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156823>

On Wed, Sep 22, 2010 at 18:49, Junio C Hamano <gitster@pobox.com> wrote=
:
> $ make doc
> make -C Documentation all
> make[1]: Entering directory `/scratch/junio/buildfarm/pu/Documentatio=
n'
> rm -f cmd-list.made && \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/usr/bin/perl ./cmd-list.perl ../command-l=
ist.txt =C2=A0&& \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0date >cmd-list.made
> No such file git-sh-i18n.txt at ./cmd-list.perl line 10.
>
> Hmm?

Oops, I didn't try running "make doc". I could write a
Documentation/git-sh-i18n.txt manpage, but it would probably be better
to just remove the patch adding it to command-list.txt, no?
