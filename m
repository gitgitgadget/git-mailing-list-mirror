From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFH] 'man:' macro for asciidoc
Date: Sat, 03 Mar 2012 10:33:36 -0800 (PST)
Message-ID: <m31up9v8jo.fsf_-_@localhost.localdomain>
References: <20120303145053.GA29948@ecki>
	<20120303174252.GC28602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tmA-0006qC-Dy
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 19:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2CCSdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 13:33:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63449 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab2CCSdh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 13:33:37 -0500
Received: by eaaq12 with SMTP id q12so952251eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 10:33:36 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.8.79 as permitted sender) client-ip=10.213.8.79;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.8.79 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.8.79])
        by 10.213.8.79 with SMTP id g15mr314331ebg.108.1330799616637 (num_hops = 1);
        Sat, 03 Mar 2012 10:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wHPqHtMnjoOvTB7a3q7CI+wUGGF9wGIPJyLssdR/chw=;
        b=oKcTpP61qNxSR7yiPlzp5pylJRZfUSse0bJdfouqo7POQ4FyaMVUTyoaGOJcbm2MA4
         idmzqTI1zwUbadibNRdFT8VoR0kdaL3LmCrr6SFHadL4MJD3TNiRBHueij+Dcy2GPZ8L
         nK5zyScIZReozGlgZ6jkyd8T1zPxLlAiYmNNPUvmqnDZwP3oaexAvTmf4c/s/ZftNsJJ
         JqwOQceJwqrfBuRnlEFj80tgPHKELgs6VrWrhdcH3WTq8rkyZhhXKzE4BvsJ6E89RbQB
         vwMW0dHFP2GOYjsfQsSIPsg5yfR2gmhlIsUx9FuDUe4WIaPmEGPBiu/4zfqe8D/aGpVh
         ZklA==
Received: by 10.213.8.79 with SMTP id g15mr229001ebg.108.1330799616515;
        Sat, 03 Mar 2012 10:33:36 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id n17sm37331077eei.3.2012.03.03.10.33.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 10:33:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q23IXX1f023426;
	Sat, 3 Mar 2012 19:33:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q23IXVKj023423;
	Sat, 3 Mar 2012 19:33:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120303174252.GC28602@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192129>

Jeff King <peff@peff.net> writes:
> On Sat, Mar 03, 2012 at 03:50:53PM +0100, Clemens Buchacher wrote:

> >  http.proxy::
> > -	Override the HTTP proxy, normally configured using the 'http_proxy'
> > -	environment variable (see linkgit:curl[1]).  This can be overridden
> > -	on a per-remote basis; see remote.<name>.proxy
> > +	Override the HTTP proxy, normally configured using the 'http_proxy',
> > +	'https_proxy', and 'all_proxy' environment variables (see
> > +	linkgit:curl[1]).  This can be overridden on a per-remote basis; see
> > +	remote.<name>.proxy
> 
> Text looks OK. I think this linkgit:curl is wrong, though. In the
> manpages, it formats as simply curl(1), but in the HTML pages, it
> creates a link to curl.html, which does not exist. This is not a problem
> introduced by your patch, obviously, but maybe it is worth cleaning up.
> I think just using:
> 
>   `curl(1)`
> 
> might be sufficient.

BTW it wouldreally be nice be able to use simply  man:curl[1]  instead
of worrying if it shoudl be `curl(1)`, or *curl*(1), or curl(1)


-- 
Jakub Narebski
