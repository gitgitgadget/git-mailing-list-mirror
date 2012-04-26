From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: reject bogus section names for --rename-section
Date: Wed, 25 Apr 2012 21:19:32 -0700
Message-ID: <xmqq62cnazvv.fsf@junio.mtv.corp.google.com>
References: <9E01F5E2-FB51-418D-B50C-EB6DC63A4F84@justatheory.com>
	<20120426014714.GC8590@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 06:19:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNGB9-0006kE-AQ
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 06:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab2DZETf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 00:19:35 -0400
Received: from mail-vx0-f202.google.com ([209.85.220.202]:63715 "EHLO
	mail-vx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab2DZETe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 00:19:34 -0400
Received: by vcbfk26 with SMTP id fk26so103891vcb.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 21:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=nZ9mLuJ5e3q3IYkWx3v+D219yAxHO7oJLacnzH6QDJY=;
        b=DaAS3m2Bv5ZIlIq0BsOSnlcfBSCugzJQIxSdRuvUjEd3VLeF+ecULFCN8oAoGBP3OF
         uggDcw6JKSsZb+I9tIDGiLNUf79XHRXZhNd9nnLSK1hGNR7dGasiaEhdAywa6KXwthm1
         FlSLQcfHxmHbLwlRhJTt2lxPOKhzL5uzLquPmGnpk1VHN2GgC7+AYGMkRLs+n5FRg+Np
         RV0T0bp8s6w9uJEmkdPSyO4jjQyH/zjvgh2c1dJMVZaTREE6WSSaAnWAKC+xpvQST7qE
         gGbNWfASZ8QnvJsP5ovH7FSpM4ISWMpVVQk5n6DWUerAUkjUcxspbk4oO8X65trMVvvF
         zNyw==
Received: by 10.236.189.9 with SMTP id b9mr6530601yhn.8.1335413973375;
        Wed, 25 Apr 2012 21:19:33 -0700 (PDT)
Received: by 10.236.189.9 with SMTP id b9mr6530585yhn.8.1335413973308;
        Wed, 25 Apr 2012 21:19:33 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id z48si1826568yhn.7.2012.04.25.21.19.33
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 21:19:33 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 36A8510004D;
	Wed, 25 Apr 2012 21:19:33 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id CA590E125C; Wed, 25 Apr 2012 21:19:32 -0700 (PDT)
In-Reply-To: <20120426014714.GC8590@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Apr 2012 21:47:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlUA6SukASYU6MdAZL7VmtIP81jW4KRyLT1d2/sm8LDx5AHg68CXXuZKmyA+mOgXrnnys6PckOg5rq5KUjppg+PfGzJ9qBg8WVnPU58S1Lpmk6kBv7f+8/e3uZABH2AU864tyb/Og/tjGalrrpmqIuzeO7A+9LTpjO9kjV4RXaEOdBvOp4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196350>

Thanks, will queue.
