From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3] gitk: Use git-difftool for external diffs
Date: Tue, 30 Mar 2010 19:06:24 -0700
Message-ID: <20100331020623.GB23545@gmail.com>
References: <1269726316-30443-1-git-send-email-davvid@gmail.com> <1269735600-12769-1-git-send-email-davvid@gmail.com> <201003281259.06947.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 31 04:14:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwnRs-0004pS-1h
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 04:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999Ab0CaCOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 22:14:22 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:47852 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757996Ab0CaCOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 22:14:21 -0400
Received: by gxk27 with SMTP id 27so5268666gxk.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h2AYz2TddJWoHOEA+Mt8JzZcEkS1wK9Wex0kdsAgotY=;
        b=F4BZWM9+CxzPO7jaGaKMtByge9heqEC4wZU66Pnin0Uh3/5ksAnjaKlMrtaKyvh85x
         aNEGCXkKNlWjdRmJtCrMSL37A+hHeEl+yMROZVpC5E6ZhlHEMqXImX29KtMc1N263gE2
         Sew1ZV3fogcE1KghMnJjsqNLFMEILll7VGsTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I+VCTPHjl1qP7HvfkNYDsK4n391RtuCnq2UGDKQeHVqphiGxUVNjYvXG1p6Djr3yTH
         1QRFl7iPgRthkrf68eQInYxQG3rx/ohMCGUgWU3E6vCq65Rxcj5i1FLUJLB8nzTusrZK
         BNc++3sNId0OwCRrdk811SaVaadUN72pI9A30=
Received: by 10.101.136.33 with SMTP id o33mr9371334ann.63.1270001189718;
        Tue, 30 Mar 2010 19:06:29 -0700 (PDT)
Received: from gmail.com (wdas-1.disneyanimation.com [198.187.190.1])
        by mx.google.com with ESMTPS id a1sm6259922ibs.6.2010.03.30.19.06.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 19:06:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201003281259.06947.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143634>

On Sun, Mar 28, 2010 at 11:59:06AM +0100, Markus Heidelberg wrote:
> David Aguilar, 2010-03-28 01:20:
> > +    set cmd [list "git" "difftool" "--no-prompt" "--extcmd" $extdifftool]
> 
> According to "man gitcli" this should be "--extcmd=$extdifftool".
> 
> Besides this, works for me.
> 
> Markus

I'll send a v4 with this change.
Thanks for the review.

-- 
		David
