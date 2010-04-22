From: Aghiles <aghilesk@gmail.com>
Subject: Re: git push in --tracked branches.
Date: Wed, 21 Apr 2010 21:13:14 -0400
Message-ID: <i2n3abd05a91004211813t8111c77am381bc0b8226a0c9b@mail.gmail.com>
References: <y2w3abd05a91004211702qf4cd42bau20ac52a4d35a6bf1@mail.gmail.com> 
	<20100422004433.GC14249@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 03:14:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4kzk-0006rp-Rz
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 03:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab0DVBNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 21:13:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37215 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab0DVBNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 21:13:36 -0400
Received: by wyb39 with SMTP id 39so4456029wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=BhCHadOr5HEb15VWa+/7ZfRnWbnzuR+tGBxJVjzR8vg=;
        b=Jc/AmbyU0CuxZxevE6nMDckd9tDY9zyev0p9Yi/sn8T/QAnQcsxQWv8aZn9jNmzG+C
         5UMgc56h3/TfpUaNsuk7sDhpzLcnQhCrjos1rKOYYU3yGUpgm+6QGdv6SAQN8lOtPtR6
         UJMU3TwKtyflxMfKq2x4EzAy8WQthrVLKb+mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sJIrRULyFNveKVvVhjObP9OYwoEthWH15OKY3V6Sq3EmI2F5Pc/y6DIUK7JMxTFII5
         ziFuf85vMbgimQjrcN15t+wEeEO0DzSgud04uCU4BTJ8hWdBN1X8UL+NeKck2A2nm3E8
         d6tRdQnGGuo4KUWSkq/9vhcnJ+4RR2ZYDbFs0=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 18:13:14 -0700 (PDT)
In-Reply-To: <20100422004433.GC14249@coredump.intra.peff.net>
Received: by 10.216.158.3 with SMTP id p3mr3741932wek.9.1271898814129; Wed, 21 
	Apr 2010 18:13:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145488>

On Wed, Apr 21, 2010, Jeff King <peff@peff.net> wrote:

> "git push" will by default push matching refs. This has been the
> behavior since day one. See the description of push.default in "git help
> config" for other options (I think you want "tracking").

Thank you very much. The 'tracking' case is what I need. Could you
enlighten me why pushing all matching branches is a sensible default ?
It seems like an unusual thing to do.

  -- aghiles
