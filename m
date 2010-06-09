From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Wed, 9 Jun 2010 18:57:33 +0000
Message-ID: <AANLkTikqnMGviOOrTWDUA82u3pwfWnunzj8KxQkRcLsm@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
	<20100608053507.GB15156@coredump.intra.peff.net>
	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
	<4C0E5103.7030501@viscovery.net>
	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
	<4C0E6810.3070301@viscovery.net>
	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>
	<4C0E932B.3010702@viscovery.net>
	<AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
	<4C0EB741.9020905@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 09 20:57:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMQTB-0008JV-Sa
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 20:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308Ab0FIS5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 14:57:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54721 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab0FIS5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 14:57:34 -0400
Received: by yxl31 with SMTP id 31so1169281yxl.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hv7iubeL2BRTLHOEwg31F7u25wPaCrC81iNg4jLfFsE=;
        b=mYMCpsYgk2hMBpB+VUW94/sFbLB+TtZTmFu7/11565ekh/gGe6Tx1A1aHeUHgsKXGm
         dF+qXD7WfqIMuRgRqs2HeFctX2tNLkoS+y6wI6S6F41D/uLBZtOekbUSz8XInGXzS+BQ
         Bs7gh2WcM86Di9SR50p89Y6emzJJPcK3JE9Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mdkN/y0AdvkB8KxD1JG7hHCVkUAcLzSN5wdeqvqV6beoidI730rz+ZwZ16HVGVMUyQ
         CPhaTquM4KIRLJJmVQOcPQolHJmz7ZZyPEdAtbHP+u5THDFDQRg3bYJPOejihv1JknVp
         dqpDu4VasM57+ew+rz2YgtyBgJ2YevtkHUhu4=
Received: by 10.90.213.7 with SMTP id l7mr379189agg.154.1276109853338; Wed, 09 
	Jun 2010 11:57:33 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Wed, 9 Jun 2010 11:57:33 -0700 (PDT)
In-Reply-To: <4C0EB741.9020905@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148806>

On Tue, Jun 8, 2010 at 21:33, Andreas Ericsson <ae@op5.se> wrote:
> Catering to AIX by default seems stupid beyond belief. AIX users today
> are, without fail, accustomed to having to tweak more or less everything
> to make the system run smoothly with modern applications (where "modern"
> is a generous term, including everything that's been written in the last
> 10 or so years).

BSD users are also accustomed to that to a smaller degree. But as long
as they keep submitting portability patches to keep their ports up to
date, I don't see why those patches shouldn't be accepted. If they're
otherwise fit for inclusion that is.
