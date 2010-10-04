From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 6/6] tg-log: short cut to git log
Date: Mon, 4 Oct 2010 08:45:31 +0200
Message-ID: <AANLkTi=sc-FBG=CeNTv9H4Fj0KqdHkoudjQHqEYZxPuV@mail.gmail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
	<1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-4-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-5-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-6-git-send-email-bert.wesarg@googlemail.com>
	<AANLkTi=Kwx5avY7xRdWLS931zK2fi7cj5Q8u3++bqRO+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olaf Dabrunz <odabrunz@gmx.net>, Peter Simons <simons@cryp.to>,
	martin f krafft <madduck@madduck.net>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	git@vger.kernel.org, pasky@suse.cz,
	Thomas Moschny <thomas.moschny@gmx.de>
To: Per Cederqvist <ceder@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:45:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2enp-0004Lx-JA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab0JDGpd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:45:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64871 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab0JDGpc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 02:45:32 -0400
Received: by iwn5 with SMTP id 5so6529082iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b9uU4Wvpv1EBZ19/53owtAHIJyYABrjPalsxjDQXVsk=;
        b=gSdkREi8OTuvyEYbk3mdy4l0myP5QvKvfyxp8gvUMlHzmVDh91NYujI3xOlxWgyXml
         e/I80/bBv9tXT+lM8Q/q4HXVOMnyeUMoGnz5w+mAyzoGckp0jxmu3Jjqb/2pZ01efZ2O
         xKM4wewBcqO8DvFhWkvwgCgv2e2Fzg9uHMgjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x7znbiguOlqpMbPnHxkY+tRvxLx2jFJgxn5vbTT9AOZcKdXfMsgA9z89RK4YciBkQm
         7gXLkh4OM4dBxKNA067LmsLa1GwxyQdiRBEffskOXctwZNLQRnSxxn6xvymlpA7aKiW5
         jyh4DCFGYI9UBpO+2oc7mbqUNvYq+1RjL5rjs=
Received: by 10.42.4.197 with SMTP id 5mr11580009ict.42.1286174731951; Sun, 03
 Oct 2010 23:45:31 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Sun, 3 Oct 2010 23:45:31 -0700 (PDT)
In-Reply-To: <AANLkTi=Kwx5avY7xRdWLS931zK2fi7cj5Q8u3++bqRO+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157986>

On Mon, Oct 4, 2010 at 06:40, Per Cederqvist <ceder@lysator.liu.se> wro=
te:
> Using --first-parent to get only the interesting commits only works r=
eliably
> when you only work locally. If you collaborate and you and your partn=
er both
> make a commit before you push to a central server you will have to ma=
ke a
> merge, where both parents are interesting.
>
> I wish that git remembered which branch a commit was initially made o=
n. That
> would make "tg log" easy to implement correctly. But since git doesn'=
t, I
> don't think it is possible to implement it properly.
>
> At least, a warning should be added to the README.

I've read it from your tg base help message and have no problem to
copy/move it to tg log.

Bert

>
> =C2=A0=C2=A0=C2=A0 /ceder
