From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Tue, 8 Feb 2011 16:05:05 -0600
Message-ID: <20110208220505.GA17981@elie>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <AANLkTi=Uqkzv+ucBzww6R1V+0ujmfH-dED8XJhyRvWQF@mail.gmail.com>
 <alpine.DEB.2.00.1102081320350.4475@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 23:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmvgX-0004iq-V7
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 23:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab1BHWFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 17:05:14 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64503 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab1BHWFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 17:05:13 -0500
Received: by gyb11 with SMTP id 11so2491457gyb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yRAo5E6LY4bPbWWp/dzuZVsfDGHpPgorGWumduj7ajI=;
        b=CGvs0xAUs2T6nh0lpsSaxVDyH/h0MIUh7IVLKUkFfWhlhWAInI4cX+/Ed8EOgWLhJr
         G8jDLQEEml4sD+xvZFLj1BEodPcy5OE4icO9UZ1MzUAFebRHd4OjbjiAzFx+qpudZleM
         Cw9C+p6XRgF6nIGd4j1T8KIvv+Ltt67r/knTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R2ROVfStJMeobldkzRNBCXMSMJznsc0MbeXx6K+DHnEyHbM5O9kazcvp7mkEJffj6e
         rWuFu2GRtdXUOOXugWfXrMSQxGbPVrTw3MRZeubBVm0QC9dtNYyqBgZ/BcQXMKgltWd9
         F0lSpRz6S3s5Hh1xwaVkAR79MSqBCrfM87NUA=
Received: by 10.151.84.8 with SMTP id m8mr698049ybl.276.1297202712198;
        Tue, 08 Feb 2011 14:05:12 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id k1sm1069ybj.0.2011.02.08.14.05.10
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Feb 2011 14:05:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1102081320350.4475@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166370>

Martin von Zweigbergk wrote:
> On Tue, 8 Feb 2011, Sverre Rabbelier wrote:

>> I particularly like that you explain to the user clearly what they
>> have to do to make this work (e.g., configure the upstream). Nice.
>
> Thanks, but that was stolen from git-pull.sh ;-)

Doesn't that suggest it might belong in some common git-upstream--lib.sh
(or git-sh-setup.sh)?
