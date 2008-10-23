From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] Fixed git archive for bare repos
Date: Wed, 22 Oct 2008 21:37:03 -0400
Message-ID: <20081023013703.GE2015@riemann.deskinm.fdns.net>
References: <20081022210913.GB22541@hashpling.org> <1224712023-5280-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>,
	gitster@pobox.com
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Oct 23 03:41:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KspCt-0006fb-1z
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 03:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbYJWBkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 21:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYJWBkb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 21:40:31 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37469 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbYJWBka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 21:40:30 -0400
Received: by gxk9 with SMTP id 9so553270gxk.13
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=UkxjvS88FWDFGdkpl1E/uY+Vf3vo7/0ZomOavYqXg2o=;
        b=H3mL1hBTKVYx8ca4FSyyrkn27Pd7uf80mnjNFO0j0UesmH1fWpkvvzYl+znkPWMu90
         h9ZsWSwQ9s70asBw+unC2eeiDt/dTgMDN48A8/ly2VBaLJZRcLSZaqHdujXGiOWZosyJ
         ksbxf9zYpCdSq2jPOY2v4GWEM7zKL/dfv1sMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=NyDY0pxrf3EoWhzgtUgc0zNTCk7oe2rND+pXUTh+rRQdaaapmJM5+sJZgiMI7XcR68
         dBEgOG6/1iZd4XDwXyjG6FIt+dOzaWqz8mXu3Ucnfz7N2AhggVl7Muo5UHU1WqXk3+IP
         5FH1jUWaM76gmzXxdxCTK2QLBVYWNGDJ7OrEs=
Received: by 10.65.121.14 with SMTP id y14mr9379914qbm.84.1224726028912;
        Wed, 22 Oct 2008 18:40:28 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id s27sm14805541qbs.12.2008.10.22.18.40.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Oct 2008 18:40:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1224712023-5280-1-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98939>

On Wed, Oct 22, 2008 at 10:47:03PM +0100, Charles Bailey wrote:
> OK, I've had a chance to have a quick look at this issue and I have an
> altenative patch.

Thanks for making this much simpler than my version was; it passes the testcase
I wrote, as well as the rest of the testsuite, so if you want to include my
testcase (or an equivalent one) and re-send, consider it

Tested-by: Deskin Miller <deskinm@umich.edu>
