From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] Add configuration variable for sign-off to 
	format-patch
Date: Wed, 1 Apr 2009 19:55:43 +0200
Message-ID: <fabb9a1e0904011055u67b3ebfbuae15c8e23d7e5ed0@mail.gmail.com>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net> 
	<20090331204338.GA88381@macbook.lan> <20090401102610.GC26181@coredump.intra.peff.net> 
	<20090401175153.GA90421@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:57:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp4gz-0001zy-Tw
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 19:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949AbZDAR4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754028AbZDAR4D
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 13:56:03 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39674 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbZDAR4B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 13:56:01 -0400
Received: by bwz17 with SMTP id 17so146859bwz.37
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RJ7teZ5YWvPjA6c6Jtmedh46/r8f41Hv9v4FIIK5xFo=;
        b=ReATsVz0LHmgxI8OaefgBB+lyJ7+DtNVoXtoxVjEfTPCbuHHT9dO/u5oRaW5Ww3Tgc
         d0ZxqM/DEZYvjvdbB6UISXxqx6sIYIWboqqSi0krAZ+UT38vPQj+W4Kdk05Fvfr6j5ic
         O+cUj/w/UjzGPHcBWyhAQV38S21ksrFVhDHGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dXN8xV8VCBUwfM1foOk0ZkJNTID61LZBgkein5/7i8beVNL3tBdMiz2H7Ai1U/fLNq
         EIAZW4si3c3OXkySxiJ8LUSz/rivGKBcNhFXkOzbtlHebiJy8bozseModiCrnpS6Fxtt
         cEvHLera4/IqaiQIHFvIoFV2HgxxvCrleDhqQ=
In-Reply-To: <20090401175153.GA90421@macbook.lan>
Received: by 10.103.248.17 with SMTP id a17mr2957701mus.83.1238608558349; Wed, 
	01 Apr 2009 10:55:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115406>

Heya,

On Wed, Apr 1, 2009 at 19:51, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> =A0format.signoff::
> =A0 =A0 =A0A boolean value which lets you enable the `-s/--signoff` o=
ption of
> =A0- =A0 =A0format-patch by default.
> =A0+ =A0 =A0format-patch by default. *Note:* Adding the Signed-off-by=
: line to a
> =A0+ =A0 =A0patch should be a conscious act and means that you certif=
y you have
> =A0+ =A0 =A0the rights to submit this work under the same open source=
 license.
> =A0+ =A0 =A0Please see the 'SubmittingPatches' document for further d=
iscussion.

Which brings us to the question... what about projects that do not
have such a file?

--=20
Cheers,

Sverre Rabbelier
