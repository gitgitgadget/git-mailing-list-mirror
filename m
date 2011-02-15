From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 0/2] CHERRY_HEAD
Date: Tue, 15 Feb 2011 17:13:30 -0500
Message-ID: <AANLkTin-9g9Ux=_oKBMuB+Yp-bOtBCTjqMWU7ENctXdM@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <AANLkTik2NM+mxKgZy_9dCwydz+An4sFM_a4U9mdrJBq3@mail.gmail.com> <7vk4h1lzjj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 23:14:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpT9s-0006eL-Mh
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab1BOWOD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 17:14:03 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51801 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865Ab1BOWOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 17:14:01 -0500
Received: by iwn9 with SMTP id 9so658111iwn.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=bzcFkbVEWZGRJBSP9TwCJVh8SKheTSTye6U5WHlMLfw=;
        b=UeQYxT2IxNRr/sJhnu53/NTv7xpUZ+FI8WUk9GDi2037lKrbDjKQlBp39l/5FVaF9U
         uC7UuOF6ErF799AIdqwRZUtlVvKUT/L7WAbOFhxOiWbXqC3tGhaxJ7MkiTY+pGF9s805
         gYk8MfDF0WCJmQVJtDsgjcmn2uvh+tl4XBYAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vwDQcHi0f1B60dPFFCsrkLlE6XIufdyuJFyGOqEUW+3BfCRcx+LDHmFejh0nYxc2Sp
         2wAmJMLnmRhwVf1oCPpNoJ7qN771KijqKs3oYzhEuAgy0FLaPPZ8qAY14t9uuVFkUrqr
         dhJdsO5R1Brq/VQie5URd1f3ZBGQM3WA1gS6k=
Received: by 10.42.230.74 with SMTP id jl10mr7478399icb.177.1297808040658;
 Tue, 15 Feb 2011 14:14:00 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 14:13:30 -0800 (PST)
In-Reply-To: <7vk4h1lzjj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166886>

On Tue, Feb 15, 2011 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I've read this over, haven't run it, but I really like the idea. It
>> sucks that you have to save away the commit sha1 somwhere after a
>> failed cherry-pick to use it again. It should just behave like `git
>> rebase --continue`, which this implements.
>
> I don't understand. =C2=A0What do you think rebase does to be able to=
 continue?
> Doesn't it have to save the commit object name away somewhere?

I took it to mean that the behavior after a conflict should be 'add'
followed by 'cherry-pick --continue', not 'add' followed by 'commit'.
Not that I disagree, but that's a lot more work, see my reply to =C3=86=
var
just before this.

j.
