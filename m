From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] remove ARM and Mozilla SHA1 implementations
Date: Mon, 17 Aug 2009 22:49:15 -0700
Message-ID: <20090818054913.GB37966@gmail.com>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home> <alpine.LFD.2.00.0908172007590.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 07:49:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdHZX-0005Fz-D3
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 07:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZHRFtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 01:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZHRFtS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 01:49:18 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:41517 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbZHRFtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 01:49:17 -0400
Received: by pxi34 with SMTP id 34so1601982pxi.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 22:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=85dsfYg9AQz2c8MHgEOPP8xFM7Qk0+IYJ1c/RPAZUro=;
        b=ZsEbW5HYnpyGDNGT5JxQhFRFG3iNZFGazTtaCCjeQ2ta+SpLj6F9vqIS4ti+7Z+/tg
         u/aPiaBbxS2276KRxbiRS3mdTtjhAwqro9Z1J/IDCjjIsiTnAZytuze0xXfFdkO42s1d
         8GpdjXQDTDwQgbpMw59L3kHgbU53jjPXp3KhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BF28oQC2Z+jO3+qI/Gg9obwHIAQ2SWlr/IQJI1xxdfpGkGRZAoP33foxYpnqE+A5OV
         /7glFHLRFgHlgqhn9lFg+9/1EM/o+/BG25/hx//69NI/WyhW9VVWtzIAI8trgxYdI59a
         IYjpsunclhJ5r6WQF5leos9FoGgL9BDRVgl/8=
Received: by 10.115.134.8 with SMTP id l8mr5311891wan.97.1250574558724;
        Mon, 17 Aug 2009 22:49:18 -0700 (PDT)
Received: from gmail.com (adsl-68-123-238-19.dsl.irvnca.pacbell.net [68.123.238.19])
        by mx.google.com with ESMTPS id j39sm11706793waf.10.2009.08.17.22.49.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 22:49:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908172007590.6044@xanadu.home>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126350>


On Mon, Aug 17, 2009 at 08:09:56PM -0400, Nicolas Pitre wrote:
> 
>  Makefile            |   26 +------
>
> -ifneq (,$(findstring arm,$(uname_M)))
> -	ARM_SHA1 = YesPlease
> -	NO_MKSTEMPS = YesPlease
> -endif

When I added NO_MKSTEMPS I was being conservative when defining
it on arm (I wasn't able to test that platform).
Looks like it wasn't needed afterall.

Thanks.

-- 
		David
