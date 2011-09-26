From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 17:21:30 +0200
Message-ID: <CAGdFq_iuY0-PBDOmtz1pRvh6J9EDRiRJHsWkTN_cHjGU20PYTQ@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se> <1315529522448-6774328.post@n2.nabble.com>
 <201109251443.28243.mfick@codeaurora.org> <201109260915.29285.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:22:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8D0a-0005nn-GH
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab1IZPWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 11:22:11 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59136 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1IZPWK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 11:22:10 -0400
Received: by pzk1 with SMTP id 1so14994516pzk.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zvcGdZNcZMsHGiII5nG+tetWvyLzvX3AFzrqVFK7sqY=;
        b=sPd85KwB1SruA8j572pW3C51QrG027361SppO4eoziVqkQiLahISNhfg9p/Z3KTwIK
         OXGr4H3BvwV/D8nNlCqMBOMeUPsW9GauJzUFzfiupBSZAr9vYLqz9JjYk+xd+6IXgVNJ
         MWevSmkNvJ5yU+VmjpCtDl642WtxD0WI8eatU=
Received: by 10.68.15.70 with SMTP id v6mr11849208pbc.85.1317050530071; Mon,
 26 Sep 2011 08:22:10 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Mon, 26 Sep 2011 08:21:30 -0700 (PDT)
In-Reply-To: <201109260915.29285.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182122>

Heya,

On Mon, Sep 26, 2011 at 17:15, Martin Fick <mfick@codeaurora.org> wrote=
:
> If this change does not actually speed things up, should it
> be reverted? =C2=A0Or was there a bug in the change that makes it
> not do what it was supposed to do?

It probably looks at the refs in refs/changes while it shouldn't,
hence worsening your performance compared to not looking at those
refs. I assume that it does improve your situation if you have all
those refs under say refs/heads.

--=20
Cheers,

Sverre Rabbelier
