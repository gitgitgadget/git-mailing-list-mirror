From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2 v5] Git.pm: add test suite
Date: Thu, 19 Jun 2008 13:53:20 -0700 (PDT)
Message-ID: <m3lk11m9j7.fsf@localhost.localdomain>
References: <1244a3347b6f15120e57f6b9223a4e2db06479df.1213899000.git.LeWiemann@gmail.com>
	<1213907569-6393-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lea Wiemann <LeWiemann@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9R97-0005cW-Vz
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYFSUxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 16:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYFSUxW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:53:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:15054 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYFSUxW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 16:53:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5344723rvb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=TWLowIKiALS8rZyA51dfEmuXWxlOUNEUil83Q0FoIhg=;
        b=QzcO8dxMFNRBfGBWUe4EdZdtUT+ZX7PC6TNYTGSdHtJZTX/lYY7pHpEWtxFiXf6MLv
         GS+qtvvFySOwZ6tF4W2Dd7ZVEpUV/T3HK4TEEhgG/JFfQFqLecPeyQQGJYbUEIcXKN32
         cD2GUK5ieoa3Bn/NKBG3KHFGyAUIBCtvNwv6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=NU254iacdKEdLI+q+jMC6YqnTAdSPvsrfBKbA0U/Z/G1wwxcaCiUxEFhT6hIrycI/G
         q5WJL2Dpk9fFu0kqQpVxxD7f877lCTCgiWVaoSmV18qL3gnKoVS6uPBGD/qYEHb+j/hh
         LWAfdeJUqqEIyipQhlzACUpY55AjuCa69fgkk=
Received: by 10.141.197.8 with SMTP id z8mr6977283rvp.157.1213908801590;
        Thu, 19 Jun 2008 13:53:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.161])
        by mx.google.com with ESMTPS id i27sm2107676elf.11.2008.06.19.13.53.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 13:53:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5JKrIRb001883;
	Thu, 19 Jun 2008 22:53:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5JKrHaP001880;
	Thu, 19 Jun 2008 22:53:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213907569-6393-1-git-send-email-LeWiemann@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85526>

Lea Wiemann <lewiemann@gmail.com> writes:

> Changes since v4:
> 
> - Use 5.006002 (lowest possible version for Test::More).

[...]
>      #!/usr/bin/perl
>      use lib (split(/:/, $ENV{GITPERLLIB}));
> 
>     +use 5.006002;  # Test::More was introduced in 5.6.2

Isn't "use Test::More" enough, so this line is not strictly
necessary?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
