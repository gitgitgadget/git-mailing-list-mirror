From: fREW Schmidt <frioux@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sat, 17 Mar 2012 13:43:55 -0500
Message-ID: <CADVrmKSGbA2gWVyPLMCBay3EikOykwq3eEH1+qWCpZvOron3Aw@mail.gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 19:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8yc2-0001BU-9e
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 19:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab2CQSoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 14:44:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55391 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2CQSoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 14:44:16 -0400
Received: by vcqp1 with SMTP id p1so5246394vcq.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=kw2V8HvH8ei4Ol+IOTt8V19opMjV/dxySbGrqsaIVxA=;
        b=hf2cO8Dia/GeghePhP0QFGT+8CU5P//2+H518Xi+9SUA5CrxqpHmSATOuOsYp0vlsX
         OY5SjnRUEtHBWtFSSWNt6GOUYeniWrurXV4K8KZSxXmIFSKC6GsN2Zpg2+l7QQHAen3b
         5AMOBr9maPWQJ3aabTTwdZurLZgR5Xk01Z7G+tdixlbWoKeZ5dS4jFmNl7j8Mdp3FoW8
         tvsZCvB03sm9F20dYWliiY4JBVlJx/AOhrqmyCJjGeFL6GiEWUxqGRuHNGuv1tAB3DnI
         Dr8dwR47Eply/+8MKOtCkB8WXqMNYVkcXss6VJxYSRdzEsI5Vi8KTrWj8OjXDcxtTzLp
         bIvg==
Received: by 10.220.188.12 with SMTP id cy12mr2194673vcb.69.1332009855321;
 Sat, 17 Mar 2012 11:44:15 -0700 (PDT)
Received: by 10.220.152.145 with HTTP; Sat, 17 Mar 2012 11:43:55 -0700 (PDT)
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193344>

On Sat, Mar 17, 2012 at 12:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> There is a proposal to change the default behaviour of 'git push' on the
> Git mailing list. The goal of this message is to encourage you to discuss
> it before it happens (or the change is aborted, depending on the outcome
> of the discussion).

I personally much prefer the one where it pushes the current branch to
its tracking branch only.  That leaves very little room for surprises
and mistakes (the one exception being git push after git checkout -b
new-branch origin/master.)

--
fREW Schmidt
http://blog.afoolishmanifesto.com
