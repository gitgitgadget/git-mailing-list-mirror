From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Wed, 9 Jun 2010 11:08:49 +0200
Message-ID: <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 09 11:08:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMHHM-0006Q8-U1
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 11:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab0FIJIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 05:08:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51693 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058Ab0FIJIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 05:08:50 -0400
Received: by fxm8 with SMTP id 8so3424237fxm.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=+ORcRRrh25mli17ZHzPcPHn1IFkdG8AblfmUbadBMLg=;
        b=M2uHKWLJB+/dClB/bFNavYYPCAAtYRNu/Z2DZv/jJ4tJ3T+bp1p4Y/PrJe1554E5N8
         OVPaVUxxt8JPSgong9x0f+qzKOFe7qOtBrH9/hNQl0mdRsYudEjZzvdnMDnPpZ0Bqrd+
         4BKv1Zj6AfPZo/McwE2qOqIMmkdfflRz+hlSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=j3xKgzQwQItT0Xl7K6WsWndQDEx83KkeaT1MT6C57WXdPzcGuoTn24xPADXffHCSgT
         Qih+xXozmIZZaLHIaxsmuDVRD+V9R49BAF+oYbUfitXTazePGq0/Cg3l9bb1yAJv5OPl
         r3k6t7ugiS07xAfqpBeoRx0DfsNXU0db6ILNE=
Received: by 10.239.140.210 with SMTP id y18mr734129hby.196.1276074529371; 
	Wed, 09 Jun 2010 02:08:49 -0700 (PDT)
Received: by 10.239.156.209 with HTTP; Wed, 9 Jun 2010 02:08:49 -0700 (PDT)
In-Reply-To: <4C0EB741.9020905@op5.se>
X-Google-Sender-Auth: oHcuHBjfBm4EIYcQ15NqQA51CaM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148755>

On Tue, Jun 8, 2010 at 23:33, Andreas Ericsson <ae@op5.se> wrote:

> Catering to AIX by default seems stupid beyond belief. AIX users today
> are, without fail, accustomed to having to tweak more or less everything
> to make the system run smoothly with modern applications (where "modern"
> is a generous term, including everything that's been written in the last
> 10 or so years).

AIX doesn't come with 'less', because it doesn't really need one.
'more' on AIX can page backwards/forwards in piped data (unlike 'more'
on Linux etc.), thus negating the most common need for installing
'less' elsewhere. (The other big feature of less, that it by default
clears the screen just as you had found what you wanted to read and
were about to apply it to the command line before 'poof' - gone) is so
annoying to me that I routinely sets PAGER=more before using Git.

If it's true that Git should demand 'less' to be installed before
being usable out of the box.. well, that's just plain silly.

-Tor
