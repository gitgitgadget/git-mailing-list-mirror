From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 15:42:24 +1100
Message-ID: <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
References: <4F24E287.3040302@alum.mit.edu> <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org> <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org> <20120206043012.GD29365@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 05:42:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuGPi-0006oE-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 05:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab2BFEmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 23:42:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34835 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753266Ab2BFEmp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 23:42:45 -0500
Received: by lagu2 with SMTP id u2so2763225lag.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 20:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EXUZksL0Ofsj3MZ4W57CQNfKRHhwR43vVnbK96cERn4=;
        b=vWhC9kUY7VXmL//6ITveycRBsjRMvk3jUivuwprvJoEkzzlWCbPIjo1VJOyEwc0Ifn
         cV0x863WtX4PlwXrHPQGZU2eRmGFri2U34y9FYa1cc4nqdNOWTB1XJSQdw7GriQ00W/C
         1E9RhAEtFaua8ZCQW1cpFiaTj7+YmkDiiIbt4=
Received: by 10.152.130.8 with SMTP id oa8mr8568163lab.5.1328503364333; Sun,
 05 Feb 2012 20:42:44 -0800 (PST)
Received: by 10.152.12.35 with HTTP; Sun, 5 Feb 2012 20:42:24 -0800 (PST)
In-Reply-To: <20120206043012.GD29365@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190010>

On 6 February 2012 15:30, Jeff King <peff@peff.net> wrote:

> And perhaps in that case we should be discouraging them from calling it
> something besides master (because while master is mostly convention,
> there are a few magic spots in the code where it is treated specially,
> and departing from the convention for no good reason should be
> discouraged).

What exactly are the areas where 'master' is treated specially? I
agree that people should be discouraged from needlessly abandoning
convention, however I think users should have the ability to name
their branches as they see fit.

If I am forced to abandon code targeted at the 'master' naming
convention in order to use my desired naming convention, we should fix
that. Additionally, if I have to either manually set a branch name
with plumbing commands, or delete existing branches that are generated
automatically with no option not to generate them, we should improve
the porcelain to cover these cracks.

In general, I think it plausible that in some use cases the term
'master' might be misleading or inappropriate and users should not be
punished for that.

Regards,

Andrew Ardill
