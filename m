From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Fwd: [Survey] Signed push
Date: Wed, 14 Sep 2011 21:46:54 +1000
Message-ID: <CACsJy8DKbkryuFo0uHnPUvpkui7+Vm4bS_ki5F7mNx=5UoGGsA@mail.gmail.com>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org> <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <4E7085E6.3060509@alum.mit.edu> <vpqfwjzxu6i.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 14 13:47:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3nwL-0000an-3e
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 13:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab1INLr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 07:47:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45429 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab1INLrZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 07:47:25 -0400
Received: by bkbzt4 with SMTP id zt4so1458658bkb.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Nm72qfJdprt/JjC2MSZc2UuhqhQyy/i2oYKIWxXxbsE=;
        b=pdJTDyQs1w8kgm/b7ZKep4OHv48475E9D5p3m8pQBOIqz9sJGf0EqpJjkHB0zvlAnR
         RKkPwbNyOtRlOKuxJdsztMP/6QfPFqZniAwOxaE5GMSwX8o/MvGAoyKAtMGymyeClKJi
         qliTk6t8yp0EgvmhNF3RqtZQKt2Sd6x4Uc9/0=
Received: by 10.204.133.8 with SMTP id d8mr3004848bkt.235.1316000844177; Wed,
 14 Sep 2011 04:47:24 -0700 (PDT)
Received: by 10.204.7.4 with HTTP; Wed, 14 Sep 2011 04:46:54 -0700 (PDT)
In-Reply-To: <vpqfwjzxu6i.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181352>

On Wed, Sep 14, 2011 at 9:03 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I wish that one could annotate a branch (e.g., at creation) and have=
 the
>> annotation follow the branch around. =C2=A0This would be a useful pl=
ace to
>> record *why* you created the branch, your plans for it, etc. =C2=A0T=
he
>> annotation should be modifiable, because often a branch evolves in
>> unforeseen ways during its lifetime. =C2=A0Anybody could read the an=
notation
>> to get a quick idea of what kind of work is in progress.
>
> Would the notes mechanism be able to annotate ref names instead of
> commit sha1?

Speaking from someone who has few experience with git-notes, no I
don't think current git-notes can do that. But similar mechanism can
be added, targeting ref instead of sha-1. But the question is, is
branch description local or public?

Branch description sounds local to me. I just record a branch's
purpose and status (the latter is more important to me). If it's
local, we just need to extend ref format to store extra text in
addition to SHA-1.

If it's public, perhaps if we have a good way to:
 - convert arbitrary text to a ref (maybe just converting spaces to hyp=
hens)
 - specify a ref without writing the whole ref name (reminds me of
short sha-1 vs full sha-1)

then we could use branch name as branch description. The default merge
commit messages can be updated to convert back branch name (which is
also the branch description) to human-readable text.
--=20
Duy
