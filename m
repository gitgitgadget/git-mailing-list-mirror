From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add some performance testing scripts
Date: Fri, 18 Jul 2008 22:41:32 +0100
Message-ID: <b0943d9e0807181441u2ff0180ei1b7a28dc24358320@mail.gmail.com>
References: <20080716193549.3467.13072.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJxij-0001hZ-6N
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 23:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbYGRVle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbYGRVld
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 17:41:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:55053 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbYGRVld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2008 17:41:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so460497rvb.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=epmOUVV88FSaheIXxTjxhr2jwdIkD3IDSWKBaPsTnG4=;
        b=aL4MUEsXAiKtIGcO8SGfcVgeilGqLyRDnClg4BTEeriYK2Q5kl5Nki+SUFS+kC4D/S
         L7oa1JgO84We7b+ZSG7PElSwVf/hV7yr2J83/IAQb5FFKXVbkYq9cBATD+Syh2sl66Nj
         46hi+PCKo9hbuwKNuXGfNMbZKKTQ2+LUVFHKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e5IxXLWj2DkV5jPE0bnPZgS+zJWapqbpaueonMTdirojfWJhNQVXPILSX9CUK7HTYt
         yMu8kLLGosPvseDlrHSJckAqlv1hEMpc05QuwhA70/aOreCSlliEGdO20TeC9rf+G+Ej
         dEGrdLC+ZcIxNEV8sz6jPRG3PZIQGyQnUzsyA=
Received: by 10.115.14.1 with SMTP id r1mr491897wai.206.1216417292394;
        Fri, 18 Jul 2008 14:41:32 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 18 Jul 2008 14:41:32 -0700 (PDT)
In-Reply-To: <20080716193549.3467.13072.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89079>

2008/7/16 Karl Hasselstr=F6m <kha@treskal.com>:
> find_patchbomb.py: Given a git repo, finds the longest linear sequenc=
e
>  of commits. Useful for testing StGit on a real repository.
>
> setup.sh: Creates two test repositories, one synthetic and one based
>  on the Linux kernel repo, with strategically placed tags.
>
> create_synthetic_repo.py: Helper script for setup.sh; it produces
>  output that is to be fed to git fast-import.
>
> perftest.py: Runs one of a (small) number of hard-coded performance
>  tests against a copy of one of the repos created by setup.sh. The
>  initial testcases all involve uncommitting a large number of patches
>  and then rebasing them.

Looks good. Thanks.

--=20
Catalin
