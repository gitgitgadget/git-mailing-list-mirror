From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Fri, 25 Mar 2011 10:06:11 +0100
Message-ID: <AANLkTim4aQQgm290Z+OfHd7+oz8jQ_UfWQdxPdG_6k-H@mail.gmail.com>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org>
	<7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q32yI-0008DQ-TE
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1CYJGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 05:06:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33465 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab1CYJGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 05:06:12 -0400
Received: by bwz15 with SMTP id 15so747791bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 02:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ocI0yPhTbfkprey0M3Tvt6RtdtXwTiqL6zGXPNBiM8Q=;
        b=ZpgaX8rrf8MdwIcMuj0RNnFXxHxM3XzUyl8amBzQVfc27kI+VVpcqjiOZG/Jmq4HMR
         5cDlJwIWi39QQZnsvppYmEjDIboI9VS2e1zZaECIju/X3H/hmwLLbHxdiaXkChXXsnCV
         VZ0rGFkGRdGLHc+ZUzbGJYVs7vysQ42Kdwzfo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VxW2PM0HSaN7RsZl6iYTRWvq5RDqtuSIAk2f/7mYpoNbXV2SFYSsOOPL6ONLao42FG
         aVQmrTXMQSM3y5ffTiVlS1nWBpSYlldrxRphVtO6qCnWjJD6zZ6EV7G/KT+mgsxIA7A0
         exsQHWw+GG4XcG0zzvj4uQZlhCoxRCD0XjjpM=
Received: by 10.204.154.88 with SMTP id n24mr507490bkw.38.1301043971150; Fri,
 25 Mar 2011 02:06:11 -0700 (PDT)
Received: by 10.204.57.78 with HTTP; Fri, 25 Mar 2011 02:06:11 -0700 (PDT)
In-Reply-To: <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169968>

On Wed, Mar 23, 2011 at 22:45, Junio C Hamano <gitster@pobox.com> wrote=
:

I agree with Jakub. I often write something like this:

    $ git log origin/master..origin/pu
    $ ^log^diff
    git diff origin/master..origin/pu

It would be annoying to have that start to warn.

> + =C2=A0 =C2=A0 =C2=A0 warning("Do not write 'git diff A..B' but writ=
e 'git diff A B'");
> + =C2=A0 =C2=A0 =C2=A0 warning("diff is about two endpoints!");

And in any case this warning is way too terse to give the user an idea
of what this is about.
