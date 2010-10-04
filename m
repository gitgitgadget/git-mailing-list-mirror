From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 3/6] tg-files: list files changed by the topic branch
Date: Mon, 4 Oct 2010 08:50:11 +0200
Message-ID: <AANLkTi=-2fHW30vxvc8q30KPfE0YWxUfuqzvk15fmtO6@mail.gmail.com>
References: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
	<1286141157-30422-1-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-2-git-send-email-bert.wesarg@googlemail.com>
	<1286141157-30422-3-git-send-email-bert.wesarg@googlemail.com>
	<20101003220330.GE28679@pengutronix.de>
	<AANLkTimLgWKPBjVAni=t6EK4Yr9FyJZa=Yk01SeMcwA1@mail.gmail.com>
	<20101004064747.GJ28679@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:50:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2esO-0005Oh-3H
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab0JDGuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 02:50:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34215 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0JDGuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 02:50:12 -0400
Received: by iwn5 with SMTP id 5so6533198iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lL7W2GLMT/Eb8drh8L1hHZuO4t2DZJXXaOxyo8ktVlo=;
        b=Q/z5uWPYybtI0fpwor1ieOXdsoOc0ykrKLxxKpi+EVtDEIwWpcKV2vnBamsAHPg7Ny
         Kp9V2Hj/gSxypY2Z9C1MrJHJ8OM7nULXDsvBQ+RaC1OzDEZMLnINDrO4BYoftk0kFupQ
         NCwulIW1trmUpUY2hGPxQJcx/vDo0ribUcrEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a1R1xjJ4v2mAR2YCbQjS3MFegDm0773DFE4C0wbShuH5rLlHOyBC3pf8tlSNPYjKSZ
         vJg3b+D/j+c9oy3v+9SKxXrfM91OVG23oKoPfl45rCK6EmD/lT10Pf0nLhfnLIIzbv+Q
         2D3i6aM4DVxdAIOcyDrRDLx0izAbb/bx7PbA8=
Received: by 10.231.35.8 with SMTP id n8mr9674956ibd.78.1286175011595; Sun, 03
 Oct 2010 23:50:11 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Sun, 3 Oct 2010 23:50:11 -0700 (PDT)
In-Reply-To: <20101004064747.GJ28679@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157990>

2010/10/4 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello Bert,
>
> On Mon, Oct 04, 2010 at 08:43:52AM +0200, Bert Wesarg wrote:
>> git diff-tree --name-only $(pretty_tree refs/top-bases/$name)
>> $(pretty_tree $name)
> That's what I thought after sending the mail and shuting down my mach=
ine
> :-)

But what about the -w and -i option now?

>
> Uwe
