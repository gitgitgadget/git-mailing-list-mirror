From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [RFC PATCH] {checkout,reset} -p: make patch direction
 configurable
Date: Fri, 20 Nov 2009 11:08:00 +0100
Message-ID: <20091120100800.GA26162@headley>
References: <527e9296b638eb4c9993b3fb0d1c6f51b64f4c2c.1258667920.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQPK-00080y-07
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZKTKHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2009 05:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZKTKHu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:07:50 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42270 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbZKTKHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:07:49 -0500
Received: by bwz27 with SMTP id 27so3175128bwz.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fEmPcJZhA6vfhEdXb7hdeagyUJZl3Pm9G925InbqVLI=;
        b=T3TsMIKmKJlda7u4E2pxJmRI5O6iwOPXewgc91+JrXgbFH1w48+t4e1p6APqNOR1Jf
         /eQCAFHR27hwWmJtZH7clHblhpqLbNzwqtrYUVG5GpKAIYsPSnmmNJ0Jm9be8CEhAG7r
         AkgCzzOwVaF8ea6xj/b9d/Y7vCEel8F7ZYS90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=WKN2woWU5U0bJWmLWHDo+DmXiAPNWuAmzqMCkEbMf6a38aYb0OTFe0f8B5In79AF5y
         4BzExsePtFUs50ReWloj64tkbXeplOILZopFzhRqTwTtlNSCz9qe3yxE/3zJ2i3Yv3by
         CivY5wiIZOCjV4St6c1SONqiQdDJRAKpPHQ9Q=
Received: by 10.204.3.14 with SMTP id 14mr1145239bkl.128.1258711675053;
        Fri, 20 Nov 2009 02:07:55 -0800 (PST)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id z10sm1605125fka.0.2009.11.20.02.07.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 02:07:54 -0800 (PST)
Mail-Followup-To: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <527e9296b638eb4c9993b3fb0d1c6f51b64f4c2c.1258667920.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133322>

Hello,
I bet it would get caught in the review process anyway, but just in
case -- a small typo:
> +With 'forward', diffs are taken forward and applied in reverse, i.e.=
,
> +if you added a block of code you see an addition patch and are asked
> +if you want to remove it.  'reverse' instead shows a removal patch
> +and asks if you to apply it.  'mixed' is the same as 'forward' when

Should be 'asks if you /want/ to apply it.'

=C5=A0t=C4=9Bp=C3=A1n
