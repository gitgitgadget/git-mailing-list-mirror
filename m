From: Michael Witten <mfwitten@gmail.com>
Subject: Re: windows git problem
Date: Mon, 12 Sep 2011 18:05:32 +0000
Message-ID: <CAMOZ1Bs6tGGJ8eZja0OaqtzK0imKt_NtiWOTgpLCaisvEXh2Rw@mail.gmail.com>
References: <4E6E42CE.80405@tandvsolns.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: luis <luis@tandvsolns.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:06:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3AtW-0006Af-OQ
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 20:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab1ILSGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 14:06:06 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:63058 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab1ILSGE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 14:06:04 -0400
Received: by yie30 with SMTP id 30so2890393yie.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FFbslcrS76khqQ66TtmlkD3pgiRfjI3c3O+mlHaqoz4=;
        b=K5d0iZhzrD3+nVYvIcS/xnJo6WrCvlZhxKDoggYNUb/fCN8xUtKgpWdL7oTAQybWnn
         onvWh9CIomVq+QzPYfwmB9tY4njxAHpw7qlJz0joeXEmPocdgA5ory/ndHq3jKd67BLk
         eVy5uZanGQYcAZ9648n19cqXEBhVUVIMtcUmE=
Received: by 10.43.52.199 with SMTP id vn7mr673941icb.414.1315850762093; Mon,
 12 Sep 2011 11:06:02 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Mon, 12 Sep 2011 11:05:32 -0700 (PDT)
In-Reply-To: <4E6E42CE.80405@tandvsolns.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181230>

On Mon, Sep 12, 2011 at 17:35, luis <luis@tandvsolns.co.uk> wrote:
> However when I checked out the project under windows (either clone or pull)
> one or the other would disappear and it would be staged as removed.
>
> The surprising bit for me was not so much that windows could not cope with
> the case sensitivity, but that git would stage the changes!

It would be recorded in the index as a change ready to be committed
(as though `git rm' had been used)?
