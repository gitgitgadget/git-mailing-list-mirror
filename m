From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: Improving merge failure message
Date: Tue, 8 Sep 2009 08:59:53 +0100
Message-ID: <e2b179460909080059x62eb9d30t4d723d185e6316e3@mail.gmail.com>
References: <20090908153101.6117@nanako3.lavabit.com>
	 <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
	 <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e0909080020i3daa92aar952fc5102df62bdb@mail.gmail.com>
	 <7vk509ev20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 10:00:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkvcR-0002Py-Ru
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 10:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbZIHH7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 03:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZIHH7x
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:59:53 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36923 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbZIHH7x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 03:59:53 -0400
Received: by bwz19 with SMTP id 19so2000769bwz.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Qnp8FGP5UwCPT4KPG9d6wzYfuRRrM3EnchVVM9LQBjw=;
        b=IKf6MDSFo+1WZP0Qq9Rka58707Yt7MppuIOZ7K/JJbWY3zzg7evIrQZ008xaCIclf8
         F+j4pIe11RPno6DlbZP/2Ltl2i3aZN3JGUACfOgAH93qWvuP6dWpZ8kiERp/sMRj9LtY
         Frc1gECIAbpiYxHnu5L2IasUZ1azmgbuG5CY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n8KzWtc89TLDuNYRb+8UHy39AdUV8PLC2xazCwve6o9FLkqR/6s83Q1gUK46RhOerR
         lbs3p5mGm7QX4ax7OOa2yy4W9mu7JhmUvhH/SeFntIAQ6rY/NjatQPIqEdbdpxgA9wWK
         TxKlD7Zb0HxtCo5enlMp2M9gMnEj1BiNtY7+o=
Received: by 10.223.4.150 with SMTP id 22mr5666144far.38.1252396793871; Tue, 
	08 Sep 2009 00:59:53 -0700 (PDT)
In-Reply-To: <7vk509ev20.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127989>

2009/9/8 Junio C Hamano <gitster@pobox.com>:
> I'll leave the exact wording up to other people. =C2=A0My primary foc=
us was to
> end all of these messages with "Aborting."
>
> This turns out to be a continuation of an older discussion thread bac=
k in
> May 2008, and I do not know if anybody took up the challenge back the=
n. =C2=A0I
> wouldn't be surprised if "checkout", which was the topic of the old
> thread, has some other scary plumbing message still seeping through t=
o the
> UI layer. =C2=A0Perhaps there are some other commands that needs simi=
lar kind
> of love.

Just a note that Documentation/git-checkout.txt references this
message in an example and should be kept in step with the final
wording change. It would be ideal to be able to regression-test the
examples in the documentation somehow but that might involve abusing
the asciidoc markup somewhat.

2009/9/8 Jeff King <peff@peff.net>:
> While we're picking apart your wording, is "clobbered" the word we wa=
nt
> to use?

If we're debating 'clobbered', then maybe the non-word 'uptodate' is
fair game too? 8-)
