From: Maxime Coste <frrrwww@gmail.com>
Subject: Re: [PATCH] git-p4: Do not include diff in spec file when just
 preparing p4
Date: Sat, 24 May 2014 02:44:41 +0100
Message-ID: <20140524014441.GB29751@nekage>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat May 24 03:40:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo0wq-0006Id-LC
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 03:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbaEXBk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 21:40:29 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56258 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbaEXBk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 21:40:28 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so1821227wib.5
        for <git@vger.kernel.org>; Fri, 23 May 2014 18:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nsiROI71FsIpxEjWMiADmCBG1ADPG4Tesx2H9BsZEuU=;
        b=nAoHiRmCoX6epAJ9d2IJRtLchHORPD06h9DKC8duU+hVhFtp9O66jJVQdWVxwbSgIp
         A13ZARRnfaYG4fPsrpRHICuLONxt654ya0eUzWbJHtufN9lmv4ZCIRSiSVTTHqFLwyhx
         zZhZqMzzLDwoFWuy+LxDvJoiyvukHMMcHa4Aa5rmxDk8KYRdeBkbD0rWw3GFdWUzRiZ5
         ++vEnY8kbO3YKQnEQFlc3JWf71pZJLyr9tkZnTTdLMa7A3KyiMLxpN91LV5llZJTJt7E
         xMZYbdWWsqZk7+3OKDo6ivY0WkK4CP9E+5EXQYq1Bv05ZoUd2SgEzu6Iaem1b2/QTBet
         gNWg==
X-Received: by 10.195.12.34 with SMTP id en2mr2937746wjd.13.1400895627310;
        Fri, 23 May 2014 18:40:27 -0700 (PDT)
Received: from localhost ([109.255.47.65])
        by mx.google.com with ESMTPSA id l4sm6748783wjf.14.2014.05.23.18.40.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 May 2014 18:40:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140524013942.GA29751@nekage>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250050>

Hello

Sorry for the delay, I hope that version is more acceptable.

I updated the test case as well, but did not manage to get the actual p4
tests to work here (I have p4 and p4d installed, they start but all the
other tests seems to fail). Still the change is straightforward.

Cheers,

Maxime Coste.
