From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Thu, 10 Mar 2011 04:18:42 -0600
Message-ID: <20110310101842.GE26851@elie>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: libgit2@librelist.com
X-From: git-owner@vger.kernel.org Thu Mar 10 11:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxcxJ-0003lW-Mh
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 11:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab1CJKSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 05:18:48 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36639 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1CJKSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 05:18:48 -0500
Received: by gwaa18 with SMTP id a18so353599gwa.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R6rfu6C01uQXG2vo//zGcAQtp8V1YAN/pZeEq6DWOAM=;
        b=ZiXFXols43HwbF4vJq/T8gnGRE5nOtKD/2A7G8E/PV2IWea6KUpeTkg2BJFajKswr9
         TXlyvCDyU6fNyGlt+V1nZkC3bgtPhUnFaTMni3KOwVY0s9KjubQlk8rQoVHecACcOZcY
         j8CGXpT/qrlspGyV1190LiBcqCXbqEtjx1bZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cvHLMGT1FjVyMuN38D/jUM3MHBspKtvNPtaO9xMdtZ7cwJDulV5uT1JwYVc3CSP1QB
         V6wYAmQdpE8RAUB37acbVcR8rJbUcvBLAli48UmVmukZG4cryj0igff2TlEICp3futxm
         FAF/j/El89ZQl542jBH5O5C8nvXQ+r9fQOv0I=
Received: by 10.150.49.14 with SMTP id w14mr748058ybw.347.1299752326447;
        Thu, 10 Mar 2011 02:18:46 -0800 (PST)
Received: from elie (adsl-68-255-100-150.dsl.chcgil.ameritech.net [68.255.100.150])
        by mx.google.com with ESMTPS id 8sm2007262yhl.44.2011.03.10.02.18.44
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 02:18:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110310101332.GC26851@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168807>

(resending since my last mail was dropped; sorry for the noise)
Hey Vicent et al,

Vicent Marti wrote:

>                                                           there have
> been proposals to merge parts of libgit2 into the original Git client;
> however, this is not one of our priorities (we are designing git.git
> to be embeddable in Git backends and GUI programs), and the library is
> not yet stable enough for that kind of job. We'll see what the future
> brings -- git.git would certainly benefit from some of our code, if
> anything because it's (slightly) faster and cleaner than the original
> implementation.

I've been thinking that it would be interested to start this work
early on, partially so that libgit2 and git.git can get to know each
other better so to speak (which could help libgit2 along nicely and
help git get past some old limitations, I think).  So I'm thinking of
proposing stealing some of your code, with an eye toward eventually
making git "just another libgit2 user", as a Google summer of code
project idea.

Is that a sane idea?  Is there any particular subset of the lib that
would be an interesting place to start?  Do you forsee any obstacles?
Do you know anyone who might be interested in mentoring such a
project?

Admittedly I'm not so familiar with libgit2 yet, so I'm willing to
believe the answers might be no, no, yes, and no. ;-)

The Google Summer of Code application deadline is this Friday
(March 11) at 23:00 UTC.  If this does seem like a sane thing to do,
it might be nice to put it on the ideas page at:

  https://git.wiki.kernel.org/index.php/SoC2011Ideas

Thanks for your work.
Jonathan
