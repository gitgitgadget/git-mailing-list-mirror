From: Alif Wahid <alif.wahid@gmail.com>
Subject: Re: Git exhausts memory.
Date: Mon, 4 Apr 2011 22:52:52 +1000
Message-ID: <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
	<alpine.LFD.2.00.1104021103130.28032@xanadu.home>
	<BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
	<alpine.LFD.2.00.1104031110150.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 14:52:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6jH9-0007XZ-5s
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 14:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab1DDMwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 08:52:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49431 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab1DDMwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 08:52:53 -0400
Received: by vws1 with SMTP id 1so4065604vws.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JQqlom5po+bqdLw6+LwK/WDm98vXcPt6EClCK8GMsOU=;
        b=pK6GocBokDLp/Ammn9NZbuE6PYws1o34FohdrDorPvrWTFKh4fuQhmH43i6Zs5NTbR
         U/Kil0aNjPDktZWv3HXdbjdFfUXgAhg3e2xN5/V0tTA5BvYAlHCDmWpCln8TqScsHYgq
         QuXnXG5tFqUf4IY15lZx8AyZmG742CTt7+lew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bi9oApctsLiH7lCNVPhkRHXo6Mf1n8BWJwiCnbAprs7mcafRPgd23J4s+DmeuuwB3Y
         m5DsVfdsgDe1OMus8pAmE0IDWK2kDrv1uCtGJQdWD8PWJoXKkLwVoExybOBKsC30YfCz
         eIOSUnCG+UxZwEdHvZVwKhTcVAcKGLgptQdbE=
Received: by 10.52.18.6 with SMTP id s6mr4558185vdd.144.1301921572499; Mon, 04
 Apr 2011 05:52:52 -0700 (PDT)
Received: by 10.52.155.70 with HTTP; Mon, 4 Apr 2011 05:52:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170809>

Hi Nicolas,

On 4 April 2011 01:18, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> Something you can try is to simply tell Git not to attempt any delta
> compression on those tar files using gitattributes (see the man page of
> the same name).
>

Seems to have worked. Both git-gc and git-repack appear to be less
memory hungry now and do actually run to completion without failure.

Thanks for your help.

Cheers

Alif
