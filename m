From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Is there something like a git format-patch --squash?
Date: Thu, 18 Feb 2010 14:46:58 -0500
Message-ID: <32541b131002181146o1be5b874m1f8511abddf0aa64@mail.gmail.com>
References: <32541b131002181145w44d69e9eo150d08f34273cefb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:47:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCLM-0006Pa-E2
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 20:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758446Ab0BRTrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 14:47:19 -0500
Received: from mail-yx0-f180.google.com ([209.85.210.180]:38484 "EHLO
	mail-yx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758302Ab0BRTrT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 14:47:19 -0500
Received: by yxe10 with SMTP id 10so1437742yxe.33
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=vu9gr2qh9nRjqaakG8FSYw9VOOzQcg6BvR4wB8YgHKg=;
        b=Ff8hp628zr56kLovnSiubH6mLzjN0lso9awXUDW1GHBREtbrOpw0WQiGST5oKv2KWK
         9pNS2O0EStx/oCFf5PsRdPGvSptecEJe+5baSSrie6gZUpx08AKiy3/gSo9zMp+7stmD
         Qwqqy9t1sSKSTGJZhYwlEatkWHaLCxY/2VM/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dB+F/D8Vd1zbg2mSk+q703ko3PZesn/YRPeN1e4uUF0le7UhXyveAdH8wBwYY/loz3
         qS/Seum2DMHrWyW0sWKADA3jXkM4NpJJhMByzbThdhKP0rxaREBs7douQwxx5L8TjpEm
         ysivYfpFvhnDjcfLfJM9hnWo4gqbNTa3Xig3E=
Received: by 10.150.166.8 with SMTP id o8mr1697835ybe.262.1266522438102; Thu, 
	18 Feb 2010 11:47:18 -0800 (PST)
In-Reply-To: <32541b131002181145w44d69e9eo150d08f34273cefb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140365>

On Thu, Feb 18, 2010 at 2:45 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> In the above, in the 'else' clause, what I really wanted was somethin=
g like:
>
> =A0 git format-patch --stdout --squash $parent..$commit

Um, where the unstated actual problem is that format-patch has no
"--squash" option. :)

Avery
