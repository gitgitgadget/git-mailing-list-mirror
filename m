From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] git-submodule: respect -q for add/update
Date: Wed, 5 Sep 2012 14:42:31 +0300
Message-ID: <CAGHpTBJ6hWJKaQvN4oByrest_FB1fGDKa=ge4fM1HWmSWZ1tkw@mail.gmail.com>
References: <1346743880-11379-1-git-send-email-orgads@gmail.com>
	<50461E18.6020400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Sep 05 13:42:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9E0G-0000px-GT
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 13:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab2IELmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 07:42:33 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43936 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2IELmc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 07:42:32 -0400
Received: by qaas11 with SMTP id s11so593141qaa.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X3aH6tg11K2p8vqzzyDKIbo2wu9FSfTuzyriqPdvzUc=;
        b=TMvcY52sXkfU59F+KHvNLQSfJGPBYBtdTh7X3y+FFESGMD7/LIUeaRcZtgdNnlP+FH
         n8oPCwZQSpcsttkDXzJE7vn1ZLA9XxDxfyaWHyd5TZb+bld3xg0eEk0hkZWZb6wMDZ0Y
         5N4EjJdlg6A+gqc7Wz2T4xvsCJL8FweH9ZqZQ97LkJOm0zAbW4m72gIj+DSeJmd4zRmi
         0Sm8iFkhjKf3yU94TKf4wrCvNMOP82zNoR/AJBprtuhCYSNt4ORY4RBUamIhNNP37kpB
         71KDIuIl5XyymCt0JDQTdA3AcPKzyXCrC5/xodX+hSloapU4+9bXuw2Q/3xc4JN//425
         U+Gw==
Received: by 10.229.136.17 with SMTP id p17mr11792845qct.139.1346845351868;
 Wed, 05 Sep 2012 04:42:31 -0700 (PDT)
Received: by 10.49.131.8 with HTTP; Wed, 5 Sep 2012 04:42:31 -0700 (PDT)
In-Reply-To: <50461E18.6020400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204816>

On Tue, Sep 4, 2012 at 6:28 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> Am 04.09.2012 09:31, schrieb Orgad Shaneh:
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>
> Before the "Signed-off-by" is the place where you should have
> explained why this would be a worthwhile change ;-)
>
> To me this looks like you make the default noisier and require an
> explicit "-q" to make it quiet again. There is a reason you don't
> normally get bothered with the output of the checkout command run
> under the hood of git submodule add/update, so I don't think this
> change makes things better.
>
> But you might want to think about adding a "-v/--verbose" flag to
> make the submodule add/update checkouts more verbose, in case you
> care about the output of the checkout command. That would be a
> sane thing to do, so what about changing your patch into this
> direction?
>

I don't agree the default should be quiet. That's what the (submodule)
-q flag is there for.

When I run 'git submodule update' I don't expect to be in the dark
until the submodule/s finishes checkout, this sometimes can take a
significant amount of time and feedback is expected.

- Orgad
