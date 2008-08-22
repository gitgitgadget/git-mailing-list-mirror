From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] Debian packaging update
Date: Fri, 22 Aug 2008 22:57:02 +0100
Message-ID: <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
	 <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
	 <20080822235154.5e1f979c@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
To: "Daniel White" <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWee2-0007ZH-E2
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbYHVV5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757537AbYHVV5F
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:57:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:24070 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYHVV5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:57:04 -0400
Received: by yx-out-2324.google.com with SMTP id 8so410348yxm.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QDXxLXWhMBbYdWvcQyXwkfHkHxYxT0MeDJTGpnEDS0k=;
        b=gjJiop6jMbjFlBvQJ+nvg4T/iy0QX0QpHTk3R/9zw9BxXXso3fmSwtMgxRSQAplosJ
         ZSBPKomE6V70t/Iyii2HJJ6l7+ZktF/3fpYd/vIW/tbOXlEvQ34l/oMTSqPHQe/0XVPK
         IvC+nCdmC/S5B6JGDmvGylwSjoDHd1hzdrj2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MCHIKTdv+IG9okpLQDaEAXS4NKK3CllmrYC8XJCupTqvVEuIftf8Tg/t2BPYMpv2/K
         kbQ+m/2mb812iCfw00l+f9XhFSnS1wzLUSY1akZAdANNhhoeYKdgOvyrspQQeV/0G1Jj
         v3RC6lyBOmWIij4ZI0z9qwmbABWvEf0iEEATI=
Received: by 10.114.166.1 with SMTP id o1mr1593084wae.119.1219442222496;
        Fri, 22 Aug 2008 14:57:02 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 22 Aug 2008 14:57:02 -0700 (PDT)
In-Reply-To: <20080822235154.5e1f979c@whitehouse.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93381>

2008/8/22 Daniel White <daniel@whitehouse.id.au>:
> Since it is now packaged by Debian is it still necessary to be
> maintaining Debian packaging?

This is mainly to make it easier for Debian maintainers. Someone might
also want to build a .deb package for a different version or flavour
of Debian.

> Having a look at the Debian version, they have made quite a few changes
> against our packaging.  It might be worth getting some patches from
> them that are not specific to Debian policy (like the setup of bash
> completion).

I don't follow the Debian package much but I'll have a look to see the
differences.

-- 
Catalin
