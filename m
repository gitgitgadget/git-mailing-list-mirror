From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Makefile: Improve compiler header dependency check
Date: Tue, 30 Aug 2011 03:33:33 -0500
Message-ID: <20110830083311.GB23643@elie.gateway.2wire.net>
References: <20110830040515.GC6647@elie.gateway.2wire.net>
 <1314692855-75113-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 10:33:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyJlX-0004eY-KG
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 10:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab1H3Idp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 04:33:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35185 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab1H3Ido (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 04:33:44 -0400
Received: by gya6 with SMTP id 6so5435898gya.19
        for <git@vger.kernel.org>; Tue, 30 Aug 2011 01:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WD/XZKYLm7qG5LSOxMcLtl/y/ZEYNUan9s47w5pr3nI=;
        b=bH1F2MyiAZHe6ZeRZpoLtZrAfO7AHXYaj9Wb06NPFqG7TkNK6cJdxUY7+ohOR6Bfke
         qjJcvc/BOjspJ8zS7djmlsQBuytJFmF4gdWcWZR3REuKwrATn3V6QVjRVS06qsfEtNLY
         E8lYF1IgbqVndnF8lvtDLdr3jovbNOJsihgB0=
Received: by 10.43.134.72 with SMTP id ib8mr5552610icc.94.1314693223887;
        Tue, 30 Aug 2011 01:33:43 -0700 (PDT)
Received: from elie.gateway.2wire.net ([69.209.62.70])
        by mx.google.com with ESMTPS id j4sm6438782icx.3.2011.08.30.01.33.42
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 01:33:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314692855-75113-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180395>

David Aguilar wrote:

> The Makefile enables CHECK_HEADER_DEPENDENCIES when the
> compiler supports generating header dependencies.
> Make the check use the same flags as the invocation
> to avoid a false positive when user-configured compiler
> flags contain incompatible options.
>
> For example, without this patch, trying to build universal
> binaries on a Mac using CFLAGS='-arch i386 -arch x86_64'
> produces:
>
> 	gcc-4.2: -E, -S, -save-temps and -M options are
> 	not allowed with multiple -arch flags
>
> Make the check use the same flags as the invocation to avoid
> false positives when user-configured compiler flags contain
> incompatible options.

What happened with this third paragraph?  It seems to repeat
the first one...
