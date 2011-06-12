From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Sun, 12 Jun 2011 18:18:49 +0200
Message-ID: <BANLkTimHhaLu2ZGFG4ev_jWMu8szH8r=+g@mail.gmail.com>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 18:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVnO0-0006Bz-4D
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 18:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab1FLQTa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 12:19:30 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61297 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab1FLQTa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 12:19:30 -0400
Received: by qwk3 with SMTP id 3so1899203qwk.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=BEIANUkLvktGG7/wYrXC0i25zy9QIpjsSJ4Y+eIquwY=;
        b=ZiQRErR6GtIXAPJToMdTqHp6y9qPIRMqCKnbrksCoe4BP9ACEJiJFFPkrj/hfLzl2k
         fEauP5MrVpq/qIS7/RIiEV+t48cxfWGfYuixqyWAoAcw276IF8brPQUu5KnGaJee/2p8
         bHhlNULQPO59hLlT+yGNVvChmG7O160m18AF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xrvGNWvHvTj+HLuIUG0qmwwr7HM8FlwyRXJrx/RY/j6ayIkDdIIALmgnZwhKtCXVq4
         is23XzzUCVL7ja6kj+BTAyyCvSIob1rJtSnF6OtYp61DaWEXXj/XjugGTfFZ0EcXBW8h
         MKBp+ESEByeR7G5BUCH3Lf1+XL612r1XXT7+k=
Received: by 10.229.40.207 with SMTP id l15mr3100070qce.281.1307895569120;
 Sun, 12 Jun 2011 09:19:29 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Sun, 12 Jun 2011 09:18:49 -0700 (PDT)
In-Reply-To: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175661>

Heya,

On Sun, Jun 12, 2011 at 08:49, Junio C Hamano <gitster@pobox.com> wrote=
:
> * jk/transport-helper-fix (2011-06-07) 8 commits
> =C2=A0- git_remote_helpers: push all refs during a non-local export
> =C2=A0- transport-helper: don't feed bogus refs to export push
> =C2=A0- teach remote-testgit to import multiple refs
> =C2=A0- teach remote-testgit to import non-HEAD refs
> =C2=A0- t5800: document some non-functional parts of remote helpers
> =C2=A0- t5800: factor out some ref tests
> =C2=A0- git-remote-testgit: exit gracefully after push
> =C2=A0- transport-helper: fix minor leak in push_refs_with_export

Note that I sent a reroll of this series (of which I'll send another
version soon) which is a little more elegant in some places.

--=20
Cheers,

Sverre Rabbelier
