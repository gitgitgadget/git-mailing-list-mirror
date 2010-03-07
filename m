From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: status of libgit.a
Date: Sun, 7 Mar 2010 21:27:16 +0700
Message-ID: <fcaeb9bf1003070627s39bd9635o9c740eae04f08de5@mail.gmail.com>
References: <499B3F65.8010109@synapse.com>
	 <20090218091617.7805.qmail@2684cdd72f0ee9.315fe32.mid.smarden.org>
	 <499C40EA.6050108@synapse.com>
	 <20090219092446.23272.qmail@3b5a9fa637f270.315fe32.mid.smarden.org>
	 <1267957655.3759.29.camel@mattotaupa>
	 <20100307121809.GS27414@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Menzel <pm.debian@googlemail.com>, git@vger.kernel.org,
	Marc Oscar Singer <elf@synapse.com>, 407722@bugs.debian.org,
	Lars Hjemli <hjemli@gmail.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 15:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoHS8-0004ww-BQ
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 15:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab0CGO1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 09:27:17 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:50451 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0CGO1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 09:27:16 -0500
Received: by pzk32 with SMTP id 32so2217055pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 06:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Z1PakDKYhWzQ6vpzTtXGdB2DYgh8JUxwvHdQ1A29HT4=;
        b=MfHEwxOUVBw2mYST4G97LjYC2ui+j5kTR40bsvCI8+tewJ8aX/n/XwTi2eNyzFdEqI
         fUyRvdTg7dCXP56hwM0qtG6aKpLiZ7pGL3kYBwHgav8eN9qqaJo2pKm3kPiQbP8Ck1uH
         6evwPzU3d0NGnT8tdeoIgsZIVWmW8T8jk/Npw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=pThLWgV2k55qsoNKNFTvM6U/VrNileBbwKeAN031I1R6yvbAWuiPkL1mJxhQxRwPkz
         TroT622CF3AiOKD1/4yxWAv/EzafdcWPrYaQ+4kscx01nLDg7y4kqHFQpRjbgEP0S6Fy
         q2K9uAh80U43StU9hPmFYhawy9havEB5bikLk=
Received: by 10.114.70.4 with SMTP id s4mr2455790waa.31.1267972036380; Sun, 07 
	Mar 2010 06:27:16 -0800 (PST)
In-Reply-To: <20100307121809.GS27414@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141715>

On 3/7/10, Miklos Vajna <vmiklos@frugalware.org> wrote:
>  I think the only sane solution is what Fedora does as well:
>
>  http://cvs.fedoraproject.org/viewvc/devel/cgit/
>
>  When cgit-1.2.3 is released, have a look at its Makefile, check what Git
>  version does it want and add the relevant Git source to the cgit source
>  package.

Or bundle cgit with git.git as a subsystem, with Lars as maintainer.
-- 
Duy
