From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 04:18:08 -0700
Message-ID: <ac9f0f090807310418r109b76bdq37cdfd0adc81f74d@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <20080731111446.GO32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:19:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOWBc-0005T1-Te
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 13:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYGaLSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 07:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbYGaLSK
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 07:18:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:55840 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYGaLSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 07:18:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so292754ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yuMwY5LAuiE9RjGgxFmNtr+/Oi/TaNvvUlT4P6ep2M4=;
        b=xV7qTX/SEDEazhnegoIAG6gaxj0vjKDxz5eghTkEnXAdazFP4tjVyEbhFGwzZ0cSte
         eztFak6VzlXa0V1CuoK9Le6L9f6Fp7B3pVcU8MmecH4DJsYfGPvqrz7ZhwX7LHdZ7y9m
         tE+s3ptQ74RNs9cpISI7Q7b5fmFqcNYqH23y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KGAiRFZmEkXFWs6PwgL6JssVAdQ7VNpYAP3Q9d6h2AVx+myf+xv7aK0WvGWG0o9D9r
         40Io8aZA2LnSxSxL6gTtIORzJ2U8Rof603wvIA7pMeCXB3DodE5WCr7M04NN8tY+1DmL
         PbVK2JyPH4HPTHInutcEjWCsg2DxwAk6Bjq3c=
Received: by 10.150.123.16 with SMTP id v16mr1046906ybc.40.1217503088181;
        Thu, 31 Jul 2008 04:18:08 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 04:18:08 -0700 (PDT)
In-Reply-To: <20080731111446.GO32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90930>

> What would be the reason to disallow C++ users? The costs aren't that
> high, and (modulo, say, extern "C" { }) there should be no C-C++
> compatibility issues, right?

Exactly. It works just great for me in XCode 3.1 on OS X.
