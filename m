From: Frank Li <lznuaa@gmail.com>
Subject: Re: Implement --password option for git svn perl script
Date: Tue, 2 Feb 2010 17:18:52 +0800
Message-ID: <1976ea661002020118n2b86844k47a1064c028f439f@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
	 <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
	 <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
	 <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com>
	 <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com>
	 <20100202090538.GA28437@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Laszlo Papp <djszapi@archlinux.us>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 10:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcEvB-0004bt-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 10:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab0BBJS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 04:18:56 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:63614 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab0BBJSx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 04:18:53 -0500
Received: by yxe27 with SMTP id 27so1070146yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 01:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wImXKSkL/fvSqhxnoFcYtqIoeehIQBio+CjmoKv04IU=;
        b=DtnPdwvnTHN14jwViOw9IoGlAzgkkmc6i7r4P+c9dVrdcALq6AYfIYLjImTieS61N9
         a+haLoR33NTAw0D5l7+2mtpTObyvAkoHMYTTIU4fX6v0coJ5qKC5XLK7LIVvHdqAGifP
         ZZkdtfz4fUkvw4oje9S7GyOp/fwS/zJxC62sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hCgudfI26UJCngUVfJPXox9es/Hnu46izgUlRTqeMq7h9U4Z69wmu71FT9MscjO01v
         gcUwhRQGH1FCNV7bFjCis6KMtrRcOvyDFLIg+rq+riUViVQlRTwvt4uxCwUjCan6UL6F
         HvTqa5eqCdS7cYEHNCnbmyqYCUPvQktPuFNgw=
Received: by 10.150.87.9 with SMTP id k9mr8150745ybb.77.1265102332347; Tue, 02 
	Feb 2010 01:18:52 -0800 (PST)
In-Reply-To: <20100202090538.GA28437@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138705>

> Having a --password option in the command line could work, but it's
> painfully insecure if there's any way for another regular user to vie=
w
> the process table. =A0Not something I'd like to encourage...
>

Yes, it is insecure. "--password" seam undocumented.

> Since SVN already caches passwords in a mostly secure location on dis=
k
> (at least on *nix), shouldn't git svn be able to use the password cac=
he
> SVN uses?
>
> --
> Eric Wong
>
