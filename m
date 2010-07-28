From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 09:48:01 -0500
Message-ID: <AANLkTi=e37AGx-Pehe_PPn-0swxrf9Gowekm4cN80G1C@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com> 
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com> 
	<AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com> 
	<AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com> 
	<AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com> 
	<AANLkTiktuQV+jEOy+Shm13-LVc0W-d8qsGS6XuxyTW44@mail.gmail.com> 
	<AANLkTi=zgbT=uw=t18mBUHMxg050pMx_YD835Gbontph@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 16:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe7vs-0001iC-Hn
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 16:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0G1OsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 10:48:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43592 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261Ab0G1OsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 10:48:22 -0400
Received: by gwb20 with SMTP id 20so953284gwb.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GNaRYlPXwtoMpmjHyxv524zny68ZS7KxxWOTxYC0hNY=;
        b=YhTBA6LYMTlrykFUqkplULy5zE5BkJ2Su9JX34VqE/kUuYwW9dQJ1rqhhsAr7ncrT2
         EvZu9qQjU9PfEqrn0a2I+ST7618z7bELQ02F5YJw5r49jo4hVVwz8Rch3lAgbO+zbzOQ
         s9EtnPAjzPgi0yNFGs9OG5euiF0J9J8tcTGx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jwZLu9v59oFMkmlgyhNG/CHviixcTGx1VTLCLBoUsl+vJjAJ8rGm8slD+HmO7T7nzO
         CIdvAKIAYIHfwRx4J1iO2ns7P0lNVLHdwPUbm5lUDPgVVI5S+LSKBYbrzBXg1+2H07RV
         u9tglzU7th/pgaxfEIp9PO2B7ogaXxv1b4vrA=
Received: by 10.150.74.2 with SMTP id w2mr13230110yba.358.1280328501368; Wed, 
	28 Jul 2010 07:48:21 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Wed, 28 Jul 2010 07:48:01 -0700 (PDT)
In-Reply-To: <AANLkTi=zgbT=uw=t18mBUHMxg050pMx_YD835Gbontph@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152094>

Heya,

On Wed, Jul 28, 2010 at 02:59, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Doesn't assume-unchanged bit or sparse checkout help?

See my earlier part, assume-unchanged doesn't help due to the
gitignore files. Sparse checkout isn't an option since I really need
those files to be there, I just don't ever modify them. Really what I
need is read-only checkout ;). "Git, please ignore the existence of
this directory and all it's files/subdirectories, ktnx".

-- 
Cheers,

Sverre Rabbelier
