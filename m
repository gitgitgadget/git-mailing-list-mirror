From: "Thomas Hager" <duke@sigsegv.at>
Subject: Re: clone URL missing in gitweb
Date: Wed, 18 Jul 2012 08:58:53 +0200
Message-ID: <20120718085853.1702340b2uu0gmnh@webmail.moger.at>
References: <1342591638170-7563176.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOdr-0004x1-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab2GRHZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:25:47 -0400
Received: from minbar.sigsegv.at ([83.64.197.38]:49076 "EHLO minbar.sigsegv.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230Ab2GRHZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:25:45 -0400
X-Greylist: delayed 1611 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2012 03:25:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sigsegv.at; s=default;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:References:Subject:To:From:Date:Message-ID; bh=hcAMaAI0lebALEGaHB45T053mPon5htDMBrknLE870Q=;
	b=gRLjTTp13Qv8w14vEfit3qrEPYo7z0sYnZL5665gZ1kSudxiI8zyvepWPAU06T2curPT4G/kbqzOHKFVdeKQNy/YYiq2rGgRtkU7TKcwXmBp+wyLro3ujK+XdmKmm01O0Uye9LU9qBKV8kWps0Z4KVG7MtxS/nwP3Kn2u5kpBE8+nlDQGSmYPZbvxh3Kmbf6LNRRtn7GALT52Qt7chu/MHYfS7QupmJV8JVR4h/MSDWoya8hW6ljqH4hwBklswyA4BetNg+i6W/KFwCiHak1TBV4V2xSz8iKVynsQZbt6Huh/JdU0cB8LVks2QO/NXnKMZEGexa/0S+U5PxCQuSDSg==;
In-Reply-To: <1342591638170-7563176.post@n2.nabble.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201657>

Quoting baluchen <murugan.bala@gmail.com>:
> Hi,
hi,

> But in my setup i coould not find "cloaning" option
cloneurl is a "per repository" option, which is set as config option  
in your repository. see "man gitweb" for details.

what you're probably searching for is the global option  
"git_base_url_list", which is used by gitweb to generate the clone URLs.

hth,
tom.

-- 
Thomas "Duke" Hager                               duke@sigsegv.at
GPG: 2048R/791C5EB1            http://www.sigsegv.at/gpg/duke.gpg
=================================================================
"Never Underestimate the Power of Stupid People in Large Groups."
