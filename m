From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Mon, 3 Mar 2008 23:52:48 +0100
Message-ID: <200803032352.48614.jnareb@gmail.com>
References: <20080303221159.GA6875@hashpling.org> <200803032333.29426.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJX5-0004WW-9Y
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbYCCWwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754622AbYCCWwl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:52:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:19120 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbYCCWwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:52:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so209446nfb.21
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=bOsi7xKdrp3ar8dWj+1Y057U2wlwaU1PQ7lnlQ86Ed0=;
        b=iAGsMoIHsq6fDQM8GX+onj0eGTinQlBdYbFKqJfKaXcXYO+OIucRhyhL7mWCQusediiooA2DkL6b1chqBwvKB/ecq6tOBihWKG5HugnK5kdNhd/4kxw3Et8vCLQiKJm2rZoOEDvRMTGW++h1pDtcAlw9QsIX/MKUmSEH8k1GRyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Py5HEhFoDns1x9gac1zUTvyXiIp8uMmdFaQKSNFLSsMhLd0SnAiZ/9GRVulScE/Qqleymu9NlZASUHrVE1MuwuOc6PoXnoJwXp7YqrqziCKGJeQMwObprf0z6xyMIM1u+irV3KiyqQLiiPeHU1++eyM+rHL2vW4/cbYVQJ9y9hY=
Received: by 10.82.148.7 with SMTP id v7mr349140bud.37.1204584756845;
        Mon, 03 Mar 2008 14:52:36 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.251.32])
        by mx.google.com with ESMTPS id h6sm558078nfh.30.2008.03.03.14.52.34
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 14:52:35 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200803032333.29426.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75993>

Jakub Narebski wrote:

> +our $tabstop_width;
> 
> I think I would write "our $tabstop_width = 8;" here.

I'm sorry. Please drop this part. Seting it to undef is needed
if it is used as cache (as: not read in), while if we use %config
it is simply not needed.

-- 
Jakub Narebski
Poland
