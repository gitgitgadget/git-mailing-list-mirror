From: Miles Bader <miles@gnu.org>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 6 Dec 2010 18:13:06 +0900
Message-ID: <AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org> <20101206082948.1403cc5a@chalon.bertin.fr>
 <buopqtfmi85.fsf@dhlpc061.dev.necel.com> <20101206092122.21c19011@chalon.bertin.fr>
 <AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com> <20101206094806.10ae1ff2@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Dec 06 10:14:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPX94-0006bf-N0
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 10:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab0LFJNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 04:13:49 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55438 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab0LFJNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 04:13:47 -0500
Received: by fxm20 with SMTP id 20so3982161fxm.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=o9RTjI0Fv1vKhmVXP5kv10AW3vDUespbQb56tzJvhyU=;
        b=Q5kWdcBFCSvSIEH8I16LScPLZZkJmYYXMMlaUc7QOhplPULowc8KFA7C94Ozn3hrcL
         dPPvKUNXelTIONeirAZ1a6ouz+Ywsu4SLMzpqPrxHrHq9ItCet+xn3YrYm94V4kLlbvy
         bBu1E1wweN+VYe/kgmt+jxKayeLPCBlNTuZ+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=saBPIgb+2l6JXL1i4cFagZAAA0XVAa/lMm+cJ2qewBMFT5h87332MLZTCBURsll4i4
         WgzF4mAqVZR7j1to9/x7YOJu4TjawLlQfAFu7r/cZYuQJgO9mWDMTrBnvRpFzAyYh9o1
         TKk9ZVxeIELlYqFx5WlAbMtAsDnV9YqRx2LoM=
Received: by 10.223.103.2 with SMTP id i2mr5290200fao.115.1291626826495; Mon,
 06 Dec 2010 01:13:46 -0800 (PST)
Received: by 10.223.96.80 with HTTP; Mon, 6 Dec 2010 01:13:06 -0800 (PST)
In-Reply-To: <20101206094806.10ae1ff2@chalon.bertin.fr>
X-Google-Sender-Auth: MLiB29GlcSx7l6hYLcrg9xMLtHM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162988>

On Mon, Dec 6, 2010 at 5:48 PM, Yann Dirson <dirson@bertin.fr> wrote:
> In the end, I still think the implications for the usability are what
> matters, more than arguing about a subtle nuance of vocabulary.

There is no "usability" problem.

it's is normal and good that option names are sometimes revisited and
improved -- nothing is perfect on the first try.  By keeping the old
option around as a deprecated alias, we avoid compatibility issues.
That doesn't mean there aren't _any_ issues, but they tend to be
pretty minor  (such as the "space used by the deprecation option" that
you complain about).

Maybe if you renamed every option simultaneously, there would be
confusion, but seriously, it's only one option.  It's not going to be
a problem.

-Miles

--=20
Cat is power. =A0Cat is peace.
