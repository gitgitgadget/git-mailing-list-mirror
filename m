From: =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>
Subject: Fwd: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 14:06:57 -0300
Message-ID: <CAHCkQtOYC_jCEuYdEcJ73-tmKCa_skDUsTOhrcoGLJ+qdG9XgA@mail.gmail.com>
References: <1343664610-479-1-git-send-email-dangra@gmail.com>
	<20120730163907.GA18109@sigill.intra.peff.net>
	<CAHCkQtNyNGBm8Z8FP7BybVOW0zQNgpxjwW_akLepYfLc-U+0cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 19:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvtR3-00028r-QV
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420Ab2G3RHA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:07:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53606 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401Ab2G3RG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:06:58 -0400
Received: by pbbrp8 with SMTP id rp8so10115670pbb.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 10:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=pEXC4rfqN/i2mupK/3SolwLqC4IgX4arwF0v9cWYyCI=;
        b=XLnHUgZONqHL+1xF28MlZ6v5P/HYWfi2G4YeQ7mviW7pTMB8joEjgTh680u3LS/8qu
         6zzJY2lIzcQdH6zl8sA7HnqonRTkAecIc656H7ds0hsQSd7Kocs3dfnBWhcqAskpqxEi
         UXXF6nP0xp5ct+F9KkAW1FSSCem8VGaZDyb5lbCmm8no668zWJDF2kLTtWZUL6PxTo3C
         I1ke2+2OWfTAGDiTevPu3gyuPoEa63sTTHh+QSauXBhI50RwUhW7dQXcueB9+anwNTaC
         20AkFv3ij6AgHNJl4voqB+IVYGYvseQ4lXC4dGnt69TGm32LH33EEfYVZMnpdDFJqP7c
         2pIg==
Received: by 10.68.216.199 with SMTP id os7mr22993835pbc.6.1343668017899; Mon,
 30 Jul 2012 10:06:57 -0700 (PDT)
Received: by 10.68.62.226 with HTTP; Mon, 30 Jul 2012 10:06:57 -0700 (PDT)
In-Reply-To: <CAHCkQtNyNGBm8Z8FP7BybVOW0zQNgpxjwW_akLepYfLc-U+0cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202583>

=46orwardning for the record as vger rejected my previous HTML email.

---------- Forwarded message ----------
=46rom: Daniel Gra=C3=B1a <dangra@gmail.com>
Date: Mon, Jul 30, 2012 at 2:04 PM
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodu=
le
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org


Hi Jeff,

I understand your complain and I must apologize for confusing you with =
Jens
from this thread
http://thread.gmane.org/gmane.comp.version-control.git/201851

This patch is a follow up to that thread (that I fail to include as
reply-to) and tries to address the issues noted by Junio and Jens there=
=2E



On Mon, Jul 30, 2012 at 1:39 PM, Jeff King <peff@peff.net> wrote:
>
> On Mon, Jul 30, 2012 at 01:10:10PM -0300, Daniel Gra=C3=B1a wrote:
>
> > Subject: Re: [PATCH] Improve tests for detached worktree in
> > git-submodule
> >
> > Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>
> The space between the subject and your S-o-b is an excellent place to
> explain the rationale for your commit.
>
> How are we improving them? What cases or classes of failure does this
> catch that the original did not?  It may be because I have not been
> following this topic closely, but reading the patch, I am not sure wh=
at
> the purpose is. Please make life easier for reviewers by telling us w=
hat
> to expect and why before we even get to the patch.
>
> -Peff
