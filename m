From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 09:39:45 -0800 (PST)
Message-ID: <m339mu7u6n.fsf@localhost.localdomain>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
	<20110303185918.GA18503@sigill.intra.peff.net>
	<AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
	<20110303203323.GA21102@sigill.intra.peff.net>
	<20110309174956.GA22683@sigill.intra.peff.net>
	<AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com>
	<20110309215841.GC4400@sigill.intra.peff.net>
	<20110310001017.GA24169@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 18:39:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxjq6-0003T1-2b
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 18:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab1CJRjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 12:39:48 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63259 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab1CJRjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 12:39:48 -0500
Received: by bwz15 with SMTP id 15so2018962bwz.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 09:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=oWM0LSAlyTob0p4bgj/BL4cK8dy19TmpghTsB2flzTQ=;
        b=ietK4sYXxu8n/z9fqG+7L4fFeFs3sP5sP8MxYIm1Hlq+r+L95qqmkdnv2VlSgwP9jU
         l8VOX60QhNH9WYnGkuEDnNLZXpMrdGHOnd6gXznxxXbi14UQm9wUtqzg6RAOty05+IzT
         HVKzIaMWXXKw79BDBSlOGWTzcc+Y2LxEX92tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Gak95igQts9u6f1cTBUhlQ6lUzTIvAljLdG9hNoO6DozcbW7jTBcTXRZAsPrVhBtay
         Ld8k6TMZ1r9VXEHG08ohHgxF0aFTVrQnk7+XrXdZTEk07q89oWlAQwHCjxIIofildfTO
         u62lZ5lRg6nPBMTp/dT+S8jPhlWFt0yUTuCGs=
Received: by 10.204.170.130 with SMTP id d2mr7071797bkz.116.1299778786579;
        Thu, 10 Mar 2011 09:39:46 -0800 (PST)
Received: from localhost.localdomain (abwi220.neoplus.adsl.tpnet.pl [83.8.232.220])
        by mx.google.com with ESMTPS id z18sm669120bkf.20.2011.03.10.09.39.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 09:39:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2AHckau011431;
	Thu, 10 Mar 2011 18:38:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2AHc56Y011424;
	Thu, 10 Mar 2011 18:38:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110310001017.GA24169@elie>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168837>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 4. filter-branch killer: using fast-import's new features to implement
>    common filter-branch operations (--subdirectory-filter,
>    --prune-empty, obliterating certain files) faster.

How it would be different from existing reposurgeon tool by ESR
(cross-VC thanks to using fast-import format), or git_fast_filter by
Elijah Newren (more of a library than a ready tool)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
