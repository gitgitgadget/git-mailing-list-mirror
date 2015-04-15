From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 15:45:21 +0200
Message-ID: <1429105521.14175.0.camel@kaarsemaker.net>
References: <552E628C.7040809@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 15:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiNdD-0000O5-7s
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 15:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbbDONp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 09:45:27 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34131 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbDONpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 09:45:25 -0400
Received: by widjs5 with SMTP id js5so112275945wid.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 06:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=9/78OTsd3zdRLgY1NkDto8SxHywOYGgq6LLt/P8ku/g=;
        b=mWMu3vyWB4aJw4rZVqF+16qvydw+yQ7ATxAA9TitIEe1ZRKd//hao55M7uHfmaiDsa
         KHLCIe3qwHWhdVK0yKeJIdXCfCRuU4jWhh7YHA25ZOWQ9DnV9Rp2OGbbrlsl1v5eH3Rf
         ry4iQd8ulYZAZilYRjJLJbUFUQSriyg9EzramB8imnO1c3blrWW5pZvXjHloTGuOMjpZ
         IdCq5jyMkZbpyp5s6OsJ3k459mfMQVgs0eQiCquvCSwvHUNLx2GOKlRB9dzcu/jZLL17
         aN8zRP9EeISmnqnbPkLzGabiB0P2qCK/g0pf0sw2OOT5sCM+kvL7+9uuzQJqXyfpMq99
         bxTA==
X-Gm-Message-State: ALoCoQmbx1xBLGCD+1roqQmIHcPdPViq2HZe0psOY7+OlOTgLhK4zwTX7Db38HtMvghwux/hEPDN
X-Received: by 10.181.13.144 with SMTP id ey16mr17341419wid.38.1429105524526;
        Wed, 15 Apr 2015 06:45:24 -0700 (PDT)
Received: from spirit.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id az2sm6092789wjb.4.2015.04.15.06.45.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2015 06:45:23 -0700 (PDT)
In-Reply-To: <552E628C.7040809@debian.org>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267198>

On wo, 2015-04-15 at 18:37 +0530, Pirate Praveen wrote:
> Hi,
> 
>  When working with big projects over a slow, unreliable connection,
> currently there is no way to resume a clone or pull when the connection
> breaks. mosh is a better replacement for ssh over unreliable
> connections. supporting git+mosh protocol will go a long way in
> supporting people who work with unreliable, mobile networks, especially
> in developed countries (I personally have to try many times when working
> with large projects as my 3g mobile connection keeps dropping. I
> recently discovered mosh and it works like a charm. More about mosh
> https://mosh.mit.edu/

mosh isn't a generic transport though, it's a udp-based session state
synchronization protocol. I don't think it can be used as a git
transport.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
