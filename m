From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.5
Date: Mon, 25 Apr 2011 02:00:28 +0200
Message-ID: <BANLkTikhkCDZ5Crw+KGWBprXd6qoFOH8kg@mail.gmail.com>
References: <7v39l7mlwh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 02:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE9F2-000386-CE
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 02:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab1DYABL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2011 20:01:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34697 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791Ab1DYABJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2011 20:01:09 -0400
Received: by vws1 with SMTP id 1so1466953vws.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=gEHanyQuBuz5b270u3PC4SWV7IcLfwqpJoxvAusyudA=;
        b=dfH5+gjwKa+bvdUYLn33H2IhFrcMotM5jLwm4ePYhdxBWwyDMRhsCDAaHfPDQC5CPX
         R/CPCRANgk/XkoSMC2kKUQTRcJ9BQ/PRw2OrDbXItrhNgqxi9vEbNIYfNwQyI6y8qktG
         sqABWeCHSGLe1AhVl1CuquuToJ+DfUYm1dYv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=utjJLYrXiOBy96w9O7r9dme/uACFmT1fDrrbK118FOMLgWaH5Hi8/QXlFjMJ+PNbOz
         PvGhpbWHxbDwOV1cMzu2/DT/xHoKmJ9FQrmxmakEA0HhhFOuY9o31VbPf2X94NBztIsF
         LpkceUCXQ6xbxJIXCgQv6dSsaY7sdLUFjEFwM=
Received: by 10.52.92.161 with SMTP id cn1mr5337206vdb.253.1303689668156; Sun,
 24 Apr 2011 17:01:08 -0700 (PDT)
Received: by 10.52.169.170 with HTTP; Sun, 24 Apr 2011 17:00:28 -0700 (PDT)
In-Reply-To: <7v39l7mlwh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172007>

On Sun, Apr 24, 2011 at 22:31, Junio C Hamano <gitster@pobox.com> wrote=
:
> The latest feature release Git 1.7.5 is available at the usual
> places:

Great! Thank you for this new release. Btw, I've some questions, sorry
if these seem like frivolous or stupid questions.

> =C2=A0* The codebase is getting prepared for i18n/l10n; no translated
> =C2=A0 strings nor translation mechanism in the code yet, but the str=
ings
> =C2=A0 are being marked for l10n.

Where are pot files for Git and Gitweb?

> =C2=A0* "git checkout --detach <commit>" is a more user friendly syno=
nym for
> =C2=A0 "git checkout <commit>^0".

What is the interest?

> =C2=A0* "git checkout" performed on detached HEAD gives a warning and
> =C2=A0 advice when the commit being left behind will become unreachab=
le from
> =C2=A0 any branch or tag.

No sure to understand, it's not already the case?

--=20
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche (agile, lean, python, git, open source)
