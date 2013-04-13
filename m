From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/2] doc/http-backend: match query-string in apache half-auth
 example
Date: Sat, 13 Apr 2013 10:52:17 +0200
Message-ID: <51691CC1.9070802@gmail.com>
References: <20130411033022.GA14462@sigill.intra.peff.net> <20130411033613.GB14551@sigill.intra.peff.net> <5166E935.2080206@gmail.com> <20130411170233.GB1255@sigill.intra.peff.net> <20130413033336.GA20333@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Magnus Therning <magnus@therning.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 13 10:52:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQwCN-0005pe-4i
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 10:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab3DMIwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Apr 2013 04:52:24 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:36598 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab3DMIwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 04:52:22 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so1534843eei.6
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6r7gGLuiU/fhderol1WMA501R5ULnQKG+DJPttP5CCs=;
        b=mCc74jJDOWT5oE2Wp2GXY/K1ZXg1jTRjlIUPgAeC+tDtPMvCCY6MdD2wRUMb4WySPg
         zVeuFlzGqG7Zky0tAwCaY9XWZ4x571jXa3wqi3wVFvFOd3rQIyrzrJlc3qR+lSAMUQYu
         a7BYxYD49l7HjpVqbmVrZ4eqPVlTVNZ2LoSaw9iJ+oHehlpGRTLyaVte6Tdxc5bJ4r03
         +04VbZNvpVhWEgpuekqPBDrqvq4p5sTnIyUhSXJFvVib8wF+tDOGDRHMd0hnPbZpPfGT
         UmwXbCAcsPgGmhG6Cis/AimuHN612EVVlUbgKYUaVDKq7GpkzcCHxd4dPi/MoInjCBrn
         6x8A==
X-Received: by 10.14.182.137 with SMTP id o9mr37056383eem.13.1365843141380;
        Sat, 13 Apr 2013 01:52:21 -0700 (PDT)
Received: from [192.168.1.14] (eva238.neoplus.adsl.tpnet.pl. [83.20.198.238])
        by mx.google.com with ESMTPS id ca4sm15229676eeb.15.2013.04.13.01.52.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 01:52:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130413033336.GA20333@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221056>

W dniu 13.04.2013 05:33, Jeff King pisze:

> When setting up a "half-auth" repository in which reads can
> be done anonymously but writes require authentication, it is
> best if the server can require authentication for both the
> ref advertisement and the actual receive-pack POSTs. [...]

Thanks for writing(and testing) this patch.
--=20
Jakub Nar=C4=99bski
