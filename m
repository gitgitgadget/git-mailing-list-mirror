From: Lin Mac <mkl0301@gmail.com>
Subject: Re: How to move a big branches to a new base?
Date: Wed, 3 Mar 2010 11:17:38 +0800
Message-ID: <10d816431003021917p54491088ie290ec47840dfaa2@mail.gmail.com>
References: <10d816431002251918vf13a5e8uf0396aa861081bcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 04:17:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmf5u-0007rm-AX
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 04:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412Ab0CCDRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 22:17:40 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61525 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab0CCDRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 22:17:39 -0500
Received: by pwj8 with SMTP id 8so601915pwj.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 19:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=NvQ7HVQS8VEvXi4tZPqRSicVT86QUVcsdYTqVe0CB5U=;
        b=WSDOp4GsLC00EKQY4eJh+UuGN5dPyULVcICHpdwih4Wfml/efbkQcg4dEPtvjqQe5i
         dxVQkTniMYgHr1T4WqYXc3q6nTIvWTR2PNsyltUMXuGg9/5dHOe+kpWmqD4nH8SsZ+nY
         O8N9oLxDJe18O6urf5yQniLKxkc75bQt7LvSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=fMtmGADKNIDh5MKzF4bnlQfUkvKxq+QTvKxnJoazRaTfzwYutuis+IVhPqEnAfy3JG
         zzU4G0qqT8sKFemjceVOaG6GjHDL7lPeWkPX36HeLa8vYKwYE2IjXkdJxt70AEodcRq7
         K8KUuJSnF93iKXn6VV5dEv+igqYHBrUMBkKlI=
Received: by 10.142.202.5 with SMTP id z5mr805395wff.274.1267586258937; Tue, 
	02 Mar 2010 19:17:38 -0800 (PST)
In-Reply-To: <10d816431002251918vf13a5e8uf0396aa861081bcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141432>

Hi,

Sorry for re-send this again, for this is really important to me and
trouble me a lot. And I've been searching for a long time, but I
didn't found any useful.

Or maybe it's the way I uses branch wrong? Should I always keep a
branch as clean as possible, and use tag for some unused/not often
used branch, to avoid such problem?

Also I doubt whether my last mail reach the mailing list or not.
So, any response welcome, even RTFM (I'm actually reading it....) is
fine, at least let me know it's just a stupid question.....

Best Regards,
Mac Lin

2010/2/26 Lin Mac <mkl0301@gmail.com>:
> Hi,
>
> I have a branch that have about 10 descendent branches. Now I would
> like to move this branch, and all the descendent branches, to a new
> base, and I might need to do so quiet frequently before I merge it to
> master branch.
>
> My "dirty" way is to rebase step by step, it takes about 15-20
> rebases, but the branches is somehow complicated, and this seems
> error-prone to me.
>
> Is there a more clean way to do so?
>
> Thanks in advance.
>
> Best Regards,
> Mac Lin
>
