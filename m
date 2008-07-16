From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: git submodules and commit
Date: Wed, 16 Jul 2008 15:03:41 +0100
Message-ID: <320075ff0807160703v3f16ff5bue722b760ad66488e@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <487DD1C7.3070701@viscovery.net>
	 <320075ff0807160402s7429291ela288b42d99c1ec53@mail.gmail.com>
	 <487DDCFC.9020007@viscovery.net>
	 <320075ff0807160548qae5d702jafe3df63363c512c@mail.gmail.com>
	 <487DF9BB.10107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 16:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ7cZ-000464-67
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 16:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475AbYGPODo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 10:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756549AbYGPODo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 10:03:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:32057 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756474AbYGPODn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 10:03:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2721762ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K7KXfSXHaeDLge4zxK1/8PF8V/fKs/mlg8OnxjltumM=;
        b=FEnjquiOrYe1H+JDba4EhC4d0hYrYSJ87Gjo/JUp7ixecWca1J1aBE4gGO8/azjRUy
         cHz70VLHstxD+TsFxzQ52yACOdz1pxXJFPxoae/0oO9S8z+I7m8OnXOhUDeK5hfVdTGk
         prBuLJjBWuUMTBxQ7X2H90KW2YLTFPnQfCuK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uSy2pmCVhi9+o1jg9tgZxYoejIlDA0k2CYO/gMvDs24qWtNIDPhQ3F1VDFrEPODPTx
         oshZ9Zz9nycyMQuJ5AUfNGhaUpueP/qr1ecHO0le2T1hnSJMYbCU3DgAstBxKFVylJSx
         HXMWZk+GtqcA0PFhgoxhCXPJfGpSGoqr8lmiI=
Received: by 10.103.20.7 with SMTP id x7mr915028mui.96.1216217021459;
        Wed, 16 Jul 2008 07:03:41 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Wed, 16 Jul 2008 07:03:41 -0700 (PDT)
In-Reply-To: <487DF9BB.10107@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88680>

On Wed, Jul 16, 2008 at 2:38 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nigel Magnay schrieb:
>> P and S aren't distant projects, they're closely coupled.
>
> And I'm saying that submodules are designed for *loosely* coupled projects.
>
> It's no wonder that this tool is awkward to use in your workflow.
>

Ok in a sense. I don't think it's particularly clear from the
documentation that this is a limitation of submodules though.

Given that
- The only way in git to separate out re-usable modules is by the use
of submodules
and
- It's a pretty common usecase for these submodules to be interrelated
and
- Looking over the list archives, it seems this is quite common complaint

"I really like the git submodule implementation, I just don't like how
hard it is to work with"

 "The current behaviour strongly encourages me to avoid submodules
when I would otherwise like to use them, just to keep the rest of my
team members (who are not git experts) from going insane."

 "For my use case, I passionately dislike the fact that a submodule is
not updated automatically.  There's never a time when I don't want to
update the submodule.  The submodule is a very important piece of our
project and the super-project depends on it being at the right
version."

and
- All the technical capability is there, it's just the porcelain
that's causing the friction.
then
 would this not seem to be an area that could be improved? Even if it
were an optional mode of working?
