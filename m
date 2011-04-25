From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.5
Date: Mon, 25 Apr 2011 03:32:45 -0700 (PDT)
Message-ID: <m3oc3uwrja.fsf@localhost.localdomain>
References: <7v39l7mlwh.fsf@alter.siamese.dyndns.org>
	<BANLkTikhkCDZ5Crw+KGWBprXd6qoFOH8kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJ66-0003sD-Sk
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258Ab1DYKcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2011 06:32:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45392 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758151Ab1DYKct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2011 06:32:49 -0400
Received: by bwz15 with SMTP id 15so1527344bwz.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=j1ofDBdh8u54HgxrQWMyPi/5FcJRbzZXwtZziXVS3jk=;
        b=Kd8WkaUFduDTINBUn3Jq+Et0jjrmaKLskX2xWuIVGc0P5MV3b0Ygh8pPTd2I611d2b
         qKAcqy+TjQFEYyNc8FP7+05O2T0y7rVsZ176BIbgy+f8GQDIIOWn7fz7HuJdzQejqM06
         55zyUGWKeiTC+PX3pW5oP2Svu+0FhgOuGvhl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=t25VnKGp0Nzyvig5wrotZcKnAMw7qLu/Co/OSHo5VrUnFnwUeFuaQDcahMw7CNBqXA
         /GQMTLDaqQEEEp0tXBn9noJIwMt212yM9F+7Y8KQmSdNvtW5+rV4DxOYLUvJqu1oj2IN
         11aVfT1UZF2KZ07pWwh8gKTDvBUyyFM1DTV0Y=
Received: by 10.204.143.141 with SMTP id v13mr3287308bku.203.1303727568022;
        Mon, 25 Apr 2011 03:32:48 -0700 (PDT)
Received: from localhost.localdomain (abwn49.neoplus.adsl.tpnet.pl [83.8.237.49])
        by mx.google.com with ESMTPS id q25sm2387912bkk.10.2011.04.25.03.32.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 03:32:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3PAWAvN019379;
	Mon, 25 Apr 2011 12:32:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3PAVsxR019339;
	Mon, 25 Apr 2011 12:31:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTikhkCDZ5Crw+KGWBprXd6qoFOH8kg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172020>

Sebastien Douche <sdouche@gmail.com> writes:

> On Sun, Apr 24, 2011 at 22:31, Junio C Hamano <gitster@pobox.com> wro=
te:
> > The latest feature release Git 1.7.5 is available at the usual
> > places:
>=20
> Great! Thank you for this new release. Btw, I've some questions, sorr=
y
> if these seem like frivolous or stupid questions.
>=20
> > =A0* The codebase is getting prepared for i18n/l10n; no translated
> > =A0  strings nor translation mechanism in the code yet, but the str=
ings
> > =A0  are being marked for l10n.
>=20
> Where are pot files for Git and Gitweb?

Actually only programs in C and shell scripts are prepared for
translation.  Currently there is no infrastructure for translating
scripts implemented in Perl... including Git.pm module and gitweb.
=20
> > =A0* "git checkout --detach <commit>" is a more user friendly synon=
ym for
> > =A0  "git checkout <commit>^0".
>=20
> What is the interest?

What do you mean?  "git checkout <commit>^0" is quite cryptic way to
detach HEAD, and requires deeper knowledge of Git... though I am not
sure why somebody not knowledgeable in Git might want to detach HEAD
explicitly at given commmit / branch.

> > =A0* "git checkout" performed on detached HEAD gives a warning and
> > =A0  advice when the commit being left behind will become unreachab=
le from
> > =A0  any branch or tag.
>=20
> No sure to understand, it's not already the case?

It is reworked to show warning and advice only when it is really
needed.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
