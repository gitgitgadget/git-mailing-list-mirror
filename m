From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Fri, 27 Apr 2012 08:03:45 -0700
Message-ID: <xmqqvckl9pym.fsf@junio.mtv.corp.google.com>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
	<4F966F0C.6090504@seap.minhap.es>
	<xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
	<4F994AC3.2070708@seap.minhap.es>
	<20120426130854.GC27785@sigill.intra.peff.net>
	<xmqqehraa5ct.fsf@junio.mtv.corp.google.com>
	<20120427081220.GC12092@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 17:03:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNmi9-0008AL-NU
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 17:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760399Ab2D0PDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 11:03:49 -0400
Received: from mail-wi0-f202.google.com ([209.85.212.202]:48904 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760393Ab2D0PDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 11:03:47 -0400
Received: by wibhj13 with SMTP id hj13so45111wib.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 08:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=9d+UXcqKSrynPOBUSaUh7w2/swTLPevDTlSu/mDyMak=;
        b=lzS5VqC+SvSDf8W+HalhXbD1Hcn54aovaVrb3xtx6FizK1pef2jnGypWqMQUFN09Kk
         ICabTVBmSJ2g9k6rJF+eS+5o0duWSI2uOdxtcBEB9+9dFRXpDmOaSYQUc+59F8d8kW6q
         mrHy0jPDegXcwG6kQavu0YyWN7yUMULYHva0oNeTOfRAA05rJ/XH41o/IvQXelFRFhe5
         25fQzfYnYBqq2NpsGSYevQDxRFLJi4YTbTqVPNHd88pUasJwadEgBG71dsYq8jfOp3d3
         ogJyfb933jlU1+zNgHmpRubccjreIsfybui/XBPMzzYtB44k5etcu8xW5BJL/CQPCVC9
         RMpg==
Received: by 10.213.110.15 with SMTP id l15mr638028ebp.22.1335539026587;
        Fri, 27 Apr 2012 08:03:46 -0700 (PDT)
Received: by 10.213.110.15 with SMTP id l15mr638015ebp.22.1335539026416;
        Fri, 27 Apr 2012 08:03:46 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si6441710een.0.2012.04.27.08.03.46
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 08:03:46 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 3B2735C0FA4;
	Fri, 27 Apr 2012 08:03:46 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9F2F2E125C; Fri, 27 Apr 2012 08:03:45 -0700 (PDT)
In-Reply-To: <20120427081220.GC12092@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 27 Apr 2012 04:12:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQk1lPcbcJFoB4+e3kMftARBPgT8yjDq5ZyvXTYs1yxaQ9hjWU5iqlE8tnP+nD9xiLKOR2vgbQbtTpZmQkj0mkMg3TQXADNJ0TknShzP3+Q7w0XD5TncFYjP/A8NfY5BhzR/JAtakHMPggoyAJOrZMduVEXfboXRO3/K2DMn6iYbRoMOXOM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196474>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 26, 2012 at 08:18:58AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Don't we explicitly not want to do this when the protocol is http? Curl
>> > doesn't respect HTTP_PROXY.
>> 
>> Yes.  Here is what I'll queue.
>
> I had raised several other points in my (admittedly belated) review[1].
> So I was kind of expecting a re-roll rather than a patch on top. It was
> mostly readability issues, but there is also a potential segfault when
> the url has no protocol. I'm not sure it can happen in normal git use,
> but:
>
>   git remote-https url-without-protocol
>
> may dereference null (it's via snprintf, so on my system glibc magically
> rewrites this as "(null)_proxy", but other systems will segfault).
>
> -Peff
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/195443
>     http://article.gmane.org/gmane.comp.version-control.git/195445

Indeed.  Thanks for reminding me not to advance this beyond 'pu'.
